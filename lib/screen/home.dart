import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:todoapp/screen/todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('- t o d o a p p -'),
        backgroundColor: Colors.blue[200],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[200],
          onPressed: (() {
            Get.to(TodoPage(
              index: -1,
            )); //if index =-1 will new task
          }),
          child: const Icon(
            Icons.add,
          )),
      body: Obx(() => ListView.separated(
          itemBuilder: ((context, index) {
            return Dismissible(
              //slide box
              key: UniqueKey(),
              onDismissed: (_) {
                var removed = todoController.todos[index];
                todoController.todos.removeAt(index); //remove task
                Get.snackbar('Task is Removed', 'Remove Successfully',
                    mainButton: TextButton(
                        //button undo
                        onPressed: () {
                          if (removed.isNull) {
                            return;
                          }
                          todoController.todos.insert(index, removed);
                          // removed = null;
                          if (Get.isSnackbarOpen) {
                            Get.back();
                          }
                        },
                        child: Text('undo')));
              },
              //Box Task Activities
              child: ListTile(
                title: Text(
                  todoController.todos[index].text, //showtext
                  style: (todoController
                          .todos[index].done) //defalt -> done = false
                      ? const TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.lineThrough)
                      : TextStyle(color: Colors.grey[600]),
                ),
                onTap: () {
                  Get.to(TodoPage(
                    index: index, //go to add task page
                  ));
                },
                leading: Checkbox(
                    value: todoController.todos[index].done, //done = false
                    onChanged: (check) {
                      var changed = todoController.todos[index];
                      changed.done = check!; //change false -> true
                      todoController.todos[index] = changed;
                    }),
                trailing: const Icon(Icons.chevron_right_outlined),
              ),
            );
          }),
          separatorBuilder: (_, __) {
            return const Divider();
          },
          itemCount: todoController.todos.length)),
    );
  }
}
