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
        title: Text('settings'.tr()),
        centerTitle: true,
        leading: const Icon(
          Icons.settings,
          color: Colors.blue,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildSectionTitle(context, 'appearance'.tr()),
          _buildSettingItem(
            context,
            "dark_mode".tr(),
            _buildThemeToggle(context),
            icon: Icons.dark_mode,
          ),
          _buildSectionTitle(context, 'language'.tr()),
          _buildLanguageSelector(context),
          const SizedBox(height: 20),
          _buildVersionInfo(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, Widget trailing,
      {IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Consumer<Themeprovider>(
      builder: (context, themeProvider, child) {
        return CupertinoSwitch(
          value: themeProvider.isDarkMode,
          onChanged: (_) => themeProvider.toggleTheme(),
          activeColor: Theme.of(context).colorScheme.primary,
        );
      },
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Column(
      children: [
        _buildLanguageOption(context, 'English', const Locale('en')),
        _buildLanguageOption(context, 'Français', const Locale('fr')),
        _buildLanguageOption(context, 'Kiswahili', const Locale('sw')),
      ],
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String languageName, Locale locale) {
    final isSelected = context.locale == locale;
    return InkWell(
      onTap: () => context.setLocale(locale),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languageName,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionInfo(BuildContext context) {
    return Center(
      child: Text(
        'version'.tr(args: ['1.0.0']),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
          fontSize: 12,
        ),
      ),
    );
  }
}
