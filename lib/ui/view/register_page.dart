import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bootcamp/ui/bloc/register_page_cubit.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni görev ekle "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Görev İsmi",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextField(
                  controller: titleController,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                await context
                    .read<RegisterPageCubit>()
                    .saveTask(titleController.text);
                Navigator.pop(context);
              },
              child: Text("Kaydet"),
            ),
            SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
