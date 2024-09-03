import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  
  const CustomAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      iconTheme: IconThemeData(color: primaryColor),
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search), 
          onPressed: () {
            print('Search icon clicked');
          },
          color: primaryColor, 
        ),
        IconButton(
          icon: const Icon(Icons.more_vert), 
          onPressed: () {
            print('More options icon clicked');
          },
          color: primaryColor,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}