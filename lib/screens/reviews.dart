import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';
import 'package:provider/provider.dart';
import 'service/idProvider.dart';

class Reviews extends StatefulWidget {
  final List<dynamic> comment;
  bool showTextBox;
  String postId;
  Reviews(
      {required this.comment, required this.showTextBox, required this.postId});
  @override
  State<Reviews> createState() => _Reviews();
}

class _Reviews extends State<Reviews> {
  void initState() {
    super.initState();
  }

  Future<String> getUsername(dynamic userRef) async {
    try {
      final DocumentReference _posts =
          FirebaseFirestore.instance.collection('users').doc(userRef);
      DocumentSnapshot snapshot = await _posts.get();
      return snapshot['username'];
    } catch (err) {
      print(err);
      return err.toString();
    }
  }

  addReview(dynamic comment) async {
    setState(() {
      widget.showTextBox = false;
      widget.comment.add(comment);
    });
    final DocumentReference _posts =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId);
    DocumentSnapshot snapshot = await _posts.get();
    List<dynamic> myList = snapshot['comment'];

    List<dynamic> updatedList = [...myList, comment];
    _posts.update({'comment': updatedList});
  }

  TextEditingController _textEditingController = TextEditingController();
  Widget build(BuildContext context) {
    final appState = Provider.of<IdProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Reviews",
            style: TextStyle(letterSpacing: 1),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  print(widget.showTextBox);
                  widget.showTextBox = true;
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.white70,
              ))
        ]),
        SizedBox(
          height: 50 * widget.comment.length.toDouble(),
          child: ListView.builder(
              itemCount: widget.comment.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: getUsername(widget.comment[index]['user']),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: ProfilePicture(
                                name: snapshot.data!,
                                radius: 23,
                                fontsize: 21,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(snapshot.data!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white70))),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Text(
                                        widget.comment[index]['text'],
                                        style: TextStyle(letterSpacing: 1),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              }),
        ),
        widget.showTextBox
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  autofocus: true,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.white70,
                    hintStyle: TextStyle(color: Colors.white70),
                    suffixIcon: IconButton(
                      onPressed: () => addReview({
                        "text": _textEditingController.text,
                        "user": appState.uid
                      }),
                      icon: Icon(
                        Icons.send,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ))
            : Container(),
      ],
    );
  }
}
