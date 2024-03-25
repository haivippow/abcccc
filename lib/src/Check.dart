import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlcv/src/resources/login_page.dart';

import 'blocs/auth_bloc.dart';

class CheckHome extends StatefulWidget {
  const CheckHome({super.key});

  @override
  State<CheckHome> createState() => _CheckHomeState();
}

class _CheckHomeState extends State<CheckHome> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {


    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/tasklist.png',width: 300,height: 300,)
      ),
    );
  }
}
