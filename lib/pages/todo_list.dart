import 'package:flutter/material.dart';
import 'package:todo_list/managet/todo_manager.dart';

class TODOList extends StatelessWidget {
  final TODOManager todoInput;
  // ignore: prefer_typing_uninitialized_variables
  final onTODOChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;
  const TODOList(
      {super.key,
      required this.todoInput,
      this.onTODOChanged,
      this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            onTODOChanged(todoInput);
          },
          child: Icon(
            todoInput.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
        ),
        title: Text(
          todoInput.text,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: todoInput.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.underline),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            onDeleteItem(todoInput.id);
          },
        ),
      ),
    );
  }
}
