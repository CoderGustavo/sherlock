import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/controller/apiAccess.dart';
import 'package:sherlock/view/widgets/infoCard.dart';

Widget _buildIcon(Map urlAnalisada) {
  if (urlAnalisada['score'] == '...') {
    return Icon(Icons.add_link_rounded, size: 30);
  } else if (urlAnalisada['score'] > 60) {
    return Icon(Icons.tag_faces_outlined, color: Colors.green, size: 50);
  } else {
    return Icon(Icons.error_outlined, color: Colors.red, size: 50);
  }
}

class Phishing extends StatefulWidget {
  const Phishing({Key? key}) : super(key: key);

  @override
  State<Phishing> createState() => _PhishingState();
}

class _PhishingState extends State<Phishing> {
  final _textController = TextEditingController();
  Map<String, dynamic> urlAnalisada = {'score': '...', 'reason': '...'};

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
                      'Verifique um Link',
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
                  hintText: 'Insira um link',
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
                onPressed: () async {
                  var inputUrl = _textController.text;
                  urlAnalisada = await urlAnalysis(inputUrl);
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Verificar Link',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              InfoCard(
                label: 'Link confiável?',
                value: (urlAnalisada['score'] != null &&
                        urlAnalisada['score'] is int &&
                        urlAnalisada['score'] < 40)
                    ? "Sim, é confiável"
                    : (urlAnalisada['score'] == '...'
                        ? "..."
                        : "Cuidado! Não é confiável"),
                icon: _buildIcon(urlAnalisada),
              ),
              InfoCard(
                label: 'Motivo:',
                value: urlAnalisada['reason'] ??
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

  Widget _buildInfoCard(
      {required String label, required String value, Widget? icon}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              icon,
              SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
