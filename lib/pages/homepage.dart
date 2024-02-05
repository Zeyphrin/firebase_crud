import 'package:flutter/material.dart';
import 'package:crud_project/todo_controller.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   ContactController contactController = Get.put(ContactController());
    TextEditingController updateNameController = TextEditingController();
    TextEditingController updateNumberController = TextEditingController();

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
                    controller: contactController.name,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    contactController.addContact();;
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
           Container(
                  height: 500.0,
                  child: Obx(() => ListView.builder(
                    itemCount: contactController.contactList.length,
                    itemBuilder: (context, index) {
                      var element = contactController.contactList[index];
                      return ListTile(
                        title: Text(element.name.toString()),
                        subtitle: Text(element.number.toString()),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Edit"),
                              onTap: () {
                                updateNameController.text = element.name!;
                                updateNumberController.text = element.number!;

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Edit Todo List"),
                                      content: Column(
                                        children: [
                                          TextFormField(
                                            controller: updateNameController,
                                            decoration: InputDecoration(hintText: "Enter todo"),
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            controller: updateNumberController,
                                            decoration: InputDecoration(hintText: "Enter sub text"),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            contactController.updateContact(
                                              element.id.toString(),
                                              updateNameController.text!,
                                              updateNumberController.text!,
                                            );;
                                            Navigator.pop(context);
                                          },
                                          child: Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            PopupMenuItem(
                              child: Text("Delete"),
                              onTap: () => contactController.deleteContact(element.id.toString()),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                ),
          ],
        ),
      ),
    );
  }
}