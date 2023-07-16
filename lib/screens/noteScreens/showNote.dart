import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memo/models/noteModel.dart';
import 'package:memo/data/database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowNote extends StatelessWidget {
  final NoteModel noteData;
  final int index;
  ShowNote({ required this.noteData, required this.index});
  //final AuthController authController = Get.find<AuthController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    titleController.text = noteData.title!;
    bodyController.text = noteData.body!;
    var formattedDate =
        DateFormat.yMMMd().format(noteData.CreationDate!.toDate());
    var time = DateFormat.jm().format(noteData.CreationDate!.toDate());
    return Container(
      alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                        Color.fromARGB(145, 23, 220, 46),
                        Color.fromARGB(255, 109, 176, 221),
                        Color.fromARGB(255, 22, 119, 222),
                        Color.fromARGB(255, 8, 105, 170),
                        Color.fromARGB(255, 109, 176, 221),
                        Color.fromARGB(145, 23, 220, 46),
            ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: Color.fromARGB(255, 34, 255, 126),
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                        ),
                      ),
                      IconButton(
                        color: Color.fromARGB(255, 34, 255, 126),
                        onPressed: () {
                          showDeleteDialog(context, noteData);
                        },
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("$formattedDate at $time",style: TextStyle(color: Colors.white),),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: titleController,
                            cursorColor: Colors.white,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: "Title",
                              hintStyle: TextStyle(color: Colors.white54)
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autofocus: true,
                            controller: bodyController,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: "Type something...",
                              hintStyle: TextStyle(color: Colors.white54)
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (titleController.text != noteData.title ||
                  bodyController.text != noteData.body) {
                Database().updateNote(titleController.text, bodyController.text, noteData.id!);
                Get.back();
                titleController.clear();
                bodyController.clear();
              } else {
                showSameContentDialog(context);
              }
            },
            label: Text("Save"),
            icon: Icon(Icons.save),
          )),
    );
  }
}

void showDeleteDialog(BuildContext context, noteData) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          "Delete Note?",
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Text("Are you sure you want to delete this note?",
            style: Theme.of(context).textTheme.subtitle1),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Yes",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onPressed: () {
              Get.back();
              Database().delete(noteData.id);
              Get.back(closeOverlays: true);
            },
          ),
          TextButton(
            child: Text(
              "No",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showSameContentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          "No change in content!",
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Text("There is no change in content.",
            style: Theme.of(context).textTheme.subtitle1),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Okay",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    },
  );
}