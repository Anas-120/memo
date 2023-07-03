import 'dart:async';

import 'package:flutter/material.dart';

class SplashServices{
  
  void enter(BuildContext context){
    Timer(const Duration(seconds: 5), (
      () => Navigator.pushNamed(context, 'homePage')));
  }
}