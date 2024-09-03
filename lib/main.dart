import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/controllers/routes_controller.dart';

import 'views/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDKMSNeLufcgmyIHZCHjZ5xCoRLApEip2M',
      appId: '1:232482906594:android:abb435d8e3930f991bd9bb',
      messagingSenderId: '232482906594',
      projectId: 'task-management-app-8d2d4',
      storageBucket: 'task-management-app-8d2d4.appspot.com',
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      onGenerateRoute: RoutesController.generateRoute,
      home: const Wrapper(), 
    );
  }
}
