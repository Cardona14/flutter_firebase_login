import 'package:final_project_pmsn2023/widgets/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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
    User? user = FirebaseAuth.instance.currentUser;
    String? accountName = 'Nombre del Usuario';
    String? accountEmail = 'Correo Electrónico';
    String? profilePhotoUrl = 'URL de la foto de perfil';

    if (user != null) {
      for (final providerProfile in user.providerData) {
        accountName = providerProfile.displayName;
        accountEmail = providerProfile.email;
        profilePhotoUrl = providerProfile.photoURL;
      }
    }

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: profilePhotoUrl != null ? NetworkImage(profilePhotoUrl) : const AssetImage('avatar.png') as ImageProvider,
            ),
            accountName: Text(accountName ?? 'Nombre del Usuario'),
            accountEmail: Text(accountEmail ?? 'Correo Electrónico'),
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
                  title: 'Sesión finalizada',
                  desc:'Vuelve pronto',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  }).show();
              } catch (e) {
                showAlert(
                  context: context,
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