import 'package:todo/models/todo_model.dart';

class TodoController {
  final List<TodoModel> _list = [
    TodoModel(
      title: "Shopping",
    ),
    TodoModel(
      title: "Swimming",
    ),
    TodoModel(
      title: "Running",
    ),
  ];

  List<TodoModel> get list {
    return [..._list];
  }

  void add(String title) {
    _list.add(
      TodoModel(
        title: title,
      ),
    );
  }

  void update(int index, String title) {
    _list[index].title = title;
  }

  void makeDone(int index) {
    print(_list[index].isDone);
    _list[index].isDone = !_list[index].isDone;
    print(_list[index].isDone);
  }

  void delete(int index) {
    _list.removeAt(index);
  }
}
