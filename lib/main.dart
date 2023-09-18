import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_words/app_widget.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(App());
}
