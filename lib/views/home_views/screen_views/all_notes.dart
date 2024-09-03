import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/views/home_views/components/app_bar.dart';

import '../components/drawer.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({super.key});

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  final List<String> notes = [
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 4',
    'Note 5',
    'Note 6',
    'Note 7',
    'Note 8',
    'Note 9',
    'Note 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'All Notes',
      ),
      drawer: const SafeArea(child: DrawerComponents()),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: GridView.builder(
              itemCount: notes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Column
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 25, // Spacing between rows
                childAspectRatio: 1 / 2, // Aspect ratio to control height
              ),
              itemBuilder: (context, index) {
                String note = notes[index];
                return Column(
                  children: [
                    Expanded(
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: InkWell(
                          onTap: () {
                            print('Note $note clicked');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lorem ipsum dolor sit amet...', // Sample content
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5), // Space between card and text
                    Text(
                      'Note ${index + 1}', // This is the text below the card
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '03/09', // This is the text below the card
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 20, 30),
              child: FloatingActionButton(
                onPressed: () {
                  print('Floating Action Button pressed');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: primaryColor,
                foregroundColor: whiteTextColor,
                elevation: 0,
                child: const Icon(Icons.mode_edit_rounded),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
