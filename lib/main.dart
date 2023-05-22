import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lorety_app/events.dart';
import 'package:lorety_app/login.dart';
import 'package:lorety_app/messages.dart';
import 'package:lorety_app/my_events.dart';
import 'package:lorety_app/profile.dart';

import 'API/post_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'События',
      //TODO Вынести константы цвета в файл с темами
      theme: ThemeData(
          primarySwatch: generateMaterialColor(Colors.white),
          scaffoldBackgroundColor: const Color(0xffeae9ef)),
      home:
          const LoginPage(), /*MyHomePage(
        title: 'События',
         token: AuthToken(
            access_token:
                'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ODY2IiwiaXNfYWRtaW4iOjAsImV4cCI6MTY4NDU3OTEzMSwidHlwZSI6ImFjY2VzcyJ9.OBe8qrg2-jLfCtqxIvfygk0G2cVBghY2WdTifPdP8LfZlLgEhAqsNFtM9yuvqtMRWcsgxHltemVvb30B5OgTZg',
            refresh_token: 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ODY2IiwiaXNfYWRtaW4iOjAsImV4cCI6MTY4NTA5NzUzMSwidHlwZSI6InJlZnJlc2gifQ.qxxxJuy6dP3sIPdyfjS8vqT2PNOXmC6zItVhPhMMgjrc_XUs7rMYAOWQV12tRwxCD_I01eesaAjcPcTPm9Zzcg',
            token_type: 'Bearer',
            expire_timestamp: 1684579131),
      ),*/ //const LoginPage(),MyHomePage(title: 'События'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.token});

  final String token;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    int? filterType = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: selectedIndex == 1
            ? Text('Чаты')
            : selectedIndex == 2
                ? Text('Мои события')
                : selectedIndex == 3
                    ? Text('Профиль')
                    : Text(widget.title),
        actions: selectedIndex == 0
            ? [
                IconButton(
                  tooltip: "Фильтры",
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                  ),
                  //TODO Фильтрация
                  onPressed: () {
                    var categories = ['Все', 'Для детей', 'Другие'];
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        int? selectedRadio = 0;
                        return AlertDialog(
                          title: const Text('Выбрать категорию событий'),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List<Widget>.generate(3, (int index) {
                                  return RadioListTile<int>(
                                    title: Text(categories[index]),
                                    activeColor: Colors.green,
                                    value: index,
                                    groupValue: selectedRadio,
                                    onChanged: (int? value) {
                                      setState(() => selectedRadio = value);
                                    },
                                  );
                                }),
                              );
                            },
                          ),
                          actions: [
                            TextButton(onPressed: () {}, child: Text('Отмена')),
                            TextButton(
                                onPressed: () {
                                  setState(() => filterType = selectedRadio);
                                },
                                child: Text('Выбрать')),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  tooltip: "Уведомления",
                  icon: const Icon(
                    Icons.notifications_outlined,
                  ),
                  //TODO Уведомления
                  onPressed: () {},
                ),
              ]
            : null,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          EventsPage(),
          MessagesPage(),
          MyEventsPage(token: widget.token),
          ProfilePage(token: widget.token),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(
          size: 37,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            pageController.jumpToPage(selectedIndex);
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
