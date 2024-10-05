import 'package:flutter/material.dart';
import 'package:local_storge/core/constants/app_color.dart';
import 'package:local_storge/core/view/widget/costom_text_form_field.dart';
import 'package:local_storge/core/view_model/task_v_m.dart';
import 'package:intl/intl.dart';

class CustomDateTime extends StatelessWidget {
  const CustomDateTime({super.key, this.controller, required this.taskVM});
  final TextEditingController? controller;
  final TaskVM taskVM;

  @override
  Widget build(BuildContext context) {
    return CostomTextFormField(
      hintText: '2024/12/30  12:30 AM',
      suffixIcon: Icon(
        Icons.calendar_today,
        color: AppColor.primaryColor,
      ),
      controller: controller,
      readOnly: true,
      onTap: () async {
        DateTime? newDate = await showDatePicker(
          fieldHintText: controller!.text,
          context: context,
          initialDate: taskVM.dateTime,
          firstDate: DateTime.now(),
          lastDate: DateTime(2200),
        );
        if (newDate == null) return;

        TimeOfDay? newTime= await showTimePicker(
            context: context,

            initialTime: TimeOfDay(
                hour: taskVM.dateTime.hour,
                minute: taskVM.dateTime.minute));
        if(newTime == null)return;

        final newDateTime =  DateTime(

          newDate.year,
          newDate.month,
          newDate.day,

          newTime.hour,
          newTime.minute,

        );

        controller!.text = DateFormat('yyyy/MM/dd  h:mm a').format(newDateTime);
        taskVM.selectedDateTime(newDateTime);
      },
    );
    // child: TextfieldDatePicker(
    //   // textAlign: TextAlign.right,
    //   decoration: InputDecoration(
    //
    //     prefixIcon: Icon(
    //       Icons.calendar_month,
    //       color: AppColor.primaryColor,
    //     ),
    //     labelText: labelText,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(14)),
    //
    //     ),
    //     hintText: hintText,
    //     labelStyle: TextStyle(
    //       fontSize: 16,
    //     ),
    //     // focusedBorder: OutlineInputBorder(
    //     //     borderSide: BorderSide(color: AppColor.primaryColor, )),
    //     // enabledBorder: OutlineInputBorder(
    //     //     borderSide: BorderSide(color: AppColor.primaryColor, )),
    //   ),
    //   validator: validate,
    //   textfieldDatePickerController: controller,
    //   materialDatePickerFirstDate: DateTime(2000),
    //   materialDatePickerLastDate: DateTime(2200),
    //   materialDatePickerInitialDate: DateTime.now(),
    //   preferredDateFormat: DateFormat('d/M/y'),
    //   cupertinoDatePickerMaximumDate: DateTime(2200, 1, 1),
    //   cupertinoDatePickerMinimumDate: DateTime(2000, 1, 1),
    //   cupertinoDatePickerBackgroundColor: AppColor.primaryColor,
    //   cupertinoDatePickerMaximumYear: 2200,
    //   cupertinoDateInitialDateTime: DateTime(2000),
    // ),
  }
}
