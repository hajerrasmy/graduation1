import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/Database/TaskDao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Database/Model/task.dart';
import '../../Provider/AuthProvidr.dart';
import '../../auth/TextFormFieldCustom.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  TextEditingController Title = TextEditingController();

  TextEditingController Descripation = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Add New Task",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextFormFieldCustom(
              "Title",
              Mycontroller: Title,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter Task Title";
                }
                return null;
              },
            ),
            TextFormFieldCustom(
              "Description",
              Mycontroller: Descripation,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter Task Description";
                }
                return null;
              },
            ),
            InkWell(
              onTap: () {
                showData();
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    SelectedData == null
                        ? "Data  "
                        : "${SelectedData?.day} / ${SelectedData?.month} / ${SelectedData?.day}",
                    style: const TextStyle(),
                  )),
            ),
            Visibility(
                visible: showDataError,
                child: Text(
                  "Please select Task data",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                )),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                margin: EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                    onPressed: () {
                      addtask();
                    },
                    child: Text("Add Task")))
          ],
        ),
      ),
    );
  }

  bool showDataError = false;

  bool isVaildForm() {
    bool isVaild = true;
    if (formkey.currentState?.validate() == false) {
      setState(() {
        showDataError = true;
      });
      isVaild = false;
    }
    if (SelectedData == null) {
      isVaild = false;
    }
    return isVaild;
  }

  void addtask() async {
    if (!isVaildForm()) return;

    var authProvider = Provider.of<AuthProvidr>(context, listen: false);
    Task task = Task(
        title: Title.text,
        description: Descripation.text,
        dateTime: Timestamp.fromMillisecondsSinceEpoch(
            SelectedData!.millisecondsSinceEpoch));
    await TaskDao.createTask(task, authProvider.databaseUser!.id!);
    //await TaskDao.createTask(task, authProvider.databaseUser!.id!);
  }

  DateTime? SelectedData;

  Future<void> showData() async {
    var data = await showDatePicker(
        context: context,
        initialDate: SelectedData ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    setState(() {
      SelectedData = data;
      if (SelectedData != null) {
        showDataError = false;
      }
    });
  }
}
