import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/src/model/user_id.dart';
import 'package:qlcv/src/resources/home_page.dart';
import 'package:qlcv/src/resources/login_page.dart';
class KiemTra extends StatelessWidget {
  const KiemTra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            final user = FirebaseAuth.instance.currentUser!;

            //print(user1.userId);
            return HomePage(userId: user.uid,);
          }
          else{
            return LoginPage();
          }
        },
      ),
    );
  }
}
