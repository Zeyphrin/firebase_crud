import 'package:flutter/material.dart';
import 'package:crud_project/todo_controller.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD FIREBASE"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: todoController.title,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    todoController.addTodo();
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "ALL To-Do List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                    () => ListView(
                  children: todoController.todoList
                      .map(
                        (e) => Card(
                      elevation: 3,
                      child: ListTile(
                        tileColor: Colors.white,
                        onTap: () {},
                        title: Text(
                          e.title??"",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                todoController.deleteTodo(e.id??"");
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            IconButton(
                              onPressed: () {
                                todoController.updatedTitle.text =
                                e.title!;
                                Get.defaultDialog(
                                  title: "UPDATE TODO",
                                  content: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Container(
                                        height: 100,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                todoController
                                                    .updatedTitle,
                                                decoration:
                                                const InputDecoration(
                                                  fillColor:
                                                  Colors.white,
                                                  filled: true,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                todoController
                                                    .updateTodo(e);
                                                Get.back();
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                decoration:
                                                BoxDecoration(
                                                  color: Colors
                                                      .deepPurple,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10),
                                                ),
                                                child: const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}