import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bootcamp/data/models/task_model.dart';
import 'package:todo_bootcamp/data/repos/task_repository.dart';

class RegisterPageCubit extends Cubit<void> {
  RegisterPageCubit() : super(0);

  var taskRepo = TaskRepository();

  Future<void> saveTask(String title) async {
    await taskRepo.insertTask(title);
  }
}
