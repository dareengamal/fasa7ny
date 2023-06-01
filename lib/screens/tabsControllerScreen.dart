// import 'package:flutter/material.dart';

// import 'favorite.dart';
// import 'home_screen.dart';


// class TabsControllerScreen extends StatefulWidget {
//   @override
//   _TabsControllerScreenState createState() => _TabsControllerScreenState();
// }

// class _TabsControllerScreenState extends State<TabsControllerScreen> {
//   final List<Widget> myPages = [HomeScreen(),FavoriteScreen()];
//   var selectedTabIndex = 0;
//   void switchPage(int index) {
//     setState(() {
//       selectedTabIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: myPages[selectedTabIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Color.fromARGB(255, 207, 130, 75),
//           elevation: 0.0,
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
//             BottomNavigationBarItem(icon: Icon(Icons.add), label: "post"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite), label: "favorites")
//           ],
//           currentIndex: selectedTabIndex,
//           onTap: switchPage,
//         ));
//   }
// }

import 'package:flutter/material.dart';

import 'favorite.dart';

// import 'favorite.dart';
import 'home_Screen.dart';

class TabsControllerScreen extends StatefulWidget {
  @override
  _TabsControllerScreenState createState() => _TabsControllerScreenState();
}

class _TabsControllerScreenState extends State<TabsControllerScreen> {
  final List<Widget> myPages = [HomeScreen(), FavoriteScreen()];
  var selectedTabIndex = 0;

  void switchPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPages[selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 207, 130, 75),
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: selectedTabIndex,
        onTap: switchPage,
      ),
    );
  }
}
