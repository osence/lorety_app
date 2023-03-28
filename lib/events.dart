import 'package:flutter/material.dart';
import 'package:lorety_app/API/get_event.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:lorety_app/API/get_event_photos.dart';
import 'package:lorety_app/event_description.dart';

class EventBox extends StatelessWidget {
  const EventBox({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    Future<List<EventPhoto>> event_photos_list = fetchEventPhotos(event.id);
    List<String> images = [];
    String? schedule = '';
    if (event.finish_date != null && event.date != event.finish_date) {
      schedule =
          '$schedule${event.date.toString()} - ${event.finish_date.toString()}';
    } else {
      schedule = '$schedule${event.date.toString()}';
    }

    schedule =
        '$schedule с ${event.start_time.toString()} до ${event.finish_time.toString()}';
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      //TODO Вместо контейнера картинки
                    },
                    icon: Icon(Icons.share)),
              ],
            ),
            FutureBuilder(
                future: event_photos_list,
                builder: (context, snapshot) {
                  // Check for errors
                  if (snapshot.hasError) {
                    //TODO Error screen
                    return Container(
                      color: Colors.green,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.length == 0) {
                      return Container(
                        child: Image.asset('images/no-image.png'),
                      );
                    }
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      images.add(snapshot.data![i].getPhotoUrl());
                    }
                    print(images);
                    return ImageSlideshow(
                      width: double.infinity,
                      height: 200,
                      initialPage: 0,
                      indicatorColor: Colors.blue,
                      indicatorBackgroundColor: Colors.grey,
                      autoPlayInterval: 0,
                      isLoop: false,
                      children: snapshot.data!
                          .map((item) => Image.network(
                                item.getPhotoUrl(),
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.network(
                                    item.getOldPhotoUrl(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      if(event.id == 1777){
                                        print(item.getPhotoUrl());
                                        print(item.getOldPhotoUrl());
                                      }
                                      return Image.asset('images/no-image.png');
                                    },
                                  );
                                },
                              ))
                          .toList(),
                    );
                  }
                  // Otherwise, show something whilst waiting for initialization to complete
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
            TextButton.icon(
              //TODO Убрать отладку по id события
              label: Text('${event!.id} '
                  '${event!.description}'),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  alignment: Alignment.centerLeft),
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => eventDescription(
                            fullDescription: event!.full_description)));
              },
            ),
            Text(
              schedule,
              textAlign: TextAlign.left,
              style: TextStyle(color: Color(0xff747474)),
            ),
            //TODO Добавить геолокацию
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: event!.place,
                style: TextStyle(color: Color(0xff969696), fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  EventsPage({Key? key}) : super(key: key);
  Future<List<Event>> _events_list = fetchEvents();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _events_list,
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
