# Architecture Overview

## State Management with Riverpod

This project uses **Riverpod** for state management. All providers are centralized in `lib/providers.dart`.

### Provider Types

1. **StateProvider** - Mutable state
   ```dart
   final searchProvider = StateProvider<String>((ref) => '');
   ```

2. **StreamProvider** - Async streams (Firebase)
   ```dart
   final notesStreamProvider = StreamProvider.autoDispose<List<QueryDocumentSnapshot>>((ref) {
     // Automatically cleaned up when unused
   });
   ```

3. **FutureProvider** - Async operations
   ```dart
   final notesCountProvider = FutureProvider<int>((ref) async {
     // Fetches count
   });
   ```

## Project Layers

### 1. **Presentation Layer** (`lib/`)
- `main.dart` - App entry point & theme setup
- `home_page.dart` - Main screen logic
- `login_page.dart` - Auth UI
- `add/editNote.dart` - Note editing

### 2. **Widgets Layer** (`lib/widgets/`)
Reusable, composable widgets:
- `search_and_sort_bar.dart` - Search & sort functionality
- `note_card.dart` - Individual note display
- `empty_notes_view.dart` - Empty state UI

### 3. **Components Layer** (`lib/components/`)
Shared UI components:
- `textfield.dart` - Custom text input
- `password.dart` - Password field
- `my_button.dart` - Custom button

### 4. **Theme Layer** (`lib/theme/`)
- `light_mode.dart` - Light theme configuration
- `dark_mode.dart` - Dark theme configuration

### 5. **State Layer** (`lib/providers.dart`)
All Riverpod providers for state management

## Data Flow

```
Firebase (Firestore/Auth)
    ↓
Providers (Stream/Future)
    ↓
ConsumerWidget (listens via ref.watch)
    ↓
UI Updates
```

## Best Practices

### ✅ DO

- Use `ConsumerWidget` for widgets that read providers
- Use `autoDispose` for providers that clean up when unused
- Validate user input before Firebase calls
- Use `.when()` for handling AsyncValue states
- Extract reusable widgets into `lib/widgets/`

### ❌ DON'T

- Create providers in multiple files (centralize in `providers.dart`)
- Use `StatefulWidget` when Riverpod can manage state
- Call Firebase directly in UI widgets (use providers)
- Ignore loading/error states from streams

## Common Patterns

### Listening to Providers

```dart
final value = ref.watch(searchProvider);
```

### Modifying State

```dart
ref.read(searchProvider.notifier).state = 'new value';
```

### Handling Async Data

```dart
notesAsync.when(
  data: (notes) => ListView(...),
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => ErrorWidget(),
)
```

## Firebase Integration

### Collections
- `/notes/{userId}/{noteId}` - User's notes

### Security Rules
```firestore
match /notes/{userId}/{noteId=**} {
  allow read, write: if request.auth.uid == userId;
}
```

## Performance Tips

1. Use `autoDispose` providers to free memory
2. Index Firestore queries (updatedAt, createdAt)
3. Limit batch reads with pagination
4. Use `RefreshIndicator` for manual refresh
5. Lazy load large lists

---

For more info, see [Riverpod Docs](https://riverpod.dev)
