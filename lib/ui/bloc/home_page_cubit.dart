import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bootcamp/data/models/task_model.dart';
import 'package:todo_bootcamp/data/repos/task_repository.dart';
import 'package:todo_bootcamp/ui/view/home_page.dart';

class HomePageCubit extends Cubit<List<TaskModel>> {
  HomePageCubit() : super(<TaskModel>[]);

  var taskRepo = TaskRepository();

  Future<void> loadTasks() async {
    var taskList = await taskRepo.getTasks();
    emit(taskList);
  }

  Future<void> searchTask(String query) async {
    var searchList = await taskRepo.searchTask(query);
    emit(searchList);
  }

  Future<void> deleteTask(int id) async {
    await taskRepo.deleteTask(id);
    loadTasks();
  }
}
