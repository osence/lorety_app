import 'package:flutter/material.dart';
import 'package:lorety_app/API/get_event.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:lorety_app/API/get_event_photos.dart';
import 'package:lorety_app/event_description.dart';
import 'package:share_plus/share_plus.dart';
import 'event_box.dart';
import 'event_join.dart';


class EventsPage extends StatelessWidget {
  EventsPage({Key? key}) : super(key: key);
  Future<List<Event>> _events_list = fetchEvents();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchEvents(),
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
