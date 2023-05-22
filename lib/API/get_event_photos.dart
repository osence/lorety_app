import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

class EventPhoto {
  final int id;
  final String updated_at;
  final String original_name;
  final String name;
  final int archived;
  final int event_id;
  final String created_at;
  final String? mimetype;
  final int? order;

  String getPhotoUrl() {
    return 'https://api-dev.lorety.com/v2/event/cover/${name.split('.')[0]}';
  }

  String getOldPhotoUrl() {
    return 'https://old.lorety.com/uploads/event_photos/$event_id/orig/$name';
  }

  EventPhoto(this.id, this.updated_at, this.original_name, this.name,
      this.archived, this.event_id, this.created_at, this.mimetype, this.order);
}

String getCoverUrl(cover){
  return 'https://api-dev.lorety.com/v2/event/cover/$cover';
}

Future<List<EventPhoto>> fetchEventPhotos(event_id) async {
  final dio = Dio();
  final List<EventPhoto> event_photos_list = [];

  final response = await dio.get(
    'https://api-dev.lorety.com/v2/event/photos/$event_id',
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      for (var i = 0; i < response.data.length; i++) {
        event_photos_list.add(EventPhoto(
          response.data[i]['id'],
          response.data[i]['updated_at'],
          response.data[i]['original_name'],
          response.data[i]['name'],
          response.data[i]['archived'],
          response.data[i]['event_id'],
          response.data[i]['created_at'],
          response.data[i]['mimetype'],
          response.data[i]['order'],
        ));
      }
      return event_photos_list;
      //events_list содержит все события
    } catch (e) {
      print(e);
      return <EventPhoto>[];
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load GET ${response.statusCode}');
  }
}
