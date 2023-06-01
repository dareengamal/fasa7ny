

import 'package:fasa7ny/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'favorite.dart';
import 'navigationbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile.dart';
import 'home_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteScreen> {
  User? userCred;
  var images = [];

  Future<dynamic> getImages(int index) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = await auth.currentUser;

      final DocumentReference _users =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);
      DocumentSnapshot snapshot = await _users.get();
      dynamic attributeValue = snapshot['favorites'];
      images = attributeValue.toSet().toList();
      final DocumentReference _posts = FirebaseFirestore.instance
          .collection('posts')
          .doc(attributeValue[index]);
      DocumentSnapshot snapshot2 = await _posts.get();

      return snapshot2['image'];
    } catch (err) {
      return "error";
    }
  }

  bool isDarkMode = false;
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    if (index == 3) {
      navigateToProfileScreen(context);
    } else if (index == 0) {
      navigateToFavouriteScreen(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void navigateToProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
  }

  void navigateToFavouriteScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Color hexStringToColor(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.red,
        isDarkMode: false,
      ),
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("E59400"),
                hexStringToColor("FFE5B4"),
                hexStringToColor("C37F00"),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: user != null && user.uid != null

              ? SafeArea(
                  child: Theme(
                    data: ThemeData.dark(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'FASA7NY',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.account_circle),
                                onPressed: () {
                                  // TODO: Implement profile icon functionality
                                },
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Favourite Destinations',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                if (getImages(index) != 'error' ||
                                    getImages(index) != Null) {
                                  return FutureBuilder(
                                    future: getImages(index),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          margin: const EdgeInsets.only(
                                            left: 5,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          width: 231,
                                          height: 364,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(snapshot.data),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
              child: AlertDialog(
                title: Text("You need to sign in !"),
                content: Text("Please sign in to view the content."),
                actions: [
TextButton(
        child: const Text(
          "click here to sign in !",
          style: TextStyle(color: Color.fromARGB(179, 10, 0, 0)),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen())),
      ),
                ],
              ),
            ),
    ),
  );
  }
}
