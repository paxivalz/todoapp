import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoPage extends StatelessWidget {
  final TodoController todoController = Get.find();
  final int index;

  TodoPage({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String text = '';
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return Scaffold(
      //appbar
      appBar: AppBar(
        centerTitle: true,
        title: const Text('- y o u r l i s t -'),
        backgroundColor: Colors.blue[200],
      ),

      //body
      body: Column(children: [
        //Text field <Add/Edit text task>
        Expanded(
            child: TextField(
          controller: textEditingController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'list your activities',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          style: const TextStyle(
            fontSize: 20,
          ),
          keyboardType: TextInputType.multiline,
          maxLength: 30, //can not type over 30
        )),

        //Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Cancle
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[200])),
              child: const Text(
                'Cancle',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Get.back();
              },
            ),

            //Add
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green[300])),
              child: Text(
                (index.isNegative)
                    ? 'Add'
                    : 'Edit', //if index > -1 will change to Edit
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (index.isNegative) {
                  var newtask = TodoModel(text: textEditingController.text);
                  todoController.todos.add(newtask); //Add button
                } else {
                  var editting = todoController.todos[index]; //Edit buton
                  editting.text =
                      textEditingController.text; //save edit new text
                  todoController.todos[index] =
                      editting; //list will show new text
                }

                Get.back();
              },
            )
          ],
        ),
      ]),
    );
  }
}
