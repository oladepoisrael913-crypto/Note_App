import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Search text state
final searchProvider = StateProvider<String>((ref) => '');

// Sort option state
final sortByProvider = StateProvider<String>((ref) => 'updatedAt');

// Notes stream provider - auto-disposed when not in use
final notesStreamProvider =
    StreamProvider.autoDispose<List<QueryDocumentSnapshot>>((ref) {
  final sortBy = ref.watch(sortByProvider);
  final notesRef = FirebaseFirestore.instance.collection('notes');

  return notesRef
      .orderBy(sortBy, descending: true)
      .snapshots()
      .map((snap) => snap.docs);
});

// User notes count provider
final notesCountProvider = FutureProvider<int>((ref) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('notes').count().get();
  return snapshot.count ?? 0;
});
