import 'package:flutter/material.dart';
import 'package:local_storge/view_model/task_v_m.dart';
import 'package:local_storge/moedel/task.dart'as tt;

class AddTask extends StatelessWidget {
   AddTask({super.key});

  final TextEditingController title  =TextEditingController();
  final TextEditingController des  =TextEditingController();
  final TaskVM _taskVM = TaskVM();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          TextFormField(
            controller: title,
          ),
          TextFormField(controller: des,),

          MaterialButton(
            color: Colors.indigo,
            onPressed: ()async{
              tt.Task t = tt.Task(title: title.text,des:des.text);
              await _taskVM.addTask(t).then((v){
                print(v);
              });
            },child: Text('Save',style: TextStyle(color: Colors.white),),)
        ],
      )
    );
  }
}
