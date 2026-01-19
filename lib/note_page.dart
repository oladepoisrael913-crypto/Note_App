// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'add/editNote.dart';

// class NoteDetails extends StatefulWidget {
//   final String docId;
//   final String title;
//   final String content;

//   const NoteDetails({
//     super.key,
//     required this.docId,
//     required this.title,
//     required this.content,
//   });

//   @override
//   State<NoteDetails> createState() => _NoteDetailsState();
// }

// class _NoteDetailsState extends State<NoteDetails> {
//   late TextEditingController titleController;
//   late TextEditingController contentController;

//   final CollectionReference notesRef = FirebaseFirestore.instance.collection(
//     'notes',
//   );

//   @override
//   void initState() {
//     super.initState();

//     titleController = TextEditingController(text: widget.title);
//     contentController = TextEditingController(text: widget.content);
//   }

//   // UPDATE NOTE IN FIRESTORE
//   Future<void> updateNote(String newTitle, String newContent) async {
//     await notesRef.doc(widget.docId).update({
//       'title': newTitle,
//       'content': newContent,
//     });

//     // UPDATE UI
//     setState(() {
//       titleController.text = newTitle;
//       contentController.text = newContent;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Theme.of(context).colorScheme.onPrimary,
//         centerTitle: true,
//         title: const Text(
//           "Note Details",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => AddEditNotePage(
//                     oldTitle: titleController.text,
//                     oldContent: contentController.text,
//                     onSave: (newTitle, newContent) async {
//                       await updateNote(newTitle, newContent);
//                       Navigator.pop(context); // Close edit page
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),

//       // BODY
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 // TITLE FIELD (READ ONLY)
//                 TextField(
//                   controller: titleController,
//                   readOnly: true,
//                   decoration: const InputDecoration(
//                     labelText: "Note Title",
//                     labelStyle: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     border: InputBorder.none,
//                   ),
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // CONTENT FIELD (READ ONLY)
//                 Expanded(
//                   child: TextField(
//                     controller: contentController,
//                     readOnly: true,
//                     maxLines: null,
//                     expands: true,
//                     decoration: const InputDecoration(
//                       labelText: "Note Content",
//                       labelStyle: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
