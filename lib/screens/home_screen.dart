// ignore_for_file: use_build_context_synchronously

import 'package:final_project_pmsn2023/widgets/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopScreenImage(screenImageName: 'home.jpg'),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const ScreenTitle(title: 'Hola'),
                      const Text(
                        'Bienvenido a InvitApp, aquí podrás gestionar los accesos a tus eventos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Hero(
                        tag: 'login_btn',
                        child: CustomButton(
                          buttonText: 'Ingresa',
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Hero(
                        tag: 'signup_btn',
                        child: CustomButton(
                          buttonText: 'Registrate',
                          isOutlined: true,
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Registrate usando',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/icons/facebook.png'),
                            ),
                            onPressed: () async {
                              try {
                                final LoginResult loginResult = await FacebookAuth.instance.login();
                                
                                if (loginResult.status == LoginStatus.success) {
                                  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
                                  final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
                                  
                                  if (userCredential.user != null) {
                                    Navigator.pushReplacementNamed(context, '/dash');
                                  } else {
                                    showAlert(
                                      context: context,
                                      title: 'Error de autenticación',
                                      desc: 'Ocurrió un error al acceder con Facebook',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ).show();
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'invalid-credential') {
                                  signUpAlert(
                                    context: context,
                                    onPressed: () {
                                      Navigator.popAndPushNamed(context, '/welcome');
                                    },
                                    title: 'Error de autenticación',
                                    desc: 'Ocurrió un error al acceder con Facebook',
                                    btnText: 'Prueba Ahora',
                                  ).show();
                                } else {
                                  print('Error al iniciar sesión con Facebook: $e');
                                }
                              }
                            },
                          ),
                          IconButton(
                            icon: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/icons/google.png'),
                            ),
                            onPressed: () async{
                              try {
                                final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                                final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      
                                final credentials = GoogleAuthProvider.credential(
                                  accessToken: googleAuth?.accessToken,
                                  idToken: googleAuth?.idToken,
                                );
                                await FirebaseAuth.instance.signInWithCredential(credentials);
                                
                                final currentUser = FirebaseAuth.instance.currentUser;
                                if (currentUser != null) {
                                  Navigator.pushReplacementNamed(context, '/dash');
                                } else {
                                  showAlert(
                                      context: context,
                                      title: 'Error de autenticación',
                                      desc: 'Ocurrió un error al acceder con Google',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }).show();
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'invalid-credential') {
                                  signUpAlert(
                                    context: context,
                                    onPressed: () {
                                      Navigator.popAndPushNamed(context, '/welcome');
                                    },
                                    title: 'Error de autenticación',
                                    desc: 'Ocurrió un error al acceder con Google',
                                    btnText: 'Prueba Ahora',
                                  ).show();
                                } else {
                                  print('Error al iniciar sesión con Google: $e');
                                }
                              }
                            },
                          ),
                          IconButton(
                            icon: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  'assets/icons/github.png'),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
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