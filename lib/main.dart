

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qlcv/src/app.dart';
import 'package:qlcv/src/resources/home_page.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}




