import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_pmsn2023/widgets/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String accountName = 'Nombre del Usuario';
  String accountEmail = 'Correo Electrónico';
  String profilePhotoUrl = 'URL de la foto de perfil';

  Future<void> fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (user.providerData.any((userInfo) => userInfo.providerId == 'password')) {
        try {
          final DocumentSnapshot<Map<String, dynamic>> userData =
              await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

          if (userData.exists) {
            final String name = userData['name'];
            final String lastName = userData['lastName'];
            final String email = user.email ?? '';
            final String photoURL = userData['photoURL'];

            setState(() {
              accountName = '$name $lastName';
              accountEmail = email;
              profilePhotoUrl = photoURL;
            });
            print(profilePhotoUrl);
          }
        } catch (e) {
          print('Error al obtener los datos desde Firestore: $e');
        }
      } else {
        // No es un registro con correo y contraseña
        setState(() {
          accountName = user.displayName ?? 'Nombre del Usuario';
          accountEmail = user.email ?? 'Correo Electrónico';
          profilePhotoUrl = user.photoURL ?? 'email@example.com';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InvitApp Dashboard'),
      ),
      drawer: createDrawer(context),
    );
  }

  Widget createDrawer(context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: profilePhotoUrl.isNotEmpty ? NetworkImage(profilePhotoUrl) : const AssetImage('assets/avatar.png') as ImageProvider,
            ),
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Presentación del proyecto'),
            onTap: () => Navigator.pushNamed(context, '/onboarding'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () async{
              try {
                await FirebaseAuth.instance.signOut();
                showAlert(
                  context: context,
                  type: AlertType.none,
                  title: 'Sesión finalizada',
                  desc:'Vuelve pronto',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  }).show();
              } catch (e) {
                showAlert(
                  context: context,
                  type: AlertType.error,
                  title: 'Algo salió mal',
                  desc:'Intenta cerrar sesión más tarde',
                  onPressed: () {
                    Navigator.pop(context);
                  }).show();
              }
            },
          ),
        ],
      ),
    );
  }
}