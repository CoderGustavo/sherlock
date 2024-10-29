import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/controller/apiAccess.dart';
import 'package:sherlock/view/widgets/infoCard.dart';

Widget _buildIcon(Map fakenewsAnalisada) {
  if (fakenewsAnalisada['fake'] == '...') {
    return Icon(Icons.newspaper_rounded);
  } else if (fakenewsAnalisada['fake'] == false) {
    return Icon(Icons.tag_faces_outlined, color: Colors.green);
  } else {
    return Icon(Icons.error_outlined, color: Colors.red);
  }
}

class FakeNews extends StatefulWidget {
  const FakeNews({Key? key}) : super(key: key);

  @override
  State<FakeNews> createState() => _FakeNewsState();
}

class _FakeNewsState extends State<FakeNews> {
  final _textController = TextEditingController();
  Map<String, dynamic> fakenewsAnalisada = {'fake': '...', 'description': '...'};

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
                      'Verifique a veracidade de uma notícia',
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
                decoration: InputDecoration(
                  hintText: 'Insira uma notícia ou boato',
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
                onPressed: () async {
                  var inputUrl = _textController.text;
                  fakenewsAnalisada = await fakenewsAnalysis(inputUrl);
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
                  'Verificar Notícia',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              InfoCard(
                label: 'Notícia ou boato verdadeiro?',
                value: fakenewsAnalisada['fake'] == true
                    ? "Isso é uma Notícia falsa (FakeNews)!"
                    : fakenewsAnalisada['fake'] == "..."
                        ? "..."
                        : fakenewsAnalisada['fake'] == null
                            ? "Erro na consulta!"
                            : "Não há indícios de ser uma notícia falsa (FakeNews)",
                icon: _buildIcon(fakenewsAnalisada),
              ),
              InfoCard(
                label: 'Avaliação',
                value: fakenewsAnalisada['description'] ?? "Erro na consulta. Tente novamente mais tarde",
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
