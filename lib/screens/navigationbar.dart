
// // import 'package:fasa7ny/screens/favorite.dart';
// // import 'package:fasa7ny/screens/profile.dart';
// // import 'package:flutter/material.dart';

// // class BottomNavBar extends StatefulWidget {
// // final int currentIndex;
// // final Function(int) onTap;
// // final Color backgroundColor;

// // const BottomNavBar({
// // required this.currentIndex,
// // required this.onTap,
// // required this.backgroundColor, required bool isDarkMode,
// // });

// // @override
// // _BottomNavBarState createState() => _BottomNavBarState();
// // }

// // class _BottomNavBarState extends State<BottomNavBar> {
// // void navigateToProfileScreen(BuildContext context) {
// // Navigator.push(
// // context,
// // MaterialPageRoute(builder: (context) => Profile()),
// // );
// // }

// // void navigateToFavouriteScreen(BuildContext context) {
// // Navigator.push(
// // context,
// // MaterialPageRoute(builder: (context) => FavoriteScreen(favoritePosts: [],)),
// // );
// // }

// // @override
// // Widget build(BuildContext context) {
// // return BottomNavigationBar(
// // currentIndex: widget.currentIndex,
// // onTap: (index) {
// // if (index == 3) {
// // navigateToProfileScreen(context);
// // } else if (index == 1) {
// // navigateToFavouriteScreen(context);
// // } else {
// // widget.onTap(index);
// // }
// // },
// // backgroundColor: widget.backgroundColor,
// // items: const [
// // BottomNavigationBarItem(
// // icon: Icon(Icons.home),
// // label: 'Home',
// // ),
// // BottomNavigationBarItem(
// // icon: Icon(Icons.favorite_border),
// // label: 'Favourite',
// // ),
// // BottomNavigationBarItem(
// // icon: Icon(Icons.notifications),
// // label: 'Notifications',
// // ),
// // BottomNavigationBarItem(
// // icon: Icon(Icons.person),
// // label: 'Profile',
// // ),
// // ],
// // );
// // }
// // }
// // import 'package:fasa7ny/screens/favorite.dart';
// // import 'package:fasa7ny/screens/profile.dart';
// // import 'package:flutter/material.dart';

// // class BottomNavBar extends StatefulWidget {
// // final int currentIndex;
// // final Function(int) onTap;
// // final Color backgroundColor;

// // const BottomNavBar({
// // required this.currentIndex,
// // required this.onTap,
// // required this.backgroundColor,
// // });

// // @override
// // _BottomNavBarState createState() => _BottomNavBarState();
// // }

// // class _BottomNavBarState extends State<BottomNavBar> {
// // void navigateToProfileScreen(BuildContext context) {
// // Navigator.push(
// // context,
// // MaterialPageRoute(builder: (context) => Profile()),
// // );
// // }

// // void navigateToFavouriteScreen(BuildContext context) {
// // Navigator.push(
// // context,
// // MaterialPageRoute(builder: (context) => FavoriteScreen()),
// // );
// // }

// // @override
// // Widget build(BuildContext context) {
// // return BottomNavigationBar(
// // currentIndex: widget.currentIndex,
// // onTap: (index) {
// // if (index == 3) {
// // navigateToProfileScreen(context);
// // } else if (index == 1) {
// // navigateToFavouriteScreen(context);
// // } else {
// // widget.onTap(index);
// // }
// // },
// // backgroundColor: widget.backgroundColor,
// // items: const [
// // BottomNavigationBarItem(
// // icon: Icon(Icons.home),
// // label: 'Home',
// // ),
// // BottomNavigationBarItem(
// // icon: Icon(Icons.favorite_border),
// // label: 'Favourite',
// // ),
// // BottomNavigationBarItem(
// // icon: Icon(Icons.notifications),
// // label: 'Notifications',
// // ),
// // BottomNavigationBarItem(
// // icon: Icon(Icons.person),
// // label: 'Profile',
// // ),
// // ],
// // );
// // }
// // }

// import 'package:fasa7ny/screens/favorite.dart';
// import 'package:fasa7ny/screens/profile.dart';
// import 'package:flutter/material.dart';

// class BottomNavBar extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//   final Color backgroundColor;
//   final bool isDarkMode;

//   const BottomNavBar({
//     required this.currentIndex,
//     required this.onTap,
//     required this.backgroundColor,
//     required this.isDarkMode,
//   });

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   void navigateToProfileScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => Profile()),
//     );
//   }

//   void navigateToFavouriteScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => FavoriteScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: widget.currentIndex,
//       onTap: (index) {
//         if (index == 3) {
//           navigateToProfileScreen(context);
//         } else if (index == 1) {
//           navigateToFavouriteScreen(context);
//         } else {
//           widget.onTap(index);
//         }
//       },
//       backgroundColor: widget.isDarkMode ? Colors.grey[900] : widget.backgroundColor,
//       selectedItemColor: widget.isDarkMode ? Colors.white : Colors.black,
//       unselectedItemColor: widget.isDarkMode ? Colors.grey : Colors.grey[600],
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite_border),
//           label: 'Favourite',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.notifications),
//           label: 'Notifications',
//         ),
//          BottomNavigationBarItem(
//           icon: Icon(Icons.post_add),
//           label: 'add post',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
// // =============
import 'package:fasa7ny/screens/favorite.dart';
import 'package:fasa7ny/screens/profile.dart';
import 'package:fasa7ny/screens/postScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import the PostScreen

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final bool isDarkMode;

  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.backgroundColor,
    required this.isDarkMode,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void navigateToProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
  }

  void navigateToFavouriteScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoriteScreen()),
    );
  }

  void navigateToAddPostScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        if (index == 3) {
          navigateToProfileScreen(context);
        } else if (index == 1) {
          navigateToFavouriteScreen(context);
        } else if (index == 2) {
          navigateToAddPostScreen(context);
        } else {
          widget.onTap(index);
        }
      },
      backgroundColor: widget.isDarkMode ? Colors.grey[900] : widget.backgroundColor,
      selectedItemColor: widget.isDarkMode ? Colors.white : Colors.black,
      unselectedItemColor: widget.isDarkMode ? Colors.grey : Colors.grey[600],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favourite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.post_add),
          label: 'Add Post',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
