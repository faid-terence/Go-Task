import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/themeProvider.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Consumer<Themeprovider>(builder: (context, themePovider, child) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark theme"),
              trailing: Switch(
                  value: themePovider.isDark,
                  onChanged: (value) => themePovider.changeTheme()),
            )
          ],
        );
      }),
    );
  }
}
