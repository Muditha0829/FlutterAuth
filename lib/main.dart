import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/Wrapper.dart';
import 'package:mytodo/screens/login.dart';
import './screens/home.dart';
import 'firebase_options.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    
    final FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    

    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: Wrapper(),
    );
  }
}

//IT20233358
//Diunugala M W