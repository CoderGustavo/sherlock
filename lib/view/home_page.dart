import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherlock/view/call.dart';
import 'package:sherlock/view/message.dart';
import 'package:sherlock/view/phishing.dart';
import 'package:sherlock/view/password.dart';
import 'package:sherlock/view/info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Password()), (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.grey[900],
                        shadowColor: Colors.black, // Cor da sombra
                        elevation: 8, // Altura da sombra
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Icon(Icons.password_rounded,
                                  size: 40,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Center(
                                child: Text('Força da senha',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Message()), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.red[900],
                          shadowColor: Colors.black, // Cor da sombra
                          elevation: 8, // Altura da sombra
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Icon(Icons.message_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Text('Essa mensagem é golpe?',
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Call()), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.grey[900],
                          shadowColor: Colors.black, // Cor da sombra
                          elevation: 8, // Altura da sombra
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Icon(Icons.phonelink_ring_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Text('O número é SPAM?',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Phishing()), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.red[900],
                          shadowColor: Colors.black, // Cor da sombra
                          elevation: 8, // Altura da sombra
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Icon(Icons.link_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Text('Link confiável?',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Info()), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.grey[900],
                          shadowColor: Colors.black, // Cor da sombra
                          elevation: 8, // Altura da sombra
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Icon(Icons.security_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Text('Dicas e informações de Cibersegurança',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
              ),
            ],
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