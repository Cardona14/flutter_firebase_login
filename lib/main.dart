import 'package:concentric_transition/concentric_transition.dart';
import 'package:final_project_pmsn2023/provider/provider.dart';
import 'package:final_project_pmsn2023/routes.dart';
import 'package:final_project_pmsn2023/screens/home_screen.dart';
import 'package:final_project_pmsn2023/widgets/onboard_card_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

class onBoarding extends StatelessWidget {
  onBoarding({super.key});

  final  data=[
    CardOnBoardData(
      title: "Invitation Management App", 
      subtitle: "Ahora eres parte de la comunidad lince",
      image: const AssetImage('assets/logo_lince.webp'), 
      backgroundColor: Colors.white, 
      titleColor: const Color.fromARGB(255, 17, 117, 51), 
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/bg.json')
    ),
    CardOnBoardData(
      title: "Problematica", 
      subtitle: "AEISC es la asociación estudiantil de tu carrera",
      image: const AssetImage('assets/aeisc.png'), 
      backgroundColor: const Color.fromARGB(255, 17, 117, 51), 
      titleColor:  Colors.white,
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/circuito2.json')
    ),
    CardOnBoardData(
      title: "Objetivo General", 
      subtitle: "En estos espacios disfrutarás de tu vida universitaria y aprenderás junto a tus compañeros",
      image: const AssetImage('assets/campus2.jpg'), 
      backgroundColor: Colors.white, 
      titleColor: const Color.fromARGB(255, 27, 57, 106), 
      subtitleColor: Colors.black,
      background: LottieBuilder.asset('assets/circuito1.json')
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          itemCount: data.length,
          itemBuilder:(int index){
            return CardOnBoard(data: data[index]);
          } ,
          onFinish: (){
            Navigator.pushNamed(context, '/login');
          },
        )
    );
  }
}

