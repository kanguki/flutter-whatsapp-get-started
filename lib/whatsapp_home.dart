import 'package:flutter/material.dart';
import 'package:whatsapp/screens/apis.dart';
import 'package:whatsapp/screens/calls.dart';
import 'package:whatsapp/screens/camera.dart';
import 'package:whatsapp/screens/chats.dart';
import 'package:whatsapp/screens/status.dart';

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({Key? key}) : super(key: key);

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
      List<Widget> tabs = const <Widget>[
            Tab(
              text: "API",
            ),
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ];
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 132, 109),
        title: const Text("WhatsApp"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: tabs,
        ),
        actions: const <Widget>[
          Icon(Icons.search),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
          Icon(Icons.more_vert),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          ApisScreen(),
          CameraScreen(),
          ChatsScreen(),
          StatusScreen(),
          CallsScreen()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.message,color: Colors.white,),
        onPressed: () => print("open chats"),
      ),
    );
  }
}
