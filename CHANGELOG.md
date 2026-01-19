# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-19

### Added
- Initial release of My Notes app
- Real-time note synchronization with Firebase Firestore
- User authentication with Firebase Auth
- Material Design 3 UI with light/dark theme support
- Search and sort functionality for notes
- Swipe gestures for edit/delete actions
- Undo delete functionality with SnackBar
- Responsive design for multiple screen sizes
- Comprehensive documentation (README, ARCHITECTURE, CONTRIBUTING guides)
- Widget tests for NoteCard and EmptyNotesView
- GitHub Actions CI/CD pipeline
- Firebase security rules with validation
- Professional code organization with Riverpod state management
- Widget extraction for improved maintainability
- Accessibility and performance optimization guidelines

### Features
- ✨ Notes management (CRUD operations)
- 🔐 Secure authentication
- 🌙 Dark mode support
- 🔍 Search notes by title or content
- 📊 Sort by creation or update date
- 👆 Intuitive swipe actions
- ↩️ Undo delete with confirmation
- 📱 Mobile-optimized UI
- 🎨 Material 3 design system

### Technical
- State management: Riverpod with auto-dispose providers
- Database: Cloud Firestore with real-time streams
- Authentication: Firebase Auth
- UI Framework: Flutter 3.0+
- Language: Dart 3.0+

### Security
- User-scoped Firestore security rules
- Input validation on all database operations
- Secure password handling
- Firebase Auth best practices

### Documentation
- README with feature overview and setup guide
- ARCHITECTURE guide for developers
- CONTRIBUTING guide with coding standards
- IMPROVEMENTS summary of changes
- ACCESSIBILITY_PERFORMANCE optimization guide

---

## [Unreleased]

### Planned Features
- [ ] Note categories and tags
- [ ] Rich text editor with formatting
- [ ] Offline support with local caching
- [ ] Note sharing and collaboration
- [ ] Voice notes capability
- [ ] Export to PDF/Markdown
- [ ] Cloud backup functionality
- [ ] Multi-language support (i18n)
- [ ] Note encryption
- [ ] Recurring reminders

### Improvements
- [ ] Advanced search with filters
- [ ] Note archiving
- [ ] Bulk operations
- [ ] Custom themes
- [ ] App shortcuts
- [ ] Widget shortcuts
- [ ] App notifications
- [ ] Background sync

---

## Notes on Versioning

Starting with version 1.0.0:
- **MAJOR version** for incompatible API changes
- **MINOR version** for new functionality in a backwards compatible manner
- **PATCH version** for backwards compatible bug fixes

---

## How to Report Issues

When reporting bugs or suggesting features, please provide:
1. Clear description of the issue
2. Steps to reproduce (for bugs)
3. Expected vs actual behavior
4. Device info (Flutter version, OS, device model)
5. Screenshots or videos if applicable

---

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on how to contribute to this project.
