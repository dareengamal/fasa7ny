

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fasa7ny/screens/reset_password.dart';
// import 'package:fasa7ny/screens/service/idProvider.dart';
// import 'package:fasa7ny/screens/signup_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fasa7ny/reusable_widgets/reusable_widget.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../utils/colors_utils.dart';

// import 'package:fasa7ny/utils/colors_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'home_Screen.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<IdProvider>(context);
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           hexStringToColor("E59400"),
//           hexStringToColor("C37F00"),
//           hexStringToColor("FFE5B4")
//         ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//                 20, MediaQuery.of(context).size.height * 0.2, 20, 0),
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   '',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 40,
//                   ),
//                 ),
//                 logoWidget("assets/icons8-tourism-50.png"),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 reusableTextField(
//                     "Enter Email", Icons.email, false, _emailTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField("Enter Password", Icons.lock_outline, true,
//                     _passwordTextController),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 forgetPassword(context),
//                 firebaseUIButton(context, "Sign In", () {
//                   FirebaseAuth.instance
//                       .signInWithEmailAndPassword(
//                           email: _emailTextController.text,
//                           password: _passwordTextController.text)
//                       .then((value) {
//                     appState.sharedValue = value.user!.uid;
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 HomeScreen(uid: value.user!.uid)));
//                   }).onError((error, stackTrace) {
//                     if (error.toString().contains("no user record")) {
//                       final snackBar = SnackBar(
//                         content: Text("EMAIL NOT FOUND"),
//                         backgroundColor: Colors.amber,
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     } else if (error.toString().contains("wrong password")) {
//                       final snackBar = SnackBar(
//                         content: Text("WRONG PASSWORD"),
//                         backgroundColor: Colors.amber,
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     } else if (error.toString().contains("attmept")) {
//                       final snackBar = SnackBar(
//                         content: Text(
//                             "YOU HAVE EXCEEDED NUMBER OF ATTEMPTS TRY AGAIN LATER"),
//                         backgroundColor: Colors.amber,
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     } else {
//                       final snackBar = SnackBar(
//                         content: Text("PLEASE CHECK YOUR INTERNET CONNECTION!"),
//                         backgroundColor: Colors.amber,
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     }
//                   });
//                 }),
//                 signUpOption()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row signUpOption() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Don't have account?",
//             style: TextStyle(color: Colors.white70)),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SignUpScreen()));
//           },
//           child: const Text(
//             " Sign Up",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         )
//       ],
//     );
//   }

//   Widget forgetPassword(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 35,
//       alignment: Alignment.bottomRight,
//       child: TextButton(
//         child: const Text(
//           "Forgot Password?",
//           style: TextStyle(color: Colors.white70),
//           textAlign: TextAlign.right,
//         ),
//         onPressed: () => Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ResetPassword())),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasa7ny/screens/reset_password.dart';
import 'package:fasa7ny/screens/service/idProvider.dart';
import 'package:fasa7ny/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fasa7ny/reusable_widgets/reusable_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/colors_utils.dart';
import 'home_Screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<IdProvider>(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("E59400"),
              hexStringToColor("C37F00"),
              hexStringToColor("FFE5B4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'fasa7ni',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                // SizedBox(height: 10),
                // Text(
                //   'Your Egyptian Tour Guide',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // ),
                SizedBox(height: 30),
                logoWidget("assets/icons8-tourism-50.png"),
                SizedBox(height: 30),
                reusableTextField(
                  "Enter Email",
                  Icons.email,
                  false,
                  _emailTextController,
                ),
                SizedBox(height: 20),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                SizedBox(height: 5),
                forgetPassword(context),
                firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      )
                      .then((value) {
                    appState.sharedValue = value.user!.uid;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(uid: value.user!.uid),
                      ),
                    );
                  }).onError((error, stackTrace) {
                    if (error.toString().contains("no user record")) {
                      final snackBar = SnackBar(
                        content: Text("EMAIL NOT FOUND"),
                        backgroundColor: Colors.amber,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (error.toString().contains("wrong password")) {
                      final snackBar = SnackBar(
                        content: Text("WRONG PASSWORD"),
                        backgroundColor: Colors.amber,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (error.toString().contains("attmept")) {
                      final snackBar = SnackBar(
                        content: Text(
                          "YOU HAVE EXCEEDED NUMBER OF ATTEMPTS TRY AGAIN LATER",
                        ),
                        backgroundColor: Colors.amber,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: Text("PLEASE CHECK YOUR INTERNET CONNECTION!"),
                        backgroundColor: Colors.amber,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                }),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPassword()),
        ),
      ),
    );
  }
}
