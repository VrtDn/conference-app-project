import 'package:conference_app/screens/login_screen.dart';
import 'package:conference_app/widgets/pages/chat/chat_view.dart';
import 'package:conference_app/widgets/pages/chat/empty_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/pages/events/events_view.dart';
import '../widgets/pages/people/people_view.dart';
import '../widgets/pages/profile/profile_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLogoutLoaded = false;
  int currentPageIndex = 0;
  Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.list_alt_outlined,
              color: Colors.blue,
            ),
            icon: Icon(Icons.list_alt_outlined),
            label: 'Events',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.people_outline,
              color: Colors.blue,
            ),
            icon: Icon(Icons.people_outline),
            label: 'People',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.chat_outlined,
              color: Colors.blue,
            ),
            icon: Icon(Icons.chat_outlined),
            label: 'Chat',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.blue,
            ),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          const EventsView(),
          PeopleView(
            callback: (Map<String, dynamic> data) {
              setState(() {
                currentPageIndex = 2;
                this.data = data;
              });
            },
          ),
          (data == null)
              ? const EmptyChatView()
              : ChatView(
                  data: data!,
                  returnToPeopleList: () {
                    print('in people list');
                    setState(() {
                      currentPageIndex = 1;
                    });
                  },
                ),
          const ProfileView()
        ],
      ),
    );
  }
}
