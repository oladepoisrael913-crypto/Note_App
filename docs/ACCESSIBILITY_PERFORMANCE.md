# Accessibility & Performance Guide

## Accessibility (a11y)

### Semantic Widgets
Always use semantic widgets for better screen reader support:

```dart
// ✅ Good - Uses semantically correct widgets
ListTile(
  title: Text('Note Title'),
  subtitle: Text('Note preview...'),
)

// ❌ Avoid - Generic containers lose semantic meaning
Container(
  child: Column(
    children: [Text('Note Title'), Text('preview...')],
  ),
)
```

### Labels & Tooltips
```dart
IconButton(
  icon: const Icon(Icons.delete),
  tooltip: 'Delete note', // Screen reader announcement
  onPressed: () {},
)
```

### Color Contrast
- Text: Minimum 4.5:1 ratio for normal text
- UI components: Minimum 3:1 ratio
- Test with: https://webaim.org/resources/contrastchecker/

### Text Scaling
```dart
// ✅ Responsive text sizing
Text(
  'Note Title',
  style: Theme.of(context).textTheme.titleLarge,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

### Keyboard Navigation
- All interactive elements must be keyboard accessible
- Support tab navigation
- Use `Focus` and `FocusScope` for custom focus behavior

### Testing Accessibility
```bash
# Run semantics debugger
flutter run --dart-define=FLUTTER_WEB_USE_SKIA=true

# Check accessibility in DevTools:
# 1. Open DevTools
# 2. Go to Inspector
# 3. Enable "Show Semantics"
```

---

## Performance Optimization

### 1. Build Performance

**AutoDispose Providers:**
```dart
// ✅ Cleans up automatically when not used
final notesProvider = StreamProvider.autoDispose<List>((ref) {
  return stream;
});

// ❌ Keeps resources even if unused
final notesProvider = StreamProvider<List>((ref) {
  return stream;
});
```

**Const Widgets:**
```dart
// ✅ Prevent unnecessary rebuilds
const SizedBox(height: 16);
const Icon(Icons.delete);

// ❌ Rebuilds every time parent rebuilds
SizedBox(height: 16);
Icon(Icons.delete);
```

### 2. Firebase Optimization

**Index queries:**
```dart
// ✅ With proper indexing, fast queries
final notesStream = notesRef
  .where('userId', isEqualTo: uid)
  .orderBy('updatedAt', descending: true)
  .limit(20)
  .snapshots();
```

**Batch operations:**
```dart
// ✅ Single write instead of multiple
final batch = FirebaseFirestore.instance.batch();
batch.set(doc1, data1);
batch.set(doc2, data2);
await batch.commit();
```

### 3. Widget Performance

**ListView.builder:**
```dart
// ✅ Only builds visible items
ListView.builder(
  itemCount: notes.length,
  itemBuilder: (context, index) => NoteCard(notes[index]),
)

// ❌ Builds all items at once
ListView(
  children: notes.map((n) => NoteCard(n)).toList(),
)
```

**Memoization with Consumer:**
```dart
// ✅ Only rebuilds when specific provider changes
Consumer(
  builder: (context, ref, child) {
    final notes = ref.watch(notesProvider);
    return ListView(children: []);
  },
)

// ❌ Rebuilds parent and all children
watch(notesProvider) // in parent
```

### 4. Memory Management

**Image Caching:**
```dart
// ✅ Efficient caching
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => Skeleton(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  cacheManager: CacheManager.instance,
)
```

**Stream Cleanup:**
```dart
// ✅ Automatic cleanup with StreamProvider.autoDispose
final streamProvider = StreamProvider.autoDispose<Data>((ref) {
  return stream; // Cleaned up when unused
});
```

### 5. Network Performance

**Pagination:**
```dart
// ✅ Load notes in batches
final notesStream = FirebaseFirestore.instance
  .collection('notes')
  .orderBy('updatedAt', descending: true)
  .limit(20) // Load 20 at a time
  .snapshots();
```

**Caching Strategy:**
```dart
// ✅ Local cache + remote sync
final cachedNotes = await _localDb.getNotes();
final remoteNotes = notesRef.snapshots();

// Update local cache when remote changes
remoteNotes.listen((snapshot) {
  _localDb.updateNotes(snapshot.docs);
});
```

### 6. App Size Optimization

**Remove unused dependencies:**
```bash
flutter pub deps --json | jq '.packages[] | select(.kind != "transitive")'
```

**Strip native libraries:**
```bash
flutter build apk --split-per-abi
```

### 7. Performance Monitoring

**Timeline Profiler:**
```bash
# Profile app performance
flutter run --profile

# Then in DevTools: Timeline > Record
```

**Memory Profiler:**
```bash
# Track memory usage
flutter run --profile
# DevTools: Memory > Record
```

### Benchmarks

Target metrics:
- **App launch:** < 2 seconds
- **Frame rate:** 60 FPS (120 FPS on high-refresh devices)
- **Memory:** < 100 MB idle
- **Network:** Query results < 500ms

---

## Checklist

### Accessibility
- [ ] All text has sufficient contrast (4.5:1)
- [ ] Interactive elements have labels/tooltips
- [ ] Keyboard navigation works
- [ ] Text scales properly
- [ ] Semantic structure is correct

### Performance
- [ ] No unnecessary rebuilds
- [ ] AutoDispose providers used
- [ ] Images are cached
- [ ] Const widgets used
- [ ] Firebase queries are indexed
- [ ] ListView uses .builder
- [ ] App size < 50MB

---

## Resources

- [Flutter Accessibility Guide](https://flutter.dev/docs/development/accessibility-and-localization/accessibility)
- [Flutter Performance Guide](https://flutter.dev/docs/perf)
- [Firebase Best Practices](https://firebase.google.com/docs/firestore/best-practices)
- [Riverpod Performance](https://riverpod.dev/docs/essentials/combining_providers)
