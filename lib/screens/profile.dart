import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mytodo/screens/login.dart';
import 'package:mytodo/screens/resetPassword.dart';

import '../services/auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext contexta) {
    final AuthService _auth = AuthService();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Profile'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Logout'),
                      onPressed: () async {
                        dynamic result = await _auth.signOut();
                        _auth.authStateCheck();
                        if (result == 'Success') {
                          Navigator.push(contexta,
                              MaterialPageRoute(builder: (_) => Login()));
                        }
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Reset Password'),
                      onPressed: () async {
                        Navigator.push(
                            contexta,
                            MaterialPageRoute(
                                builder: (_) => const ResetPassword()));
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Verify Email'),
                      onPressed: () async {
                        _auth.authStateCheck();
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Delete Account'),
                      onPressed: () async {
                        showDialog<String>(
                          context: contexta,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete Account'),
                            content: const Text(
                                'If you delete this account, you will be lost your entered data and this account cannot be recovered again'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context, 'OK');
                                  dynamic result = await _auth.deleteUser();
                                  print(result);
                                  if (result == 'Success') {
                                    Navigator.push(
                                        contexta,
                                        MaterialPageRoute(
                                            builder: (_) => Login()));
                                  } else {
                                    print('Error');
                                  }
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ],
            )));
  }
}
