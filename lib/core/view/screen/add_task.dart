import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:local_storge/core/constants/app_color.dart';
import 'package:local_storge/core/view/widget/costom_text_form_field.dart';
import 'package:local_storge/core/view/widget/costum_date_time.dart';
import 'package:local_storge/core/view/widget/costum_space_vartical.dart';
import 'package:local_storge/core/view/widget/costum_text.dart';
import 'package:local_storge/core/view_model/task_v_m.dart';
import 'package:local_storge/core/model/task.dart' as tt;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key, this.task});
  final tt.Task? task;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController dateStartController = TextEditingController();
  final TextEditingController dateEndController = TextEditingController();
  final TaskVM _taskVM = TaskVM();

  @override
  Widget build(BuildContext context) {
    if (task != null) {
      titleController.text = task!.title ?? '';
      desController.text = task!.des ?? '';
    }
    return Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider(
          create: (context) => TaskVM(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CostumSpaceVartical(),
                  CostumText(text: 'Task Name'),
                  CostumSpaceVartical(),
                  CostomTextFormField(
                    controller: titleController,
                    hintText: 'Task Name',
                  ),
                  CostumSpaceVartical(
                    height: 20,
                  ),
                  CostumText(text: 'Start Date & Time'),
                  CostumSpaceVartical(
                    height: 5,
                  ),
                  Consumer<TaskVM>(builder: (context, t, child) {
                    return CustomDateTime(
                      taskVM: t,
                      controller: dateStartController,
                    );
                  }),
                  CostumSpaceVartical(),
                  CostumText(text: 'End Date & Time'),
                  CostumSpaceVartical(
                    height: 5,
                  ),
                  Consumer<TaskVM>(builder: (context, t, child) {
                    return CustomDateTime(
                      taskVM: t,
                      controller: dateEndController,
                    );
                  }),
                  CostumSpaceVartical(),
                  CostumText(text: 'Description'),
                  CostumSpaceVartical(),
                  CostomTextFormField(
                    controller: desController,
                    vertical: 10,
                    maxLines: 4,
                    hintText: 'Task Description',
                  ),
                  CostumSpaceVartical(
                    height: 20,
                  ),
                  Center(
                      child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        child: Text(
                          'Save Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        color: AppColor.primaryColor,
                        onPressed: () async {
                          tt.Task taskAdd = tt.Task(
                              title: titleController.text,
                              des: desController.text);
                          if (task == null) {
                            await _taskVM.addTask(taskAdd).then((t) {

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/home',
                                (route) => false,
                              );
                            });
                          } else {
                            tt.Task taskUpdate = tt.Task(
                              id: task!.id,
                                title: titleController.text,
                                des: desController.text);
                            await _taskVM
                                .updateTask(task!.id!, taskUpdate)
                                .then((t) {

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/home',
                                (route) => false,
                              );
                            });
                          }
                          ;
                        }),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
