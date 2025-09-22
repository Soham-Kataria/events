import 'package:event_tracker/screens/Favourites/favourite.dart';
import 'package:event_tracker/screens/Profile/profile.dart';
import 'package:event_tracker/screens/events/event_list.dart';
import 'package:event_tracker/screens/home/home.dart';
import 'package:event_tracker/screens/tickets/tickets.dart';
import 'package:event_tracker/theme/colors.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var _currentIndex = 0;

  List<Widget> get _screens => [
    HomeScreen(),
    EventListScreen(),
    FavouriteScreen(),
    TicketScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var _ = theme.textTheme;
    var _ = theme.colorScheme;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Main Screen'),
      //   backgroundColor: colorScheme.surface,
      //   foregroundColor: colorScheme.onSurface,
      //   elevation: 0,
      // ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(()=> _currentIndex=index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kGrayColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_outlined),
              label: 'Events',
              activeIcon: Icon(Icons.event)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favourite',
              activeIcon: Icon(Icons.favorite)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_outlined),
              label: 'Ticket',
              activeIcon: Icon(Icons.airplane_ticket)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
              activeIcon: Icon(Icons.person)
          ),
        ],
      ),
    );
  }
}
