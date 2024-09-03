import 'package:flutter/material.dart';
import 'package:task_management_app/controllers/routes_controller.dart';

import '../controllers/authentication_controller.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthenticationController.checkIfUserSignedIn(), // Perform the check
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!) {
          return const MaterialApp(
            initialRoute: RoutesController.auth,
            onGenerateRoute: RoutesController.generateRoute,
          );
        } else {
          return const MaterialApp(
            initialRoute: RoutesController.allNotes,
            onGenerateRoute: RoutesController.generateRoute,
          );
        }
      },
    );
  }
}