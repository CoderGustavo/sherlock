import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Image.asset('../assets/logo.png',),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  child:
                )
              ]
          ),
        ),
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