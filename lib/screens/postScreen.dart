
import 'package:fasa7ny/screens/service/idProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navigationbar.dart';
import 'profile.dart';
import 'favorite.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController name = new TextEditingController();

  TextEditingController description = new TextEditingController();

  // TextEditingController category
  //    TextEditingController descriptiom

  List<String> categories = [
    'activities',
    'religious',
    'historical',
    'beaches',
    'cafes',
    'museums',
    'art galleries'
  ];

  XFile? image;
  String dropdownValue = 'activities';

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }
  // imagex=client.read(Uri.parse(image?.path));

//   Future uploadImageToFirebase() async {

//    String fileName = basename(image!.path);

//    FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;

//    Reference ref =firebaseStorageRef.ref().child('upload/$fileName'+ DateTime.now().toString());

// // FirebaseStorage.instance.ref().child('uploads/$fileName');
//    UploadTask uploadTask = ref.putFile(image);

//    uploadTask.then((res) {res.ref.getDownloadURL().then((value) => imgValue = value);});
// }

// void getDropDownItem(){

//     setState(() {
//       holder = dropdownValue ;
//     });
//   }

  Color hexStringToColor(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: hexStringToColor("E59400"), // Background color

            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 250, 174, 120), // Background color
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text(' Gallery'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text(' Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  int _currentIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<IdProvider>(context);
    
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.red,
        isDarkMode: false,
      ),
      backgroundColor: hexStringToColor("E59400"),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 182, 177, 173)
                                .withOpacity(0.7), //background color of button
                        side: const BorderSide(
                          width: 3,
                          color: Color.fromARGB(255, 180, 109, 58),
                        ), //border width and color
                        elevation: 10, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(
                            20) //content padding inside button
                        ),
                    onPressed: () {
                      myAlert();
                    },
                    child: Text('+',
                        style: TextStyle(
                            fontSize: 70,
                            color: Colors.white.withOpacity(0.6))),
                  )),
              const SizedBox(
                height: 10,
              ),
              //if image not null show the image
              //if image null show text
              image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : TextField(
                      //              keyboardType: TextInputType.
                      //  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly]
                      controller: name,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "name",
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                            allow: true)
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: description,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "description",
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                ),
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(12),
                  dropdownColor: Color.fromARGB(253, 227, 191, 141),

                  // Step 3.
                  value: dropdownValue,
                  // Step 4.
                  items: <String>[
                    'activities',
                    'religious',
                    'historical',
                    'beaches',
                    'cafes',
                    'museums',
                    'art galleries'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('ElevatedButton Clicked');
                    Map<String, dynamic> data = {
                      "name": name.text,
                      "description": description.text,
                      "category": dropdownValue,
                      "image": "http://" + image!.path,
                      "rating": [0],
                      "coment": [],
                      'user': profileProvider.uid
                      // "rating" : int(),
                    };
                    FirebaseFirestore.instance.collection('posts').add(data);
                  },
                  child: Text('upload'),
                  style: ElevatedButton.styleFrom(
                    // primary: Color.fromARGB(255, 180, 109, 58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
