import 'package:final_project_pmsn2023/firebase/firebase_service.dart';
import 'package:final_project_pmsn2023/widgets/qr_generator.dart';
import 'package:flutter/material.dart';

class InvitationsScreen extends StatelessWidget {
  const InvitationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Color.fromRGBO(0, 67, 186, 1),
                    unselectedLabelColor: Colors.grey,
                    tabs: _tabs_menu,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              children: _tabs
                  .map(
                    (e) => Center(
                      child:
                          e.child, // Aquí accedemos a la propiedad child de Tab
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

const _tabs_menu = [
  Tab(
    icon: Icon(Icons.home_rounded),
    text: 'Mis eventos',
  ),
  Tab(
    icon: Icon(Icons.shopping_bag_rounded),
    text: 'Mis invitaciones',
  ),
];

List<Tab> _tabs = [
  Tab(
    child: MisEventos(),
  ),
  Tab(
    child: Container(),
  ),
];

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class MisEventos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

          return Column(
            children: data.map((elemento) {
              return Card(
                color: Color.fromRGBO(0, 67, 186, 1),
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  title: Text(elemento['name'],
                      style: TextStyle(color: Colors.white)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BotonCuadrado(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenerateQR(id: elemento['id']),
                            ),
                          );
                        },
                        icono: Icons.qr_code_scanner_rounded,
                      ),
                      BotonCuadrado(
                        onPressed: () {
                          print(elemento['description']);
                        },
                        icono: Icons.list,
                      ),
                      BotonCuadrado(
                        onPressed: () {
                          print(elemento['id']);
                        },
                        icono: Icons.edit,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}

class MisInvitaciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

          return Column(
            children: data.map((elemento) {
              return Card(
                color: Color.fromRGBO(0, 67, 186, 1),
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  title: Text(elemento['name'],
                      style: TextStyle(color: Colors.white)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BotonCuadrado(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenerateQR(id: elemento['id']),
                            ),
                          );
                        },
                        icono: Icons.qr_code_scanner_rounded,
                      ),
                      BotonCuadrado(
                        onPressed: () {
                          print(elemento['description']);
                        },
                        icono: Icons.list,
                      ),
                      BotonCuadrado(
                        onPressed: () {
                          print(elemento['id']);
                        },
                        icono: Icons.edit,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}

class BotonCuadrado extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icono;

  BotonCuadrado({required this.onPressed, required this.icono});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Icon(icono),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InvitationsScreen(),
  ));
}
