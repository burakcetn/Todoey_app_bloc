import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bootcamp/data/models/task_model.dart';
import 'package:todo_bootcamp/ui/bloc/home_page_cubit.dart';
import 'package:todo_bootcamp/ui/bloc/searching_cubit.dart';
import 'package:todo_bootcamp/ui/view/details_page.dart';
import 'package:todo_bootcamp/ui/view/register_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cubit = HomePageCubit();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SearchingCubit, bool>(
          builder: (context, state) => state
              ? TextField(
                  onChanged: (value) =>
                      context.read<HomePageCubit>().searchTask(value),
                )
              : Text("HomePage"),
        ),
        actions: [
          BlocBuilder<SearchingCubit, bool>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => context.read<SearchingCubit>().isSearching(),
                icon: state ? Icon(Icons.close) : Icon(Icons.search),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()))
            .then((value) => context.read<HomePageCubit>().loadTasks()),
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<HomePageCubit, List<TaskModel>>(
        builder: (context, dataList) {
          if (dataList.isNotEmpty) {
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(20),
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "${dataList[index].id.toString()} no'lu görev silinsin mi ?"),
                                action: SnackBarAction(
                                  label: "Evet",
                                  onPressed: () => context
                                      .read<HomePageCubit>()
                                      .deleteTask(dataList[index].id),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.close),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              taskModel: dataList[index],
                            ),
                          ),
                        ).then((value) =>
                            context.read<HomePageCubit>().loadTasks()),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              dataList[index].title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("has no data"),
            );
          }
        },
      ),
    );
  }
}
