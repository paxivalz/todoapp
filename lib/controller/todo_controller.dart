import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoController extends GetxController {
  var todos = <TodoModel>[].obs;

  @override
  void onInit() {
    List? storageTodos = GetStorage().read<List>('todos'); //read data --> todos

    if (!storageTodos.isNull) {
      todos = storageTodos!.map((e) => TodoModel.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
