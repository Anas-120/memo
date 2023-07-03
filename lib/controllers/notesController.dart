import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo/data/database.dart';
import 'package:memo/models/noteModel.dart';

class NoteController extends GetxController{
  RxList<NoteModel> noteList = RxList<NoteModel>();
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> bodyController = TextEditingController().obs;

  List<NoteModel> get notes => noteList.value;

  @override
  void onInit() async{
    String? uid = await Database().getId();
    print("NoteController onit :: $uid");
    noteList
        .bindStream(Database().noteStream(uid!)); //stream coming from firebase
    super.onInit();
  }
}