import 'package:final_project_pmsn2023/screens/dash_events_screen.dart';
import 'package:final_project_pmsn2023/screens/invitations_manager_screen.dart';
import 'package:final_project_pmsn2023/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class GoogleBottomBar extends StatefulWidget {
  const GoogleBottomBar({Key? key}) : super(key: key);

  @override
  State<GoogleBottomBar> createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> {
  int _selectedIndex = 0;

  static List<Widget> screens_dashboard = <Widget>[
    HomeDash(),
    const InvitationsScreen(),

/*     Container(
        padding: const EdgeInsets.all(8.0),
        child: Text("InvitApp",
            style: TextStyle(
                fontFamily: "Poppins-Bold",
                fontSize: ScreenUtil().setSp(46),
                fontWeight: FontWeight.bold))), */
    /*FutureBuilder(
      future: getEvento(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras espera, puedes mostrar un indicador de carga
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // En caso de error, puedes manejar el error aquí
          return Text('Error: ${snapshot.error}');
        } else {
          // Los datos han sido cargados con éxito, puedes trabajar con ellos aquí
          List<dynamic>? data = snapshot.data as List<dynamic>?;

          // Asegúrate de manejar el caso en que los datos sean nulos
          if (data == null || data.isEmpty) {
            return Text('No hay datos disponibles');
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              // Asegúrate de manejar el caso en que el elemento actual pueda ser nulo
              var nombre =
                  data[index]['nombre'] as String? ?? 'Nombre no disponible';

              return ListTile(
                title: Text(nombre),
              );
            },
          );
        }
      },
    ), */
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/InvitApp.png",
              width: ScreenUtil().setWidth(110),
              height: ScreenUtil().setHeight(110),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text("InvitApp",
                    style: TextStyle(
                        fontFamily: "Poppins-Bold",
                        fontSize: ScreenUtil().setSp(46),
                        fontWeight: FontWeight.bold)))
          ],
        ),
      ),
      body: Center(
        child: screens_dashboard[_selectedIndex],
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Inicio"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.calendar_month_rounded),
    title: const Text("Invitaciones"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Perfil"),
    selectedColor: Colors.teal,
  ),
];
