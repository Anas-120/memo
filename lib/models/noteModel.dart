import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel{
  String? id;
  String? title;
  String? body;
  Timestamp? CreationDate;

  NoteModel({
    this.id,
    this.title,
    this.body,
    this.CreationDate
  });

  NoteModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    id = documentSnapshot["id"];
    title = documentSnapshot["title"];
    body = documentSnapshot["body"];
    CreationDate = documentSnapshot["CreationDate"];
  }

  NoteModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    title = json["title"];
    body = json["body"];
    CreationDate = json["CreationDate"];
  }
}