import 'package:flutter/material.dart';
import 'package:my_nutri/src/pages/login.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Nutri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.green,
        /*inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder()),*/
      ),
      
      home: LoginPage(),
    );
  }
}
