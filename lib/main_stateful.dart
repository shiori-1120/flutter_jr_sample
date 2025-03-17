import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jr_sample/firebase_options.dart';
import 'package:flutter_jr_sample/stateful/feature/todo_list/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Project Template',
      theme: ThemeData(),
      home: const HomePage(),
    ),
  );
}
