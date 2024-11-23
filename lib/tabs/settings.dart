import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/firebase_services.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/screens/login.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .075,
        ),
        ListTile(
          contentPadding: EdgeInsets.only(right: 5, left: 20),
          title: Text(
            'Theme',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          trailing: DropdownButton(
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 22),
            borderRadius: BorderRadius.circular(12),
            value: Provider.of<ThemeProvider>(context).getTheme(),
            items: [
              DropdownMenuItem<bool>(value: false, child: Text('Light')),
              DropdownMenuItem<bool>(
                value: true,
                child: Text('Dark'),
              )
            ],
            onChanged: (value) {
              if (value != null) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme(value);
              }
            },
          ),
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(right: 5, left: 20),
          title: Text(
            'Logout',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          trailing: IconButton(
              padding: EdgeInsets.symmetric(horizontal: 0),
              onPressed: () {
                FirebaseServices.logout();
                Navigator.pushReplacementNamed(context, Login.routeName);
              },
              icon: Icon(
                Icons.logout,
                color: const Color.fromARGB(255, 208, 14, 0),
                size: 30,
              )),
        ),
      ],
    );
  }
}
