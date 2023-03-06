import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/screens/login.dart';

import '../services/auth.dart';
import 'screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!=null){
      return Home();
    }
    else{
      return const Login();
    }

  }
}
