 My Notes - Flutter Firebase App

A modern, production-ready note-taking application built with Flutter and Firebase, featuring real-time synchronization, responsive UI, and dark mode support.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Tests](https://img.shields.io/badge/Tests-Passing-brightgreen)
![Coverage](https://img.shields.io/badge/Coverage-80%25-brightgreen)

 Features

- Real-time Sync - Notes sync instantly across devices using Firebase Firestore
- Authentication - Secure login and registration with Firebase Auth
- Search & Filter - Quickly find notes by title or content
- Sort Options - Organize notes by creation or last updated date
  wipe Actions- Swipe to edit/delete with visual feedback
- Undo Delete - Restore deleted notes instantly
- Dark Mode - Seamless theme switching
- Responsive Design** - Optimized for all screen sizes
- Material 3 - Modern Material Design 3 UI
- Well Tested - Widget & unit tests with CI/CD pipeline

Architecture

- **State Management:** Riverpod with auto-dispose providers
- **Database:** Cloud Firestore with real-time streams
- Auth: Firebase Authentication
- UI: Material Design 3 with custom themes
- Testing:Flutter widget tests + GitHub Actions CI/CD

 Quick Start

bash
# Install dependencies
flutter pub get

# Configure Firebase
flutterfire configure

# Run the app
flutter run

# Run tests
flutter test

 Run with coverage
flutter test --coverage


 Documentation

- [ARCHITECTURE.md](docs/ARCHITECTURE.md) - Project structure and state management patterns
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute and coding standards
- [ACCESSIBILITY_PERFORMANCE.md](docs/ACCESSIBILITY_PERFORMANCE.md) - a11y & performance optimization
- [IMPROVEMENTS.md](docs/IMPROVEMENTS.md) - Summary of all improvements
- [CHANGELOG.md](CHANGELOG.md) - Release notes and version history

Testing

bash
# Run all tests
flutter test

# Run specific test
flutter test test/widgets/note_card_test.dart

# Generate coverage report
flutter test --coverage


 Project Structure


lib/
├── main.dart                    # Entry point
├── providers.dart               # Riverpod state management
├── home_page.dart              # Main screen
├── add/editNote.dart           # Note editor
├── components/                 # Reusable UI components
├── widgets/                    # Feature-specific widgets
│   ├── search_and_sort_bar.dart
│   ├── note_card.dart
│   └── empty_notes_view.dart
└── theme/                      # Light & dark themes

test/
├── widgets/
│   ├── note_card_test.dart
│   └── empty_notes_view_test.dart


Security

- User-scoped Firestore security rules
- Input validation on all database operations
- Secure password handling
- Firebase Auth best practices

See [firestore.rules](firestore.rules) for security configuration.

 Tech Stack

- **Flutter** 3.0+
- **Dart** 3.0+
- **Firebase** (Auth + Firestore)
- **Riverpod** - State management
- **Material Design 3** - UI Framework

## 🔄 CI/CD Pipeline

GitHub Actions automatically:
-  Analyzes code with `flutter analyze`
-  Checks formatting with `dart format`
-  Runs all tests
-  Builds release APK
-  Reports coverage metrics

See [.github/workflows/flutter_ci.yml](.github/workflows/flutter_ci.yml)

 Performance & Accessibility

- 80%+ code coverage target
- Optimized for accessibility (a11y)
- Material 3 semantic components
- Efficient state management with auto-dispose providers

See [ACCESSIBILITY_PERFORMANCE.md](docs/ACCESSIBILITY_PERFORMANCE.md) for detailed guidelines.

 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

 License

MIT License - see LICENSE file for details

 Support

- 📧 [Report Issues](https://github.com/oladepoisrael913-crypto/Note_App/issues)
- 💬 [Discussions](https://github.com/oladepoisrael913-crypto/Note_App/discussions)
- 📚 See [docs/](docs/) for more information

---

**Made with ❤️ using Flutter & Firebase**
