import 'package:dartz/dartz.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_storge/core/constants/app_color.dart';
import 'package:local_storge/core/view/widget/costum_space_vartical.dart';
import 'package:local_storge/core/view/widget/costum_text.dart';

import 'package:local_storge/core/view_model/task_v_m.dart';
import 'package:local_storge/core/model/task.dart' as tt;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TaskVM _taskVM = TaskVM();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('All Task')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: _taskVM.fetchAllTask(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Not Found Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            }
            final Either<String, List<tt.Task>> result = snapshot.data!;
            return result.fold(
                (error) => Center(
                      child: Text(error),
                    ),
                (tasks) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                gradient: LinearGradient(
                                    tileMode: TileMode.mirror,
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [
                                      Color(0xFF0088E9),
                                      Color(0xFF8BAAC0)
                                    ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CostumText(
                                  text: 'All Task: ${tasks.length}',
                                  color: Colors.white,
                                ),
                                // CostumText(
                                //   text: 'All Task: ${tasks.length}',
                                //   color: Colors.white,
                                // ),

                              ],
                            ),
                          ),
                          CostumSpaceVartical(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 260,
                            child: ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) => Dismissible(
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                key: ValueKey(tasks[index]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) async {
                                  await _taskVM.deleteTask(tasks[index].id!);
                                },
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/addTask',
                                        arguments: tasks[index]);
                                  },
                                  child: Card(
                                    elevation: 3,
                                    // color: Colors.grey[300],
                                    child: ListTile(
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      leading: Icon(
                                        tasks[index].isCompleted! == true
                                            ? Icons.check
                                            : Icons.dangerous,
                                        color: AppColor.primaryColor,
                                      ),
                                      title: Text(tasks[index].title!),
                                      subtitle: Text(tasks[index].des!),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
          }),
    );
  }
}
