import 'package:flutter/material.dart';
import 'package:lorety_app/profile_and_settings.dart';
import 'API/get_user.dart';

//TODO написать функцию изменения параметров пользователя через API (сейчас только визуальные изменения)
class ProfileAndSettings extends StatefulWidget {
  ProfileAndSettings({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<ProfileAndSettings> createState() => _ProfileAndSettingsState();
}

class _ProfileAndSettingsState extends State<ProfileAndSettings> {
  late TextEditingController nameController;
  late TextEditingController secondNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cityController;
  @override
  initState(){
    nameController = TextEditingController(text: widget.user.name);
    secondNameController = TextEditingController(text: widget.user.second_name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
    cityController = TextEditingController(text: widget.user.city);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль и настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  _displayTextInputDialog(context, 'Имя', nameController);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Имя',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      nameController.text,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              InkWell(
                onTap: (){
                  _displayTextInputDialog(context, 'Имя', secondNameController);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Фамилия',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      secondNameController.text,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              InkWell(
                onTap: (){
                  _displayTextInputDialog(context, 'Имя', emailController);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EMail',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      emailController.text,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              InkWell(
                onTap: (){
                  _displayTextInputDialog(context, 'Имя', phoneController);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Телефон',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      phoneController.text,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              InkWell(
                onTap: (){
                  _displayTextInputDialog(context, 'Имя', cityController);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Название города',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      cityController.text,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _displayTextInputDialog(BuildContext context, String title, TextEditingController controller) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            cursorColor: Colors.black,
            controller: controller,
            decoration: const InputDecoration(

                // hintText: 'EMAIL',
                // hintStyle: ,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
                //Функция смены имени
              },
            ),
          ],
        );
      },
    );
  }
}
