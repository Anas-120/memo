import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memo/models/noteModel.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class Database{
  
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final String usercollection="Users";
  final String notecollection="notes";
  final String alarmcollection="alarm";

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  late var userid=getId();

  Future<void> addNote(String title,String body)async{
    try{
      String? uid = await userid;
      var uuid = Uuid().v4();
      await _db
        .collection(usercollection)
        .doc(uid)
        .collection(notecollection)
        .doc(uuid)
        .set({"id":uuid,"title":title,"body":body,"CreationDate":Timestamp.now()});
    }catch(e){
      print(e);
    }
  }

  Future<void> updateNote(String uid,String title,String body,String id)async{
    try{
      await _db
        .collection(usercollection)
        .doc(uid)
        .collection(notecollection)
        .doc(id)
        .update({"title":title,"body":body,"CreationDate":Timestamp.now()});
    }catch(e){
      print(e);
    }
  }

  Future<void> delete(String uid,String id)async{
    try{
      await _db
        .collection(usercollection)
        .doc(uid)
        .collection(notecollection)
        .doc(id)
        .delete();
    }catch(e){
      print(e);
    }
  }


  Stream<List<NoteModel>> noteStream(String uid){
      return _db
        .collection(usercollection)
        .doc(uid)
        .collection(notecollection)
        .orderBy("CreationDate",descending: true)
        .snapshots()
        .map((QuerySnapshot querry){
          List<NoteModel> val =[];
          querry.docs.forEach((element) { val.add(NoteModel.fromDocumentSnapshot(element));
          });
        return val;
        });
  }

}