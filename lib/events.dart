import 'package:flutter/material.dart';
import 'package:lorety_app/API/get_event_request.dart';

class EventBox extends StatelessWidget {
  const EventBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    fetchEvents();
    return Container();
  }
}
