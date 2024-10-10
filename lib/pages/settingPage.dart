import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/themeProvider.dart';
import 'package:easy_localization/easy_localization.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('settings'.tr()),
        ),
        leading: const Icon(
          Icons.settings,
          color: Colors.blue,
        ),
      ),
      body: Column(
        children: [
          _buildSettingItem(
            context,
            "dark_mode".tr(),
            CupertinoSwitch(
              value: Provider.of<Themeprovider>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<Themeprovider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ),
          _buildSettingItem(
            context,
            "language".tr(),
            DropdownButton<String>(
              value: context.locale.languageCode,
              items: [
                DropdownMenuItem(value: 'en', child: Text('english'.tr())),
                DropdownMenuItem(value: 'fr', child: Text('french'.tr())),
                DropdownMenuItem(value: 'sw', child: Text('swahili'.tr())),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  context.setLocale(Locale(newValue));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      BuildContext context, String title, Widget trailing) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
