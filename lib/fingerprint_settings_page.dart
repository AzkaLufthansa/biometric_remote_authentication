import 'package:flutter/material.dart';

class FingerprintSettingsPage extends StatefulWidget {
  const FingerprintSettingsPage({super.key});

  @override
  FingerprintSettingsPageState createState() => FingerprintSettingsPageState();
}

class FingerprintSettingsPageState extends State<FingerprintSettingsPage> {
  bool _isFingerprintEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enable Fingerprint Authentication',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Enable Fingerprint'),
              value: _isFingerprintEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isFingerprintEnabled = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action when the button is pressed, e.g., save the setting
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
