import 'package:flutter/material.dart';

class eventDescription extends StatelessWidget {
  const eventDescription({Key? key, required this.fullDescription}) : super(key: key);
  final String fullDescription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Информация')),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(child: Text(fullDescription)),
        ));
  }
}
