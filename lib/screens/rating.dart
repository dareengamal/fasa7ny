import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rating extends StatefulWidget {
  final String postId;
  Rating({this.postId: ""});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var userrating = 0.0;
  var tcVisibility = false;

  Future<void> addRatings(double rating) async {
    setState(() {
      userrating = rating;
      tcVisibility = true;
      print(tcVisibility);
    });

    DocumentReference documentRef =
        FirebaseFirestore.instance.collection("posts").doc(widget.postId);
    DocumentSnapshot snapshot = await documentRef.get();
    List<dynamic> myList = snapshot['rating'];

    List<dynamic> updatedList = [...myList, rating];
    documentRef.update({'rating': updatedList});
  }

  Widget build(BuildContext context) {
    return Column(children: [
      RatingBar.builder(
        initialRating: 0,
        minRating: 0,
        allowHalfRating: false,
        itemCount: 10,
        itemSize: 30,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) => addRatings(rating),
      ),
      SizedBox(
        height: 5,
      ),
      Visibility(
          visible: tcVisibility,
          child: SizedBox(
            height: 20,
            child: Expanded(
              child: Text(
                  "Thank you for your rating, you gave it a ${userrating.toInt()}/10"),
            ),
          ))
    ]);
  }
}
