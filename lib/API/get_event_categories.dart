import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

class EventCategory {
  final int id;
  final String? name;
  final double price;
  final int busy_count_places;
  final int event_id;
  final String? description;
  final int count_places;
  final int order;

  EventCategory(
    this.id,
    this.name,
    this.price,
    this.busy_count_places,
    this.event_id,
    this.description,
    this.count_places,
    this.order,
  );
}

Future<List<EventCategory>> fetchCategories(int id) async {
  final dio = Dio();
  final List<EventCategory> categoriesList = [];
  final response = await dio.get(
    'https://api-dev.lorety.com/v2/event/ticket_categories/$id',
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      for (var i = 0; i < response.data.length; i++) {
        categoriesList.add(EventCategory(
          response.data[i]['id'],
          response.data[i]['name'],
          response.data[i]['price'],
          response.data[i]['busy_count_places'],
          response.data[i]['event_id'],
          response.data[i]['description'],
          response.data[i]['count_places'],
          response.data[i]['order'],
        ));
      }
      print(categoriesList);
      categoriesList.sort((a, b) => a.order.compareTo(b.order));
      return categoriesList;
      //events_list содержит все события
    } catch (e) {
      print(e);
      return <EventCategory>[];
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to GET ${response.statusCode}');
  }
}
