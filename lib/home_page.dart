

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mini_app/add/editNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/textfield.dart';
import 'login_page.dart';

// Providers
final searchProvider = StateProvider<String>((ref) => '');
final sortByProvider = StateProvider<String>((ref) => 'updatedAt');

final notesStreamProvider =
    StreamProvider.autoDispose<List<QueryDocumentSnapshot>>((ref) {
  final sortBy = ref.watch(sortByProvider);
  final notesRef = FirebaseFirestore.instance.collection('notes');
  return notesRef
      .orderBy(sortBy, descending: true)
      .snapshots()
      .map((snap) => snap.docs);
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<bool> deleteNote(BuildContext context, String noteId,
      Map<String, dynamic> noteData) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete note?'),
        content: const Text('Are you sure you want to delete it?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance.collection('notes').doc(noteId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Note deleted'),
          persist: false,
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

    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchProvider).toLowerCase();
    final notesAsync = ref.watch(notesStreamProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('My Notes'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  final SignOut = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Logout')),
                      ],
                    ),
                  );
                  if (SignOut == true) {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                  SizedBox(width: 16);
                }),
          ]),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyTextfield(
              controller: TextEditingController(),
              hintText: "Search...",
              obscuretext: false,
              prefixIcon: Icons.search,
              onChanged: (value) =>
                  ref.read(searchProvider.notifier).state = value,
            ),
          ),

          // Sort buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () =>
                      ref.read(sortByProvider.notifier).state = 'createdAt',
                  child: const Text('Sort by Created')),
              TextButton(
                  onPressed: () =>
                      ref.read(sortByProvider.notifier).state = 'updatedAt',
                  child: const Text('Sort by Updated')),
            ],
          ),

          // Notes list
          Expanded(
            child: notesAsync.when(
              data: (allNotes) {
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
                  return Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditNotePage(
                            oldTitle: '',
                            oldContent: '',
                            onSave: (title, content) {
                              FirebaseFirestore.instance
                                  .collection('notes')
                                  .add({
                                'title': title,
                                'content': content,
                                'createdAt': FieldValue.serverTimestamp(),
                                'updatedAt': FieldValue.serverTimestamp(),
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text('No notes found. Tap to add a new note.',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      final data = note.data() as Map<String, dynamic>;

                      final createdAt =
                          (data['createdAt'] as Timestamp?)?.toDate() ??
                              DateTime.now();
                      final updatedAt =
                          (data['updatedAt'] as Timestamp?)?.toDate() ??
                              createdAt;
                      final createdStr =
                          DateFormat.yMMMd().add_jm().format(createdAt);
                      final updatedStr =
                          DateFormat.yMMMd().add_jm().format(updatedAt);

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 4.0),
                        child: Dismissible(
                          key: ValueKey(note.id),
                          direction: DismissDirection.horizontal,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Theme.of(context).colorScheme.primary,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (_) async =>
                              await deleteNote(context, note.id, data),
                          child: Padding( 
                            padding: const EdgeInsets.all(12),
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      data['title'] ?? 'No Title',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                            
                                    '${data['content'] ?? ''}\nCreated: $createdStr\nUpdated: $updatedStr'),
                                    
                                
                            
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddEditNotePage(
                                        oldTitle: data['title'] ?? '',
                                        oldContent: data['content'] ?? '',
                                        onSave: (newTitle, newContent) {
                                          FirebaseFirestore.instance
                                              .collection('notes')
                                              .doc(note.id)
                                              .update({
                                            'title': newTitle,
                                            'content': newContent,
                                            'updatedAt':
                                                FieldValue.serverTimestamp(),
                                              
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditNotePage(
                oldTitle: '',
                oldContent: '',
                onSave: (title, content) {
                  FirebaseFirestore.instance.collection('notes').add({
                    'title': title,
                    'content': content,
                    'createdAt': FieldValue.serverTimestamp(),
                    'updatedAt': FieldValue.serverTimestamp(),
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
