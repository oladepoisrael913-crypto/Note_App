My Notes - Flutter Firebase App

A modern, production-ready note-taking application built with Flutter and Firebase, featuring real-time synchronization, responsive UI, and dark mode support.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue)
![License](https://img.shields.io/badge/License-MIT-green)

Features

Real-time Sync: Notes sync instantly across devices using Firebase Firestore
-Authentication: Secure login and registration with Firebase Auth
- Search & Filter: Quickly find notes by title or content
- Sort Options: Organize notes by creation or last updated date
- Swipe Actions: Swipe to edit/delete with visual feedback
- Undo Delete: Restore deleted notes instantly
- Dark Mode: Seamless theme switching
- Responsive Design: Optimized for all screen sizes
- Material 3: Modern Material Design 3 UI

 Architecture

- State Management: Riverpod with auto-dispose providers
- Database: Cloud Firestore with real-time streams
- Auth: Firebase Authentication
- UI: Material Design 3 with custom themes

Quick Start

```bash
 Install dependencies
flutter pub get

Configure Firebase (if needed)
flutterfire configure

 Run the app
flutter run


Project Details

lib/
├── main.dart
├── providers.dart                Riverpod state
├── home_page.dart              Main screen
├── add/editNote.dart            Note editor
├── components/                  Reusable widgets
├── widgets/                     Feature-specific widgets
└── theme/                      Light & dark themes


 Security

- Firebase security rules for user-scoped data
- Input validation & error handling
- Secure password management

 Tech Stack

- Flutter 3.0+
- Dart 3.0+
- Firebase (Auth + Firestore)
- Riverpod state management
- Material Design 3
 License

MIT License

---

// Built with flutter and Firebase
