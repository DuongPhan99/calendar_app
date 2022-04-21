import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/landing_page.dart';
import 'package:flutter_time_app/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: "Time App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme:
                AppBarTheme(color: Colors.blue[900], centerTitle: true)),
        home: LandingPage(),
      ),
    );
  }
}
