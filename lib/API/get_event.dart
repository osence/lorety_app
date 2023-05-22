import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

import 'post_login.dart';

class Event {
  final int id;
  final String? event_url;
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
  final double place_lat;
  final double place_lon;
  final String? cover;
  final String? cover_preload;
  final String? ym_code;
  final int payment_type;
  final int count_places;
  final double price;
  final int? amount_ticket_categories;
  final int age_category_rars;
  final int visibility_status;
  final List<dynamic> tags;
  final bool in_bookmark;
  final int is_finalize;
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

Future<Event?> fetchEvent(String eventId) async {
  final dio = Dio();
  final Event event;
  final response = await dio.get(
    'https://api-dev.lorety.com/v2/event/$eventId',
  );
  if (response.statusCode == 200) {
    try {
      event = Event(
        response.data['id'],
        response.data['event_url'],
        response.data['date'],
        response.data['organizer_id'],
        response.data['location_id'],
        response.data['finish_date'],
        response.data['start_time'],
        response.data['finish_time'],
        response.data['description'],
        response.data['description_html'],
        response.data['full_description'],
        response.data['place'],
        response.data['place_premises'],
        response.data['place_lat'],
        response.data['place_lon'],
        response.data['cover'],
        response.data['cover_preload'],
        response.data['ym_code'],
        response.data['payment_type'],
        response.data['count_places'],
        response.data['price'],
        response.data['amount_ticket_categories'],
        response.data['age_category_rars'],
        response.data['visibility_status'],
        response.data['tags'],
        response.data['in_bookmark'],
        response.data['is_finalize'],
        response.data['whatsapp_template'],
        response.data['seating_id'],
      );
      return event;
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

Future<List<Event>> fetchEvents() async {
  final dio = Dio();
  final List<Event> eventsList = [];
  final response = await dio.get(
    'https://api-dev.lorety.com/v2/events/',
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      for (var i = 0; i < response.data.length; i++) {
        if (response.data[i]['visibility_status'] == 1) {
          eventsList.add(Event(
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
      }
      eventsList.sort((a, b) {
        return DateTime.parse(a.date!).isAfter(DateTime.parse(b.date!)) ? 1 : 0;
      });
      return eventsList;
      //events_list содержит все события
    } catch (e) {
      print(e);
      return <Event>[];
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to GET ${response.statusCode}');
  }
}

Future<List<Event>> fetchMyEvents(String token) async {
  final dio = Dio();
  final List<Event> eventsList = [];
  final response = await dio.get(
    'https://api-dev.lorety.com/v2/profile/visited_events',
    data:{},
    options: Options(headers: {"Authorization": "Bearer $token"},)
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      for (var i = 0; i < response.data.length; i++) {
        if (response.data[i]['visibility_status'] == 1) {
          eventsList.add(Event(
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
      }
      eventsList.sort((a, b) {
        return DateTime.parse(a.date!).isAfter(DateTime.parse(b.date!)) ? 1 : 0;
      });
      return eventsList;
      //events_list содержит все события
    } catch (e) {
      print(e);
      return <Event>[];
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to GET ${response.statusCode}');
  }
}