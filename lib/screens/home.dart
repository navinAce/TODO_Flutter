import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import '../model/todo.dart';
import '../widgets/to_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> filteredList = [];

  void initState() {
    filteredList = todoList;
    super.initState();
  }

  void _handleSearch(String value) {
    List<ToDo> searchList = [];
    if (value.isEmpty) {
      searchList = todoList;
    } else {
      searchList = todoList
          .where((todo) =>
              todo.toDoText!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredList = searchList;
    });
  }

  void _handleChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDelete(ToDo todo) {
    setState(() {
      todoList.removeWhere((item) => item.id == todo.id);
    });
  }

  void _handleAdd(String text) {
    setState(() {
      todoList.add(ToDo(id: DateTime.now().toString(), toDoText: text));
    });
    _todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        title: const Text('TODO App'),
        backgroundColor: tdBGColor,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "All ToDos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in filteredList)
                        TodoItem(
                          todo: todoo,
                          onToDoChanged: _handleChange,
                          onToDoDeleted: () => _handleDelete(todoo),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: "Add a new ToDo item",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (_todoController.text.isNotEmpty) {
                        _handleAdd(_todoController.text);
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _handleSearch(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
