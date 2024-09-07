import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/presentation/components/drawer_tile.dart';
import 'package:notes/presentation/settings_page.dart';

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
          DrawerHeader(
            child: Icon(Icons.note),
          ),
          DrawerTile(
            title: "Notes",
            leading: Icon(
              CupertinoIcons.house_alt_fill,
              size: 18,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onTap: () {},
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsPage()),);
            },
          ),
        ],
      ),
    );
  }
}
