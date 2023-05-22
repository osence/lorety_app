import 'package:flutter/material.dart';

import 'API/get_event.dart';
import 'API/post_login.dart';
import 'event_box.dart';



class MyEventsPage extends StatelessWidget {
  MyEventsPage({Key? key, required this.token}) : super(key: key);
  final String token;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchMyEvents(token),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            //TODO Error screen
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                    snapshot.data!.map((x) => EventBox(event: x)).toList(),
                  ),
                ),
              ),
            );
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}
