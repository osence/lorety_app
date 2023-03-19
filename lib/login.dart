import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:lorety_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final tecLogin = TextEditingController();
  final tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: tecLogin,),
          TextField(controller: tecPassword,),
          ElevatedButton(
            onPressed: () {
              print(tecLogin.text);
              print(tecPassword.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'События'),
                ),
              );
            },
            child: const Text('button'),
          ),
        ],
      ),
    );
  }
}
