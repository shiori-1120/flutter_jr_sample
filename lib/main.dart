import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jr_sample/firebase_options.dart';
import 'package:flutter_jr_sample/practice_riverpod/feature/todo_list/view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Project Template',
        theme: ThemeData(),
        home: const HomePage(),
      ),
    ),
  );
}
