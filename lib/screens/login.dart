import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/screens/home.dart';
import 'package:mytodo/screens/register.dart';
import 'package:mytodo/services/auth.dart';
 
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
 
  static const String _title = 'MyToDo';
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: LoginWidget(),
      ),
    );
  }
}
 
class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);
 
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}
 
class _LoginWidgetState extends State<LoginWidget> {

  final AuthService _auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'MyToDo',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 250, 10, 10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    dynamic result = await _auth.signInEmail(emailController.text, passwordController.text);
                    if(result=='Success'){
                      print('done');
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> Home()));
                    }else{
                      print(result);
                    }
                  },
                )
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign In Anon'),
                  onPressed: () async {
                    dynamic result = await _auth.SignInAnon();
                    if(result!=null){
                      print(result);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> Home()));
                    }else{
                      print(result);
                    }
                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 14),
                  ),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const Register()));
                  },
                )
              ],
            ),
            
          ],
        ));
  }
}
