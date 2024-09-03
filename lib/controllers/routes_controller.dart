import 'package:flutter/material.dart';
import 'package:task_management_app/views/authentication_views/auth_screen.dart';

import '../views/home_views/screen_views/all_notes.dart';
import '../views/home_views/screen_views/trash.dart';

class RoutesController {
  static const String allNotes = '/all_notes';
  static const String trash = '/trash';
  static const String auth = '/auth';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allNotes:
        return MaterialPageRoute(builder: (_) => const AllNotes()); 
      case trash:
        return MaterialPageRoute(builder: (_) => const Trash());
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      default:
        return MaterialPageRoute(builder: (_) => const AllNotes());
    }
  }
}