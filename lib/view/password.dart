import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/controller/apiAccess.dart';
import 'package:sherlock/view/widgets/infoCard.dart';

Widget _buildIcon(Map senhaAnalisada) {
  if (senhaAnalisada['level'] == '...') {
    return Icon(Icons.lock_clock);
  } else if (senhaAnalisada['level'] >= 0 && senhaAnalisada['level'] <= 6) {
    return Icon(Icons.error_outlined, color: Colors.red, size: 50);
  } else {
    return Icon(Icons.tag_faces_outlined, color: Colors.green, size: 50);
  }
}

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final _textController = TextEditingController();
  Map<String, dynamic> senhaAnalisada = {'level': '...', 'description': '...'};

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      'Verifique a segurança da senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _textController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Digite uma senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });

                        var inputUrl = _textController.text;
                        senhaAnalisada = await passwordAnalysis(inputUrl);

                        setState(() {
                          isLoading = false;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                  'Verificar Senha',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              InfoCard(
                label: 'Nível',
                value: senhaAnalisada['level'] == null
                    ? "Erro na consulta!"
                    : senhaAnalisada['level'].toString(),
                icon: _buildIcon(senhaAnalisada),
              ),
              InfoCard(
                label: 'Descrição',
                value: senhaAnalisada['description'] ?? "Erro na consulta. Tente novamente mais tarde",
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.red[900],
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
          },
          child: Icon(Icons.home, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        height: 50.0,
        color: Colors.black,
        child: Container(
          height: 50.0,
        ),
      ),
    );
  }
}
