import 'package:flutter/material.dart';

class AddEditNotePage extends StatefulWidget {
  final void Function(String title, String content) onSave;
  final String? oldTitle;
  final String? oldContent;

  const AddEditNotePage({
    super.key,
    required this.onSave,
    this.oldTitle,
    this.oldContent,
  });

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.oldTitle ?? '';
    contentController.text = widget.oldContent ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final title = titleController.text.trim();
      final content = contentController.text.trim();

      widget.onSave(title, content);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.oldTitle == null ? "Add Note" : "Edit Note"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Note Title"),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if ((value ?? '').trim().isEmpty &&
                      contentController.text.trim().isEmpty) {
                    return "Cannot save an empty note";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextFormField(
                  controller: contentController,
                  decoration: const InputDecoration(hintText: "Note Content"),
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty &&
                        titleController.text.trim().isEmpty) {
                      return "Cannot save an empty note";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  // clipBehavior: Clip.hardEdge,
                  onPressed: () {
                    _saveNote();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
