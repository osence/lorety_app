import 'package:flutter/material.dart';
import 'package:lorety_app/API/get_event.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:lorety_app/API/get_event_photos.dart';

class EventBox extends StatelessWidget {
  const EventBox({Key? key, this.event_url}) : super(key: key);
  final int? event_url;

  @override
  Widget build(BuildContext context) {
    Future<List<EventPhoto>?> event_photos_list = fetchEventPhotos(event_url);
    List<String> images = [];
    List<String> images2 = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    return Container(
        child: Column(
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
                print('???__________________1');
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                for (var i =0; i<snapshot.data!.length;i++)
                {
                  images.add(snapshot.data![i].getPhotoUrl());
                }
                print(images);
                return ImageSlideshow(
                  width: double.infinity,
                  height: 200,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,
                  children: images.map((item) => Image.network(item, fit: BoxFit.cover))
                      .toList(),
                  autoPlayInterval: 0,
                  isLoop: true,
                );
              }
              // Otherwise, show something whilst waiting for initialization to complete
              return Container(
              child: Center(
              child: CircularProgressIndicator(color: Colors.black,),
              )
              ,
              );
            }
        )
    ]
    ,
    )
    ,
    );
  }
}

class EventsPage extends StatelessWidget {
  EventsPage({Key? key}) : super(key: key);
  Future<List<Event>?>? _events_list = fetchEvents();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _events_list,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  children: [
                    EventBox(event_url: snapshot.data?[0].id),
                    EventBox(event_url: snapshot.data?[5].id),
                  ],
                ),
              ),
            );
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return Container(
            child: Center(
              child: CircularProgressIndicator(color: Colors.black,),
            ),
          );
        }
      // }, return Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   child: Container(
      //       child: Column(
      //         children: [
      //           EventBox(event_url: _events_list![0].event_url),
      //           EventBox(),
      //         ],
      //       )),
      // ),
    );
  }
}
