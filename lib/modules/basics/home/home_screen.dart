import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: Icon(
          Icons.menu,
          color: Colors.red,
        ),
        title: Text("Home"),
        centerTitle: true,
        elevation: 10.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Text("hello world"),
      ),
    );
  }
}
