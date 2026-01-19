import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_app/widgets/note_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('NoteCard Widget Tests', () {
    final mockNote = _MockQueryDocumentSnapshot();
    final mockData = {
      'title': 'Test Note',
      'content': 'This is test content',
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    };

    testWidgets('NoteCard displays title correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteCard(
              note: mockNote,
              data: mockData,
              onDelete: () {},
              onEdit: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Note'), findsOneWidget);
    });

    testWidgets('NoteCard displays content preview',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteCard(
              note: mockNote,
              data: mockData,
              onDelete: () {},
              onEdit: () {},
            ),
          ),
        ),
      );

      expect(find.text('This is test content'), findsOneWidget);
    });

    testWidgets('NoteCard calls onEdit when tapped',
        (WidgetTester tester) async {
      bool onEditCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteCard(
              note: mockNote,
              data: mockData,
              onDelete: () {},
              onEdit: () => onEditCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(onEditCalled, true);
    });

    testWidgets('NoteCard handles empty title gracefully',
        (WidgetTester tester) async {
      final emptyData = {
        'title': '',
        'content': 'Content without title',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteCard(
              note: mockNote,
              data: emptyData,
              onDelete: () {},
              onEdit: () {},
            ),
          ),
        ),
      );

      expect(find.byType(NoteCard), findsOneWidget);
    });

    testWidgets('NoteCard has dismissible widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteCard(
              note: mockNote,
              data: mockData,
              onDelete: () {},
              onEdit: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Dismissible), findsOneWidget);
    });
  });
}

class _MockQueryDocumentSnapshot extends QueryDocumentSnapshot {
  @override
  String get id => 'test-note-id';

  @override
  dynamic get(Object key) => null;

  @override
  dynamic operator [](Object key) => null;

  @override
  bool containsKey(Object key) => false;

  @override
  dynamic getNestedField(String field) => null;

  @override
  Map<String, dynamic> data() => {};

  @override
  Map<String, dynamic> get metadata => {};
}
