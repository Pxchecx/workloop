import 'package:flutter/material.dart';

void main() {
  runApp(MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demostración Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _indiceActual = 0;

  final List<Widget> _tabs = [
    PrimeraTab(),
    SegundaTab(),
  ];

  void _navegarANuevaPantalla() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NuevaPantalla()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Demostración Flutter'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuraciones'),
              onTap: () {
                _navegarANuevaPantalla(); 
              },
            ),
          ],
        ),
      ),
      body: _tabs[_indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        onTap: (int index) {
          setState(() {
            _indiceActual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Tab 2',
          ),
        ],
      ),
    );
  }
}

class PrimeraTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Primera Tab'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PantallaHija(dato: 'Hola desde la Primera Tab')),
              );
            },
            child: Text('Ir a la Pantalla Hijo'),
          ),
        ],
      ),
    );
  }
}

class SegundaTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Segunda Tab'),
    );
  }
}

class PantallaHija extends StatelessWidget {
  final String dato;

  PantallaHija({required this.dato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Hijo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dato),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Dato desde la Pantalla Hijo');
              },
              child: Text('Volver con Dato'),
            ),
          ],
        ),
      ),
    );
  }
}

class NuevaPantalla extends StatefulWidget {
  @override
  _NuevaPantallaState createState() => _NuevaPantallaState();
}

class _NuevaPantallaState extends State<NuevaPantalla> {
  String _datoDesdeHija = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Pantalla'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaHija(dato: 'Dato enviado desde el Padre')),
                );

                if (resultado != null) {
                  setState(() {
                    _datoDesdeHija = resultado;
                  });
                }
              },
              child: Text('Ir a la Pantalla Hijo'),
            ),
            SizedBox(height: 20),
            Text('Dato recibido desde la Hijo: $_datoDesdeHija'),
          ],
        ),
      ),
    );
  }
}
