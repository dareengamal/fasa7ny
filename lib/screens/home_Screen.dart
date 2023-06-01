import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

import '../models/posts.dart';
import 'favorite.dart';
import 'navigationbar.dart';
import 'profile.dart';
import 'package:fasa7ny/utils/colors_utils.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({Key? key, this.uid: ""}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> isFavoriteList = [];

  List<String> strs = [
    "activities",
    "religious",
    "historical",
    "beaches",
    "cafes",
    'museums',
    'art galleries'
  ];
  List<String> _inactiveChips = [];
  List<String> _activeChips = [];

  bool isDarkMode = false;
  int _currentIndex = 0;
  List<String> favoritePosts = [];

  void _onTabTapped(int index) {
    if (index == 3) {
      navigateToProfileScreen(context);
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
      MaterialPageRoute(builder: (context) => FavoriteScreen()),
    );
  }

  navigateToPage(
      BuildContext myContext, DocumentSnapshot<Object?> documentSnapshot) {
    Navigator.of(myContext).pushNamed('/postPage', arguments: {
      'snapshot': Post(
          imageUrl: documentSnapshot['image'],
          postID: documentSnapshot.reference.id,
          title: documentSnapshot['name'],
          description: documentSnapshot['description'],
          comments: documentSnapshot['comment']),
    });
  }

  //user restricted action
  late String userId;

  void initializeUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  final CollectionReference _posts =
      FirebaseFirestore.instance.collection('posts');
  addToFavorite(String postId, int index) async {
    print(widget.uid);
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection("users").doc(widget.uid);
    DocumentSnapshot snapshot = await documentRef.get();
    List<dynamic> myList = snapshot['favorites'];
    List<dynamic> updatedList = [...myList, postId];
    documentRef.update({'favorites': updatedList});
    setState(() {
      isFavoriteList[index] = !isFavoriteList[index];
    });
    print('Heart button clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // final List<DocumentSnapshot> postDocs = snapshot.data!.docs;

      // final List<Map<String, dynamic>> posts = postDocs.map((doc) {
      //   final data = doc.data() as Map<String, dynamic>;
      //   return {
      //     'id': data['id'],
      //     'title': data['title'],
      //     'imageURL': data['imageURL'],
      //     'ratings' : data['ratings']
      //   };
      // }).toList();
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.red,
        isDarkMode: false,
      ),
      backgroundColor: isDarkMode ? Colors.black : hexStringToColor("E59400"),
      resizeToAvoidBottomInset: false,
      body: Theme(
        data: ThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        child: StreamBuilder<QuerySnapshot>(
          //nash
          stream: _posts.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final QuerySnapshot documentSnapshot = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          IconButton(
                            icon: Icon(
                              isDarkMode
                                  ? Icons.brightness_7
                                  : Icons.brightness_4,
                            ),
                            onPressed: () {
                              setState(() {
                                isDarkMode = !isDarkMode;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(left: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: strs
                                .map((category) => FilterChip(
                                    selected: _activeChips.contains(category),
                                    label: Text(category),
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          _activeChips.add(category);
                                        } else {
                                          _activeChips.remove(category);
                                        }
                                      });
                                    }))
                                .toList()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Destinations',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 300,
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(left: 20),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          num avgRating = 0;
                          for (num i = 0;
                              i < documentSnapshot['rating'].length;
                              i++) {
                            avgRating += documentSnapshot['rating'][i];
                          }
                          if (isFavoriteList.length <= index) {
                            isFavoriteList.add(false);
                          }

                          return GestureDetector(
                            onTap: () =>
                                navigateToPage(context, documentSnapshot),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin:
                                      const EdgeInsets.only(right: 50, top: 10),
                                  width: 231,
                                  height: 364,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        documentSnapshot['image'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () => addToFavorite(
                                                documentSnapshot.id, index),
                                            child: Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Icon(
                                                  isFavoriteList[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: isFavoriteList[index]
                                                      ? Colors.redAccent
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (avgRating /
                                                          documentSnapshot[
                                                                  'rating']
                                                              .length)
                                                      .toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 1),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                            child: Text(
                                              documentSnapshot['name'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100),

                    //NASH
                    Container(
                      height: 700,
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(left: 20),
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            num avgRating = 0;
                            for (num i = 0;
                                i < documentSnapshot['rating'].length;
                                i++) {
                              avgRating += documentSnapshot['rating'][i];
                            }
                            if (isFavoriteList.length <= index) {
                              isFavoriteList.add(false);
                            }

                            if (_activeChips.isEmpty) {
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    margin: const EdgeInsets.only(
                                        right: 50, top: 10),
                                    width: 364,
                                    height: 364,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              documentSnapshot['image']),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: const Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Icon(
                                                        Icons.favorite_border,
                                                        color:
                                                            Colors.redAccent)),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            (avgRating /
                                                                    documentSnapshot[
                                                                            'rating']
                                                                        .length)
                                                                .toStringAsFixed(
                                                                    1),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        SizedBox(width: 1),
                                                        Icon(Icons.star,
                                                            color:
                                                                Colors.yellow)
                                                      ])),
                                            ]),
                                        Expanded(
                                          child: Align(
                                              alignment:
                                                  FractionalOffset.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 50.0),
                                                child: Text(
                                                    documentSnapshot[
                                                        'description'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Icon(Icons.favorite_border, color: Colors.redAccent),
                                ],
                              );
                              //other condition
                            } else {
                              print(documentSnapshot[index]);
                              if (index < snapshot.data!.docs.length &&
                                  _activeChips
                                      .contains(documentSnapshot['category'])) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: const EdgeInsets.only(
                                          right: 50, top: 10),
                                      width: 364,
                                      height: 364,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                documentSnapshot['image']),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }

                              // });
                            }
                          }),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
