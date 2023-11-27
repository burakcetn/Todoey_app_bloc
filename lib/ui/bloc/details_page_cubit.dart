import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bootcamp/data/repos/task_repository.dart';

class DetailsPageCubit extends Cubit {
  DetailsPageCubit() : super(0);

  Future updateTask(String title, int id) async {
    await TaskRepository().updateTask(title, id);
  }
}
