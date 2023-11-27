// ignore_for_file: use_build_context_synchronously

import 'package:final_project_pmsn2023/contants.dart';
import 'package:final_project_pmsn2023/widgets/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  late String _confirmPass;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, '/home');
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TopScreenImage(screenImageName: 'signup.png'),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ScreenTitle(title: 'Inicia tu Registro'),
                          CustomTextField(
                            textField: TextField(
                              onChanged: (value) {
                                _email = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Correo electrónico',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              onChanged: (value) {
                                _password = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Contraseña',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              onChanged: (value) {
                                _confirmPass = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Confirma tu contraseña',
                              ),
                            ),
                          ),
                          CustomBottomScreen(
                            textButton: 'Registrate',
                            heroTag: 'signup_btn',
                            question: 'Ya tiene una cuenta?',
                            buttonPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                _saving = true;
                              });
                              if (_confirmPass == _password) {
                                try {
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _email, password: _password);
                                      
                                  if (context.mounted) {
                                    signUpAlert(
                                      context: context,
                                      title: 'EXCELENTE',
                                      desc: 'Ahora ya puede iniciar sesión',
                                      btnText: 'Acceder',
                                      onPressed: () {
                                        setState(() {
                                          _saving = false;
                                          Navigator.popAndPushNamed(
                                              context, '/signup');
                                        });
                                        Navigator.pushNamed(
                                            context, '/login');
                                      },
                                    ).show();
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showAlert(
                                      context: context,
                                      title: 'Contraseña demisiado debil',
                                      desc: 'Tu contraseña debe tener más de 6 caracteres',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }).show();
                                  } else if (e.code == 'email-already-in-use') {
                                    showAlert(
                                      context: context,
                                      title: 'Usuario ya existente',
                                      desc: 'El correo ingresado ya esta asociado a una cuenta existente',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }).show();
                                  } else if (e.code == 'invalid-email') {
                                    showAlert(
                                      context: context,
                                      title: 'Correo no valido',
                                      desc: 'Revisa que tu correo sea valido',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }).show();
                                  }
                                }
                              } else {
                                showAlert(
                                  context: context,
                                  title: 'CONTRASEÑA ERRONEA',
                                  desc:'Asegurate que hayas escrito la misma contraseña',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }).show();
                              }
                            },
                            questionPressed: () async {
                              Navigator.pushNamed(context, '/login');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}