import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

class Event {
  final int id;
  final String event_url;
  final String? date;
  final int? organizer_id;
  final int? location_id;
  final String? finish_date;
  final String? start_time;
  final String? finish_time;
  final String? description;
  final String? description_html;
  final String? full_description;
  final String? place;
  final String? place_premises;
  final double? place_lat;
  final double? place_lon;
  final String? cover;
  final String? cover_preload;
  final String? ym_code;
  final int? payment_type;
  final int? count_places;
  final double? price;
  final int? amount_ticket_categories;
  final int? age_category_rars;
  final int? visibility_status;
  final List<dynamic>? tags;
  final bool? in_bookmark;
  final int? is_finalize;
  final String? whatsapp_template;
  final int? seating_id;

  Event(
      this.id,
      this.event_url,
      this.date,
      this.organizer_id,
      this.location_id,
      this.finish_date,
      this.start_time,
      this.finish_time,
      this.description,
      this.description_html,
      this.full_description,
      this.place,
      this.place_premises,
      this.place_lat,
      this.place_lon,
      this.cover,
      this.cover_preload,
      this.ym_code,
      this.payment_type,
      this.count_places,
      this.price,
      this.amount_ticket_categories,
      this.age_category_rars,
      this.visibility_status,
      this.tags,
      this.in_bookmark,
      this.is_finalize,
      this.whatsapp_template,
      this.seating_id);
}

Future<List<Event>?>? fetchEvents() async {
  final dio = Dio();
  final List<Event> events_list = [];
  final response = await dio.get(
    'https://api-dev.lorety.com/v2/events/',
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      for (var i = 0; i < response.data.length; i++) {
        events_list.add(Event(
          response.data[i]['id'],
          response.data[i]['event_url'],
          response.data[i]['date'],
          response.data[i]['organizer_id'],
          response.data[i]['location_id'],
          response.data[i]['finish_date'],
          response.data[i]['start_time'],
          response.data[i]['finish_time'],
          response.data[i]['description'],
          response.data[i]['description_html'],
          response.data[i]['full_description'],
          response.data[i]['place'],
          response.data[i]['place_premises'],
          response.data[i]['place_lat'],
          response.data[i]['place_lon'],
          response.data[i]['cover'],
          response.data[i]['cover_preload'],
          response.data[i]['ym_code'],
          response.data[i]['payment_type'],
          response.data[i]['count_places'],
          response.data[i]['price'],
          response.data[i]['amount_ticket_categories'],
          response.data[i]['age_category_rars'],
          response.data[i]['visibility_status'],
          response.data[i]['tags'],
          response.data[i]['in_bookmark'],
          response.data[i]['is_finalize'],
          response.data[i]['whatsapp_template'],
          response.data[i]['seating_id'],
        ));
      }
      return events_list;
      //events_list содержит все события
    } catch (e) {
      print(e);
      return null;
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to GET ${response.statusCode}');
  }
  return null;
}
