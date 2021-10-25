import 'package:flutter/material.dart';
import 'package:udemy_flutter/models/user/user_model.dart';


class UsersScreen extends StatelessWidget {
final  List<UserModel> users = [
    UserModel(id: 1, name: "Mahmoud Diaa", phone: '+010000142'),
    UserModel(id: 2, name: "Ahmed Diaa", phone: '+1252522'),
    UserModel(id: 3, name: "Hassan Diaa", phone: '+01234646465'),
    UserModel(id: 4, name: "Soliman Diaa", phone: '+01234646465'),
    UserModel(id: 5, name: "Mahmoud Diaa", phone: '+010000142'),
    UserModel(id: 6, name: "Ahmed Diaa", phone: '+1252522'),
    UserModel(id: 7, name: "Hassan Diaa", phone: '+01234646465'),
    UserModel(id: 8, name: "Soliman Diaa", phone: '+01234646465'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUsersItem(users[index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: users.length),
    );
  }

  Widget buildUsersItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                user.id.toString(),
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                 user.phone,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      );
}
