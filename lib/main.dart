import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bootcamp/data/locals/database_helper.dart';
import 'package:todo_bootcamp/data/models/task_model.dart';
import 'package:todo_bootcamp/ui/bloc/details_page_cubit.dart';
import 'package:todo_bootcamp/ui/bloc/home_page_cubit.dart';
import 'package:todo_bootcamp/ui/bloc/register_page_cubit.dart';
import 'package:todo_bootcamp/ui/bloc/searching_cubit.dart';
import 'package:todo_bootcamp/ui/view/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseHelper.instance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageCubit(),
        ),
        BlocProvider(
          create: (context) => SearchingCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterPageCubit(),
        ),
        BlocProvider(
          create: (context) => DetailsPageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todoeyy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}
