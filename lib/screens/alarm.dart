import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:memo/data/database.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {

  var minList = [for (var i = 0; i <= 59; i++) i];
  var hrsList = [for (var i = 0; i <= 23; i++) i];
  
  TextEditingController reason=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 184, 190, 14),
              Color.fromARGB(255, 28, 179, 23),
              Color.fromARGB(255, 10, 61, 108),
        ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 55,),
                AlarmView(),
                SizedBox(height: 35,),
                ElevatedButton(
                  onPressed: () => FlutterAlarmClock.showAlarms(),
                  child: Text("Show Alarms"),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
           createAlertDialog(context).then((onValue) {
                  //users.add(onValue);
                  setState(() {});
              });
          },
          child: Icon(Icons.add_alarm,color: Colors.white,),
        ),
      ),
    );
  }
  Future createAlertDialog(BuildContext context) async{
    TextEditingController customController = TextEditingController();
    int hrsvalue=hrsList.first,minvalue=minList.first;
    return await showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text("Create Reminding Alarm!"),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromARGB(255, 255, 173, 59),
                              borderRadius: BorderRadius.circular(11)),
                          child: Center(
                            child: Column(
                              children: [
                                Text('Hrs'),
                                DropdownButton<int>(
                                  // Initial Value
                                  value: hrsvalue,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),    
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueAccent,
                                    ),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (int? newValue) { 
                                    setState(() {
                                      hrsvalue = newValue!;
                                    });
                                  },
                                  // Array list of items
                                  items: hrsList.map<DropdownMenuItem<int>>((int items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()),
                                    );
                                  }).toList(),
                                  
                                ),
                                /*TextField(
                                  textAlign: TextAlign.center,
                                  controller: hourController,
                                  keyboardType: TextInputType.number,
                                ),*/
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,child: Center(child: Text(':')),),
                        Container(
                          height: 80,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromARGB(255, 255, 173, 59),
                              borderRadius: BorderRadius.circular(11)),
                          child: Center(
                            child: Column(
                              children: [
                                Text('Mins'),
                                DropdownButton(
                                  // Initial Value
                                  value: minvalue,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueAccent,
                                  ),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (int? newValue) { 
                                    setState(() {
                                      minvalue = newValue!;
                                    });
                                  },
                                  // Array list of items
                                  items: minList.map((int items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()),
                                    );
                                  }).toList(),
                                  
                                ),
                                /*TextField(
                                  textAlign: TextAlign.center,
                                  controller: minuteController,
                                  keyboardType: TextInputType.number,
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextField(controller: reason,decoration: InputDecoration(hintText: 'Reminder Reason'),)
                  ],
                );}
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    MaterialButton(
                        elevation: 5.0,
                        child: Text("OK"),
                        onPressed: () {
                          int hour, minutes;
                          hour = hrsvalue;
                          minutes=minvalue;
                          String reson=reason.text.toString();

                     
                    // creating alarm after converting hour
                    // and minute into integer
                        FlutterAlarmClock.createAlarm(hour, minutes,title:reson);
                        Get.back();
                        }),
                  ],
                )
              ],
            ),
          );
        });
  }
}
class AlarmView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: AlarmPainter(),
        ),
      ),
    );
  }
}

class AlarmPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()//..color = Color.fromARGB(255, 12, 20, 91);
      ..shader = RadialGradient(colors: [Color.fromARGB(255, 12, 20, 91),Color(0xFF748EF6)])
        .createShader(Rect.fromCircle(center: center, radius: radius));
    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var leftcap = Paint()
      ..shader = LinearGradient(colors: [Color.fromARGB(255, 12, 20, 91),Color(0xFF748EF6)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var rightcap = Paint()
      ..shader = LinearGradient(colors: [Color(0xFF748EF6),Color.fromARGB(255, 12, 20, 91)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);
    canvas.drawCircle(center, 16, centerFillBrush);

    var hourHandX = centerX - 60 * cos(pi/4);
    var hourHandY = centerX + 60 * sin(pi/4);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 88 * cos(0);
    var minHandY = centerX + 88 * sin(0);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var p1X = centerX + 135 * cos(pi/3);
    var p1Y = centerX - 135 * sin(pi/3);
    var p2X = centerX + 135 * cos(pi/8);
    var p2Y = centerX - 135 * sin(pi/8);
    canvas.drawLine(Offset(p1X,p1Y), Offset(p2X,p2Y), leftcap);

    var pb1X = centerX + 135 * cos(pi/3);
    var pb1Y = centerX + 135 * sin(pi/3);
    var pb2X = centerX + 135 * cos(pi/8);
    var pb2Y = centerX + 135 * sin(pi/8);
    canvas.drawLine(Offset(pb1X,pb1Y), Offset(pb2X,pb2Y), rightcap);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
