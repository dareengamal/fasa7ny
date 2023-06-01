import 'package:fasa7ny/models/posts.dart';
import 'package:flutter/material.dart';
import 'rating.dart';
import 'reviews.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'descriptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'reviews.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:fasa7ny/screens/service/idProvider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color hexStringToColor(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  TextEditingController _textEditingController = TextEditingController();
  bool _showTextBox = false;
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (ModalRoute.of(context)!.settings.arguments is Map<String, Post>) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, Post>;
      final data = routeArgs['snapshot'];
      final appState = Provider.of<IdProvider>(context);
      return Scaffold(
        backgroundColor: hexStringToColor("E59400"),
        appBar: AppBar(
          backgroundColor: hexStringToColor("E59400"),
          bottomOpacity: 0.0,
          elevation: 0.0,
          scrolledUnderElevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              _showTextBox = false;
            });
          },
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Description(
                        title: data!.title,
                        urlImage: data.imageUrl,
                        description: data.description,
                      ),
                      appState.uid != ""
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Rating(postId: data.postID)],
                            )
                          : Container(),
                      SizedBox(
                        height: 7,
                      ),
                      appState.uid != ""
                          ? Reviews(
                              comment: data.comments,
                              showTextBox: _showTextBox,
                              postId: data.postID)
                          : Container()
                    ],
                  ))),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
