# Contributing to My Notes App

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Getting Started

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/Note_App.git
   cd Note_App
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Guidelines

### Code Style
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` for formatting:
  ```bash
  dart format lib test
  ```
- Run analyzer to check for issues:
  ```bash
  flutter analyze
  ```

### Project Structure
```
lib/
├── main.dart              # Entry point
├── providers.dart         # State management
├── pages/                 # Full-page widgets
├── widgets/              # Reusable widgets
├── components/           # UI components
└── theme/               # Themes
```

### Best Practices

#### State Management (Riverpod)
- Use `StateProvider` for simple state
- Use `StreamProvider` for async data
- Always use `autoDispose` for cleanup
- Centralize all providers in `providers.dart`

```dart
// ✅ Good
final myProvider = StreamProvider.autoDispose<List>((ref) {
  return stream;
});

// ❌ Avoid
final myProvider = StateProvider<List>((ref) => []);
```

#### Firebase Operations
- Always validate user auth before database operations
- Use proper security rules
- Handle errors gracefully

#### Testing
- Write widget tests for UI components
- Test provider logic with provider tests
- Aim for >80% code coverage

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

### Making Changes

1. **Create tests first** (TDD approach)
   ```bash
   flutter test test/your_test.dart
   ```

2. **Implement the feature**
   - Keep commits atomic and focused
   - Write clear commit messages

3. **Format and analyze**
   ```bash
   dart format lib test
   flutter analyze
   flutter test
   ```

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request**
   - Use the PR template
   - Reference any related issues
   - Describe your changes clearly

## Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widgets/note_card_test.dart

# Run with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test Examples

**Widget Test:**
```dart
testWidgets('NoteCard displays title', (tester) async {
  await tester.pumpWidget(TestApp());
  expect(find.text('Title'), findsOneWidget);
});
```

**Provider Test:**
```dart
test('Search provider updates correctly', () {
  final container = ProviderContainer();
  expect(container.read(searchProvider), '');
  
  container.read(searchProvider.notifier).state = 'test';
  expect(container.read(searchProvider), 'test');
});
```

## Commit Messages

Follow conventional commits format:

```
type(scope): subject

body (optional)
footer (optional)
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Code style (formatting, missing semicolons, etc)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

**Examples:**
```
feat(auth): Add biometric login
fix(notes): Resolve search filter bug
docs: Update README with setup instructions
test(note_card): Add widget tests for NoteCard
```

## Pull Request Process

1. Update documentation with any new features
2. Add tests for new functionality
3. Ensure all tests pass: `flutter test`
4. Ensure code is formatted: `dart format lib test`
5. Ensure no analyzer issues: `flutter analyze`
6. Update CHANGELOG.md
7. Create PR with description using the template

## Code Review

All pull requests will be reviewed for:
- Code quality and style
- Test coverage
- Documentation completeness
- Architecture alignment
- Performance implications

## Reporting Bugs

When reporting bugs, include:
- Clear description of the issue
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots/videos if applicable
- System information (Flutter version, OS, device)

## Feature Requests

For feature requests:
- Describe the desired functionality
- Explain the use case
- Provide mockups if relevant
- Consider performance implications

## Questions?

- Create an issue with your question
- Check existing issues for similar questions
- Review documentation in `/docs`

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing!** 🎉
