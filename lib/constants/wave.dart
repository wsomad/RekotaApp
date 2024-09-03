import 'package:flutter/material.dart';

class Wave extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20); // Starting point
    path.quadraticBezierTo(
      size.width / 4, size.height, // Control point 1
      size.width / 2, size.height - 30, // Control point 2
    );
    path.quadraticBezierTo(
      3 * size.width / 4, size.height - 60, // Control point 3
      size.width, size.height - 20, // Ending point
    );
    path.lineTo(size.width, 0); // Draw line to top-right corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
