import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/controller/apiAccess.dart';
import 'package:sherlock/view/widgets/infoCard.dart';

Widget _buildIcon(Map mensagemAnalisada) {
  if (mensagemAnalisada['score'] == '...') {
    return Icon(Icons.message);
  } else if (mensagemAnalisada['score'] > 60) {
    return Icon(Icons.error_outline, color: Colors.red, size: 50);
  } else {
    return Icon(Icons.tag_faces_outlined, color: Colors.green, size: 50);
  }
}

class MessageCheck extends StatefulWidget {
  const MessageCheck({Key? key}) : super(key: key);

  @override
  State<MessageCheck> createState() => _MessageCheckState();
}

class _MessageCheckState extends State<MessageCheck> {
  final _textController = TextEditingController();
  Map<String, dynamic> mensagemAnalisada = {'score': '...', 'reason': '...'};

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
                      'Verifique se uma Mensagem é Segura',
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
              SizedBox(height: 30),
              TextField(
                controller: _textController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Digite a mensagem',
                  hintStyle: TextStyle(fontSize: 18),
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
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        var inputMessage = _textController.text;
                        mensagemAnalisada = await messageAnalysis(inputMessage);
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
                        'Verificar Mensagem',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
              ),
              SizedBox(height: 30),
              InfoCard(
                label: 'Possibilidade de ser golpe:',
                value: mensagemAnalisada['score'] == null
                    ? "Erro na consulta!"
                    : mensagemAnalisada['score'] == "..."
                        ? "..."
                        : "${mensagemAnalisada['score']}%",
                icon: _buildIcon(mensagemAnalisada),
              ),
              InfoCard(
                label: 'Descrição:',
                value: mensagemAnalisada['reason'] ??
                    "Erro na consulta. Tente novamente mais tarde",
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
