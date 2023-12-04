import 'package:final_project_pmsn2023/provider/provider.dart';
import 'package:final_project_pmsn2023/routes.dart';
import 'package:final_project_pmsn2023/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogProvider(),
      child: MaterialApp(
        home: const HomeScreen(),
        routes: getRoutes()
      )
    );
  }
}

