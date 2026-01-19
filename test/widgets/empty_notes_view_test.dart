import 'package:flutter_test/flutter_test.dart';
import 'package:mini_app/widgets/empty_notes_view.dart';

void main() {
  group('EmptyNotesView Widget Tests', () {
    testWidgets('EmptyNotesView displays message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyNotesView(
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('No notes yet'), findsOneWidget);
      expect(find.text('Tap to create one'), findsOneWidget);
    });

    testWidgets('EmptyNotesView calls onTap when text is tapped',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyNotesView(
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap to create one'));
      await tester.pumpAndSettle();

      expect(tapped, true);
    });
  });
}
