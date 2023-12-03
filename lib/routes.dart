//import 'package:final_project_pmsn2023/screens/dashboard_screen.dart'; antiguo dash
import 'package:final_project_pmsn2023/screens/dash_events_screen.dart';
import 'package:final_project_pmsn2023/screens/home_screen.dart';
import 'package:final_project_pmsn2023/screens/login_screen.dart';
import 'package:final_project_pmsn2023/screens/signup_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> getRoutes(){
  return <String, WidgetBuilder>{
    '/home' : (BuildContext context) => const HomeScreen(),
    '/login' : (BuildContext context) => const LoginScreen(),
    '/signup' : (BuildContext context) => const SignUpScreen(),
    '/dash' : (BuildContext context) => HomeDash(),
  };
}