import 'package:flutter/material.dart';
import 'package:memo/services/splashServices.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  SplashServices splashServices = SplashServices();
  void initState(){
    super.initState();
    splashServices.enter(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/bgimg.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3), 
          BlendMode.darken)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: 450,
            width: 350,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(250)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(185, 100, 9, 164),
                  Color.fromARGB(184, 22, 70, 182),
                  Color.fromARGB(185, 13, 93, 212),
                  Color.fromARGB(184, 22, 70, 182),
                  Color.fromARGB(185, 100, 9, 164),
                    
                ])
            ),
            child: Text('Get Reminded!\n\nwith Memo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(225, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 35.0,
            ),
            ),
          ),
        ),
        ),
    );
  }
}
