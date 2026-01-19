import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_app/add/editNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_app/providers.dart';
import 'package:mini_app/widgets/search_and_sort_bar.dart';
import 'package:mini_app/widgets/note_card.dart';
import 'package:mini_app/widgets/empty_notes_view.dart';
import 'login_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<bool> deleteNote(
    BuildContext context,
    String noteId,
    Map<String, dynamic> noteData,
  ) async {
    await FirebaseFirestore.instance.collection('notes').doc(noteId).delete();

    if (!context.mounted) return true;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Note deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            FirebaseFirestore.instance.collection('notes').add({
              'title': noteData['title'],
              'content': noteData['content'],
              'createdAt': noteData['createdAt'],
              'updatedAt': FieldValue.serverTimestamp(),
            });
          },
        ),
      ),
    );

    return true;
  }

  void _navigateToEditNote(
    BuildContext context,
    String oldTitle,
    String oldContent,
    String? noteId,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditNotePage(
          oldTitle: oldTitle,
          oldContent: oldContent,
          onSave: (title, content) {
            if (noteId == null) {
              // Create new note
              FirebaseFirestore.instance.collection('notes').add({
                'title': title,
                'content': content,
                'createdAt': FieldValue.serverTimestamp(),
                'updatedAt': FieldValue.serverTimestamp(),
              });
            } else {
              // Update existing note
              FirebaseFirestore.instance
                  .collection('notes')
                  .doc(noteId)
                  .update({
                'title': title,
                'content': content,
                'updatedAt': FieldValue.serverTimestamp(),
              });
            }
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchProvider).toLowerCase();
    final notesAsync = ref.watch(notesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          const SearchAndSortBar(),
          Expanded(
            child: notesAsync.when(
              data: (allNotes) {
                // Filter notes based on search text
                final filteredNotes = searchText.isEmpty
                    ? allNotes
                    : allNotes.where((note) {
                        final data = note.data() as Map<String, dynamic>;
                        final title =
                            (data['title'] ?? '').toString().toLowerCase();
                        final content =
                            (data['content'] ?? '').toString().toLowerCase();
                        return title.contains(searchText) ||
                            content.contains(searchText);
                      }).toList();

                if (filteredNotes.isEmpty) {
                  return EmptyNotesView(
                    onTap: () => _navigateToEditNote(context, '', '', null),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    // Refresh the notes stream
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      final data = note.data() as Map<String, dynamic>;

                      return NoteCard(
                        note: note,
                        data: data,
                        onDelete: () => deleteNote(context, note.id, data),
                        onEdit: () => _navigateToEditNote(
                          context,
                          data['title'] ?? '',
                          data['content'] ?? '',
                          note.id,
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red.shade600,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text('Error: ${error.toString()}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(notesStreamProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEditNote(context, '', '', null),
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
