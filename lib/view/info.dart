import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _HomePageState();
}

class _HomePageState extends State<Info> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('INFORMAÇÕES DE CYBERSEGURANÇA'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        height: 50.0,
        color: Colors.black,
        child: Container(
          height: 50.0,  // Ajuste para diminuir a altura da barra inferior
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 0.0),  // Adicionar margem superior ao botão
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
          },
          child: Icon(Icons.home, color: Colors.white),
        ),
      ),
    );
  }
}

