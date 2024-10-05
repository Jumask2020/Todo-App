import 'package:dartz/dartz.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:local_storge/view_model/task_v_m.dart';
import 'package:local_storge/moedel/task.dart' as tt;

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final TaskVM _taskVM = TaskVM();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, '/addTask');
        },child: Icon(Icons.add),),
        body: FutureBuilder(
        future: _taskVM.fetchAllTask(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          final Either<String,List<tt.Task>> result = snapshot.data!;
          return result.fold((error)=>Center(child: Text(error),),
              (tasks)=> ListView.builder(
                itemCount: tasks.length,

                itemBuilder:(context, index) => Dismissible(
                  secondaryBackground: Container(color:Colors.indigo,),
                  background: Container(color: Colors.red),

                  key: Key(''),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6,),
                  
                          Text(tasks[index].title!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                          SizedBox(height: 6,),
                  
                          Text(tasks[index].des!,style: TextStyle(color: Colors.grey[600]),),
                          SizedBox(height: 10,),
                  
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(tasks[index].isCompleted == false?'UnCompleted':'Completed',),
                              IconButton(onPressed: (){
                                _taskVM.deleteTask(tasks[index].id!);
                              }, icon: Icon(Icons.delete,color: Colors.red,)),
                              IconButton(onPressed: (){
                                tt.Task t = tt.Task();
                                Navigator.pushNamed(context, '/addTask',arguments: tasks[index]);
                              }, icon: Icon(Icons.update,color: Colors.blue,))
                  
                            ],)
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        }
      ),
    );
  }
}
