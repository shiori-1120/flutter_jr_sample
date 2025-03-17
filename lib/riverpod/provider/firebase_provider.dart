import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
