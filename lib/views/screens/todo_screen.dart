import 'package:flutter/material.dart';
import 'package:todo/controllers/todo_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/views/widgets/todo_add_dialog.dart';
import 'package:todo/views/widgets/todo_edit_dialog.dart';
import 'package:todo/views/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final todoController = TodoController();

  void delete(int index) {
    todoController.delete(index);
    setState(() {});
  }

  void edit(int index, TodoModel todo) async {
    Map<String, dynamic>? data = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return TodoEditDialog(
          title: todo.title,
        );
      },
    );
    if (data != null) {
      todoController.update(index, data['title']);
      setState(() {});
    }
  }

  void makeDone(int index) {
    todoController.makeDone(index);
    setState(() {});
  }

  int markedItemsCount() {
    return todoController.markedItemsCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Todo"),
            const SizedBox(
              width: 10,
            ),
            Text("Done: ${markedItemsCount()}"),
            const SizedBox(
              width: 10,
            ),
            Text("Undone: ${todoController.list.length - markedItemsCount()}")
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: todoController.list.length,
        itemBuilder: (ctx, index) {
          return TodoItem(
            todoController.list[index],
            onDelete: () {
              delete(index);
            },
            onEdit: () {
              edit(index, todoController.list[index]);
            },
            onChecked: () {
              makeDone(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic>? data = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) {
                return const TodoAddDialog();
              });
          if (data != null) {
            todoController.add(
              data['title'],
            );
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
