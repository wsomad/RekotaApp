import 'package:flutter/material.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/controllers/routes_controller.dart';

class DrawerComponents extends StatefulWidget {
  const DrawerComponents({super.key});

  @override
  State<DrawerComponents> createState() => _DrawerComponentsState();
}

class _DrawerComponentsState extends State<DrawerComponents> {
  final List<String> itemName = ['All Notes', 'Trash'];

  final List<Icon> itemIcon = [
    Icon(
      Icons.notes_rounded,
      color: primaryColor,
    ),
    Icon(
      Icons.delete,
      color: primaryColor,
    )
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align to the right
              children: [
                const Text(
                  'Rekota',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings_rounded,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    print('Settings clicked');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              itemCount: itemName.length,
              itemBuilder: (context, index) {
                String item = itemName[index];
                Icon icon = itemIcon[index];
                bool isSelected = index == _selectedIndex;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          print(_selectedIndex);
                        });

                        String routeName = '/all_notes';
                        if (item == 'All Notes') {
                          routeName = RoutesController.allNotes;
                        }
                        else if (item == 'Trash') {
                          routeName = RoutesController.trash;
                        }
                        Navigator.pushNamed(context, routeName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? veryLightGreyColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: icon,
                          title: Text(
                            item,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Text(
                            '16',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
