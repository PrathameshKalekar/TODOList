import 'package:flutter/material.dart';
import 'package:todo_list/managet/todo_manager.dart';
import 'package:todo_list/pages/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TODOManager> _foundTODO = [];
  final TODOSList = TODOManager.TODOList();
  final _todoController = TextEditingController();
  @override
  void initState() {
    _foundTODO = TODOSList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: Row(
          children: const <Widget>[
            Icon(
              Icons.menu,
              size: 30,
              color: Colors.black,
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              "TODO",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SearchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: const Text(
                      "TODO List",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  for (TODOManager todo in TODOSList)
                    TODOList(
                      todoInput: todo,
                      onTODOChanged: _checkBoxHandler,
                      onDeleteItem: _onDeleteTODO,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _todoController,
                        decoration: const InputDecoration(
                            hintText: 'Add new TODO item',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(color: Colors.grey)],
                        color: Colors.blueAccent),
                    child: IconButton(
                      onPressed: () {
                        _todoListCreater(_todoController.text);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _checkBoxHandler(TODOManager todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _onDeleteTODO(String id) {
    setState(() {
      TODOSList.removeWhere((element) => element.id == id);
    });
  }

  void _todoListCreater(String todo) {
    setState(() {
      if (_todoController.text.isNotEmpty) {
        TODOSList.add(TODOManager(
            id: DateTime.now().millisecondsSinceEpoch.toString(), text: todo));
      }
    });
    _todoController.clear();
  }

  void searchListner(String search) {
    List<TODOManager> result = [];
    if (search.isEmpty) {
      result = TODOSList;
    } else {
      result = TODOSList.where((element) =>
          element.text.toLowerCase().contains(search.toLowerCase())).toList();
    }
    setState(() {
      _foundTODO = result;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) => _onDeleteTODO(value),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
        ),
      ),
    );
  }
}
