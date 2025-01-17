import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings_page.dart';
import 'drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const DrawerHeader(
            child: Icon(CupertinoIcons.pencil_circle_fill, size: 50,),
          ),
          DrawerTile(
            title: "Notes",
            leading: Icon(
              CupertinoIcons.house_alt_fill,
              size: 18,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          DrawerTile(
            title: "Settings",
            leading: Icon(
              CupertinoIcons.settings,
              size: 18,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
