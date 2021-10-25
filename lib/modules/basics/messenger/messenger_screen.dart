import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://github.com/MahmoudDiaa/MahmoudDiaa/blob/master/WhatsApp%20Image%202020-09-08%20at%2011.01.12%20AM.jpeg?raw=true'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: null,
              icon: CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.camera_alt,
                    size: 16.0,
                  ))),
          IconButton(
              onPressed: null,
              icon: CircleAvatar(
                  child: Icon(
                    Icons.edit,
                    size: 16.0,
                  )))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey[300]),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('Search'),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 120.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildStoryItem(),
                  itemCount: 5,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 20.0,),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index) =>buildChatItem(),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 20.0,),
                  itemCount: 15)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() =>
      Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://github.com/MahmoudDiaa/MahmoudDiaa/blob/master/WhatsApp%20Image%202020-09-08%20at%2011.01.12%20AM.jpeg?raw=true'),
              ),
              Padding(
                padding:
                const EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
                child: CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mahmoud Diaa",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                          'hello world my name is mahmoud',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                      ),
                    ),
                    Text(
                      "2:00 pm",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );

  Widget buildStoryItem() =>
      Row(
        children: [
          Container(
            width: 70.0,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'https://github.com/MahmoudDiaa/MahmoudDiaa/blob/master/WhatsApp%20Image%202020-09-08%20at%2011.01.12%20AM.jpeg?raw=true'),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  'Mahmoud Diaa',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );
}
