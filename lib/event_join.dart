import 'package:flutter/material.dart';
import 'package:lorety_app/API/get_event.dart';
import 'package:lorety_app/API/get_event_categories.dart';

import 'counter_widget.dart';

class eventJoin extends StatefulWidget {
  const eventJoin({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<eventJoin> createState() => _eventJoinState();
}

class _eventJoinState extends State<eventJoin> {
  @override
  Widget build(BuildContext context) {
    Future<Event?> event_info = fetchEvent(widget.id);
    String? schedule = '';
    var event;
    int? category_value = 1;
    List<Widget> content = [];
    return Scaffold(
      appBar: AppBar(title: Text('Информация')),
      body: FutureBuilder(
          future: event_info,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              //TODO Error screen
              return Container(
                color: Colors.green,
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              event = snapshot.data;
              if (event.finish_date != null &&
                  event.date != event.finish_date) {
                schedule =
                    '$schedule${event.date.toString()} - ${event.finish_date.toString()}';
              } else {
                schedule = '$schedule${event.date.toString()}';
              }
              schedule =
                  '$schedule с ${event.start_time.toString()} до ${event.finish_time.toString()}';

              content.add(
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(event.description + ' ' + schedule),
                ),
              );
              content.add(
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('Вы можете забронировать несколько мест:'),
                      Container(
                          width: 100,
                          child: CounterView(
                            initNumber: 1,
                            minNumber: 1,
                            maxNumber: event.count_places >= 1
                                ? event.count_places
                                : 10,
                          ))
                    ],
                  ),
                ),
              );

              if (event.amount_ticket_categories > 0) {
                Future<List<EventCategory>> categories_info =
                    fetchCategories(event.id);
                content.add(FutureBuilder(
                  future: categories_info,
                  builder: (context, snapshot) {
                    // Check for errors
                    if (snapshot.hasError) {
                      //TODO Error screen
                      return Container(
                        color: Colors.green,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      var categories = snapshot.data;
                      List<Widget> categories_widget = [Text('Выберите категорию билета'),];
                      for (int i = 0 ; i < categories!.length; i++){
                        var category = categories![i];
                        categories_widget.add(ListTile(
                          title: Text(category.name!),
                          leading: Radio<int>(
                            value: category.order,
                            groupValue: category_value,
                            onChanged: (int? value) {
                              setState(() {
                                category_value = value;
                              });
                            },
                          ),
                        ),);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: categories_widget
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  },
                ));
              }

              return Column(children: content);
            }
            // Otherwise, show something whilst waiting for initialization to complete
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }),
    );
  }
}
