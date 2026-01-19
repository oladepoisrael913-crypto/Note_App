import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final notesProvider = StreamProvider.autoDispose<List<QueryDocumentSnapshot>>((ref) {
  final notesRef = FirebaseFirestore.instance.collection('notes');
  return notesRef
      .orderBy('updatedAt', descending: true) // default sorting
      .snapshots()
      .map((snapshot) => snapshot.docs);
});
