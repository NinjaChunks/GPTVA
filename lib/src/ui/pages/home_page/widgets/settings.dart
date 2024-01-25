import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 4.0), // Adjust as needed
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            CustomListTile(
              
              title: 'Notification Settings',
              
              onTap: () {
                // Add functionality for handling notification settings
              },
            ),
            
            CustomListTile(
              title: 'Account Settings',
              onTap: () {
                // Add functionality for handling account settings
              },
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: const Text(
                'Assistant Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CustomListTile(
              title: 'Assistant Voice',
              onTap: () {
                // Add functionality for handling theme settings
              },
            ),
            CustomListTile(
              title: 'Assistant Language',
              onTap: () {
                // Add functionality for handling language settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
