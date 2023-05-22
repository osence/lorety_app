import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:lorety_app/main.dart';
import 'package:lorety_app/API/post_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tecLogin = TextEditingController();
  final tecPassword = TextEditingController();
  //TODO баг: после перехода на окно назад, остаётся вывод об ошибке _validate
  bool _validate = false;
  late AuthToken? _token;

  void getToken() async {
    final _token = await fetchAuthToken(_tecLogin.text, tecPassword.text);
    if (_token != null) {
      _validate = false;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'События', token: _token.access_token,)));
    } else {
      setState(() {
        print('test');
        _validate = true;
        tecPassword.clear();
      });
    }
  }
  //TODO Поменять цвет курсора(маркера) под текстом с белого на другой
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          //TODO Logo
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              cursorColor: Colors.black,
              controller: _tecLogin,

              decoration: const InputDecoration(
                  labelText: 'EMail',
                  labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  // hintText: 'EMAIL',
                  // hintStyle: ,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
            ),
            const SizedBox(height: 10.0),
            TextField(
              cursorColor: Colors.black,
              controller: tecPassword,
              decoration: InputDecoration(
                  labelText: 'Пароль ',
                  labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                  ),
                  errorText: _validate?'Неправильный EMail или Пароль':null,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 50.0),
            GestureDetector(
              child: Container(
                height: 40.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: InkWell(
                    onTap: () async {
                      getToken();
                    },
                    child: const Center(
                      child: Text('ВОЙТИ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              child: Container(
                height: 40.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: InkWell(
                    onTap: () {
                      print('sdfsdf');
                      //TODO Регистрация
                    },
                    child: const Center(
                      child: Text('РЕГИСТРАЦИЯ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 15.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       'New to Spotify?',
            //       style: TextStyle(
            //         fontFamily: 'Montserrat',
            //       ),
            //     ),
            //     SizedBox(width: 5.0),
            //     InkWell(
            //       child: Text('Register',
            //           style: TextStyle(
            //               color: Colors.green,
            //               fontFamily: 'Montserrat',
            //               fontWeight: FontWeight.bold,
            //               decoration: TextDecoration.underline)),
            //     )
            //   ],
            // )
          ]),
    ));
  }
}
