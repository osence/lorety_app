import 'package:flutter/material.dart';
import 'package:lorety_app/API/get_event.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:lorety_app/API/get_event_photos.dart';
import 'package:lorety_app/event_description.dart';
import 'package:share_plus/share_plus.dart';
import 'event_join.dart';

class EventBox extends StatelessWidget {
  const EventBox({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    Future<List<EventPhoto>> event_photos_list = fetchEventPhotos(event.id);
    String? schedule = '';
    var startDate = DateTime.parse('${event.date} ${event.start_time}');
    var endDate;
    if (event.finish_date != null && event.date != event.finish_date) {
      schedule =
          '$schedule${event.date.toString()} - ${event.finish_date.toString()}';
      endDate = DateTime.parse('${event.finish_date} ${event.finish_time}');
    } else {
      schedule = '$schedule${event.date.toString()}';
    }
    endDate = endDate ?? startDate;
    print(startDate);
    print(endDate);
    var curDate =
        DateTime.now(); //TODO видимо не тот часовой пояс на 2 часа ниже вроде
    print(curDate);
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
                    List<Image> slideshowChilds = event.cover == null
                        ? []
                        : [
                            Image.network(
                              getCoverUrl(event.cover),
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset('images/no-image.png');
                              },
                            )
                          ];
                    if (slideshowChilds == null) {
                      return Container(
                        child: Image.asset('images/no-image.png'),
                      );
                    }
                    snapshot.data!.removeWhere((element) =>
                        element.getPhotoUrl() == getCoverUrl(event.cover));
                    if (snapshot.data!.length == 0) {
                      return Container(
                        height: 300,
                        width: double.infinity,
                        child: slideshowChilds[0],
                      );
                    }
                    slideshowChilds.addAll(snapshot.data!
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
                                    return Image.asset('images/no-image.png');
                                  },
                                );
                              },
                            ))
                        .toList());

                    return ImageSlideshow(
                        width: double.infinity,
                        //double.infinity
                        height: 300,
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        autoPlayInterval: 0,
                        isLoop: false,
                        children: slideshowChilds);
                  }
                  // Otherwise, show something whilst waiting for initialization to complete
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }),

            Row(
              children: [
                Container(
                  width: 300,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => eventDescription(
                                  fullDescription: event.full_description!)));
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      foregroundColor: Colors.grey,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                        '${event.id} '
                        '${event.description!.trim().replaceAll(RegExp(r' \s+'), ' ')}',
                        softWrap: true),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Share.share('https://lorety.com/e/${event.event_url}');
                      //TODO social share functional
                    },
                    icon: const Icon(Icons.share)),
              ],
            ),
            // TextButton.icon(
            //   //TODO Убрать отладку по id события
            //   label: Text('${event.id} '
            //       '${event.description}'),
            //   style: TextButton.styleFrom(
            //       textStyle: TextStyle(fontWeight: FontWeight.bold),
            //       foregroundColor: Colors.grey,
            //       alignment: Alignment.centerLeft),
            //   icon: const Icon(Icons.info),
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => eventDescription(
            //                 fullDescription: event.full_description)));
            //   },
            // ),
            Text(
              schedule,
              textAlign: TextAlign.left,
              style: TextStyle(color: Color(0xff747474)),
            ),
            //TODO Добавить геолокацию
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: event.place,
                style: TextStyle(color: Color(0xff969696), fontSize: 12),
              ),
            ),
            if (startDate.isAfter(curDate))
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      //TODO покупка билета
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => eventJoin(
                                      id: event.event_url!,
                                    )));
                      },
                      child: Text('Присоединиться'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff26ba9a),
                      ),
                    )),
              ),
            if (startDate.isBefore(curDate) && endDate.isAfter(curDate))
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        'Уже началось',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
