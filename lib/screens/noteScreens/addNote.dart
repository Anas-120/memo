import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memo/controllers/notesController.dart';
import 'package:memo/data/database.dart';
import 'package:get/get.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final _formKey=GlobalKey<FormState>();
  var uid = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).get().toString();
  final titlecontroller=TextEditingController();
  final desccontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: 
          BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bgimg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            )
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                width: 400,
                height: 550,
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(200, 13, 65, 108),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titlecontroller,
                            decoration: InputDecoration(
                              hintText: "Title",
                              hintStyle: TextStyle(color: Colors.white54),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3.5,
                                  color: Colors.blueGrey
                                ))),
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: desccontroller,
                            maxLines: 10,
                            decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none),
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white),)
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (titlecontroller.text.length == 0 &&
              desccontroller.text.length == 0) {
            showEmptyTitleDialog(context);
          } else {
            Database().addNote(titlecontroller.text,
                desccontroller.text);
            Get.back();
          }
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),    
      ),
    );
  }
}

void showEmptyTitleDialog(BuildContext context) {
  print("in dialog ");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Text(
          "Notes is empty!",
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Text(
          'The content of the note cannot be empty to be saved.',
          style: Theme.of(context).textTheme.subtitle1,
        ),
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