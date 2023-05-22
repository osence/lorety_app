import 'package:flutter/material.dart';
import 'package:lorety_app/profile_and_settings.dart';

import 'API/get_user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    print(token);
    return FutureBuilder(
        future: fetchUser(token),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            //TODO Error screen

            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            User? user = snapshot.data;
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      print('tap');
                      Navigator.push(
                          context,
                      MaterialPageRoute(
                          builder: (context) => ProfileAndSettings(
                                user: user!,
                              )));
                      //Открыть профиль
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user?.name} ${user?.second_name}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '${user?.email}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      //Открыть компетенции
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Компетенции',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      //Открыть компетенции
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Потребности',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      //Открыть компетенции
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Учетная запись',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}
