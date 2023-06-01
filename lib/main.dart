// import 'package:fasa7ny/screens/homePage.dart';
// import 'package:fasa7ny/screens/home_Screen.dart';
// import 'package:fasa7ny/screens/profile.dart';
// import 'package:fasa7ny/screens/profile_provider.dart';
// import 'package:fasa7ny/screens/signin_screen.dart';
// import 'package:fasa7ny/screens/signup_screen.dart';
// import 'package:fasa7ny/screens/tabsControllerScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: FirebaseOptions(
//     apiKey: "AIzaSyDzMJpT91MCLQRB3SCKxsnDc4ICmM4B6c0", // Your apiKey
//     appId: "1:597602118740:android:93b76ed3463a0c8d0451c1", // Your appId
//     messagingSenderId: "597602118740", // Your messagingSenderId
//     projectId: "fasahni-67d0d",
//   ));
//   //
//     runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ProfileProvider(),
//       child: MaterialApp(
//         title: 'Fasa7ny',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           primaryTextTheme: Typography().white,
//           textTheme: Typography().white,
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (ctxDummy) => SignInScreen(),
//           '/signup': (context) => SignUpScreen(),
//           '/homePage': (ctxDummy) => HomeScreen(),
//           '/profile': (dummyCtx) => Profile(),
//           '/tabs': (dummyCtx) => TabsControllerScreen(),
//           '/postPage': (dummyCtx) => MyHomePage(),
//         },
//       ),
//     );
//   }
// }

import 'package:fasa7ny/screens/favorite.dart';
import 'package:fasa7ny/screens/homePage.dart';
import 'package:fasa7ny/screens/home_Screen.dart';
import 'package:fasa7ny/screens/profile.dart';
import 'package:fasa7ny/screens/profile_provider.dart';
import 'package:fasa7ny/screens/service/idProvider.dart';
import 'package:fasa7ny/screens/signin_screen.dart';
import 'package:fasa7ny/screens/signup_screen.dart';
import 'package:fasa7ny/screens/tabsControllerScreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDzMJpT91MCLQRB3SCKxsnDc4ICmM4B6c0", // Your apiKey
    appId: "1:597602118740:android:93b76ed3463a0c8d0451c1", // Your appId
    messagingSenderId: "597602118740", // Your messagingSenderId
    projectId: "fasahni-67d0d",
  ));
  //
  runApp(const MyApp());
  void initState() {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    fbm.subscribeToTopic("classChat");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => IdProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: Typography().white,
          textTheme: Typography().white,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctxDummy) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/homePage': (ctxDummy) => HomeScreen(),
          '/profile': (dummyCtx) => Profile(),
          '/tabs': (dummyCtx) => TabsControllerScreen(),
          '/postPage': (dummyCtx) => MyHomePage(),
          '/favorite': (dummyCtx) => FavoriteScreen()
        },
      ),
    );
  }
}
