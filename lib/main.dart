import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/weight_dashboard_screen.dart';
import './screens/auth_screen.dart';
import './screens/add_weight_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeighTracker',
      theme: ThemeData(
        canvasColor: Color.fromARGB(255, 235, 174, 194),
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              headline2: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                color: Colors.white,
              ),
              bodyText1: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        AddWeightForm.routeName: (context) => AddWeightForm(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DashBoardScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
