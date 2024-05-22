import 'package:flutter/material.dart';

class TodoAddDialog extends StatefulWidget {
  const TodoAddDialog({super.key});

  @override
  State<TodoAddDialog> createState() => _TodoAddDialogState();
}

class _TodoAddDialogState extends State<TodoAddDialog> {
  final _formKey = GlobalKey<FormState>();

  String title = "";

  void _add() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pop(context, {
        "title": title,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Todo"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "title",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter a title";
                }
                return null;
              },
              onSaved: (newValue) {
                title = newValue ?? "";
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: _add,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("Add"),
        )
      ],
    );
  }
}
