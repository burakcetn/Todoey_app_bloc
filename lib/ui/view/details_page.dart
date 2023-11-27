import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bootcamp/data/models/task_model.dart';
import 'package:todo_bootcamp/ui/bloc/details_page_cubit.dart';

class DetailsPage extends StatefulWidget {
  TaskModel taskModel;
  DetailsPage({super.key, required this.taskModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Güncelle",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: titleController,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () async {
                  await context
                      .read<DetailsPageCubit>()
                      .updateTask(titleController.text, widget.taskModel.id);
                  Navigator.pop(context);
                },
                child: Text("Güncelle"),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
