import 'package:flutter/material.dart';
import 'package:whatsapp/models/chats.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dumbData.length,
      itemBuilder: (context, i) => Column(
        children: <Widget>[
          const Divider(
            height: 10.0,
          ),
          ListTile(
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(dumbData[i].avatarUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  dumbData[i].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  dumbData[i].time,
                  style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                )
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: 
                Text(
                  dumbData[i].message,
                  style: const TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
            ),
          )
        ],
      ),
    );
  }
}
