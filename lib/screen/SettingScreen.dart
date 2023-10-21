import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;



  @override
  Widget build(BuildContext context) {
    //AdaptiveTheme.of(context).mode.isLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Section 1'),
            tiles: [
              SettingsTile(
                title: const Text('Language'),
                value: const Text('English'),
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: const Text('Change Theme'),
                leading: const Icon(Icons.brightness_4),
                onToggle: (value) {
                  print("Switched: $value");
                  setState(() {
                    isSwitched = value;
                    if (value) {
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      AdaptiveTheme.of(context).setLight();
                    }
                  });
                },

                initialValue: isSwitched,
                activeSwitchColor: Colors.blue,
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Section 2'),
            tiles: [
              SettingsTile(
                title: const Text('Security'),
                //  subtitle: 'Fingerprint',
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: const Text('Use fingerprint'),
                leading: const Icon(Icons.fingerprint),
                // switchValue: true,
                onToggle: (value) {}, initialValue: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
