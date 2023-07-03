import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo/controllers/notesController.dart';
import 'package:memo/screens/noteList.dart';
import 'package:memo/screens/noteScreens/addNote.dart';


class Notes extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(145, 184, 190, 14),
              Color.fromARGB(145, 28, 179, 23),
              Color.fromARGB(145, 10, 61, 108),
        ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appBar: AppBar(title: Text("Notes")),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 8.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0,),
                  GetX<NoteController>(
                    init: Get.put<NoteController>(NoteController()),
                    builder: (NoteController noteController) {
                            if (noteController != null &&
                                noteController.notes != null) {
                              return NoteList();
                            } else {
                              return Text("No notes, create some ");
                            }
                          }), 
                ],
              ),
              )
          ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add Note",
            onPressed: () {
              Get.to(() => AddNote());
            },
            child: Icon(
              Icons.note_add,
              size: 30,
            )),
      ),
    );
  }
}