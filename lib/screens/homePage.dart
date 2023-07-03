import 'package:flutter/material.dart';
import 'package:memo/screens/alarm.dart';
import 'package:memo/screens/home.dart';
import 'package:memo/screens/notes.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int pageIndex =1;
  final _pageList = [Alarm(),Home(),Notes()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Memo'),
        centerTitle: true,),
      body: _pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        mouseCursor: MouseCursor.defer,
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.alarm_rounded),label:"Reminding Alarm"),
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label:"Home"),
        BottomNavigationBarItem(icon: Icon(Icons.note_rounded),label:"Notes")
        ],
        currentIndex: pageIndex,
        onTap: ((value) {
          setState(() {
            pageIndex=value;
          });
        }
        ),
    ),
    );
  }
}