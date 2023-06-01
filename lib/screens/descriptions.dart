import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String title;
  final String urlImage;
  final String description;

  Description(
      {required this.title, required this.urlImage, this.description: ""});

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(urlImage), fit: BoxFit.cover)))),
        SizedBox(
          height: 10,
        ),
        Text(title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 7,
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Divider(
          color: Colors.white70, // Customize the color of the line
          height: 50, // Adjust the height of the line
          thickness: 2, // Specify the thickness of the line
          indent: 20, // Set the indent (space) before the line starts
          endIndent: 20, // Set the indent (space) after the line ends
        ),
      ],
    );
  }
}