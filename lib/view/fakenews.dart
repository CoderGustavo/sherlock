import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/controller/apiAccess.dart';

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
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                child: Center(
                  child: Text(
                    'VERIFIQUE UMA NOTÍCIA',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Insira uma notícia ou boato',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MaterialButton(
                  onPressed: () async {
                    var inputNews = _textController.text;
                    fakenewsAnalisada = await fakenewsAnalysis(inputNews);
                    setState(() {});
                  },
                  color: Colors.black,
                  child: const Text(
                    'Verificar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Notícia ou boato verdadeiro?',
                      labelStyle: TextStyle(
                          color: Colors.black), // Cor do texto do label
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Cor da borda
                      ),
                      suffixIcon: _buildIcon(fakenewsAnalisada),
                    ),
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black), // Cor do texto
                    controller: TextEditingController(
                        text: fakenewsAnalisada['fake'] == true
                            ? "Isso é uma Notícia falsa (FakeNews)!"
                            : fakenewsAnalisada['fake'] == "..."
                                ? "..."
                                  : fakenewsAnalisada['fake'] == null
                                    ? "Erro na consulta!"
                                      :"Não há indícios de ser uma notícia falsa (FakeNews)"),
                    // Use o onChanged para forçar a atualização do layout quando o texto for alterado
                    onChanged: (_) => setState(() {}),
                  ),

                  SizedBox(height: 20), // Espaço entre os TextField

                  TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines:
                        null, // Isso permite que o campo tenha várias linhas conforme necessário
                    decoration: InputDecoration(
                      labelText: 'Avaliação',
                      labelStyle: TextStyle(
                          color: Colors.black), // Cor do texto do label
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Cor da borda
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black), // Cor do texto
                    controller:
                        TextEditingController(text: fakenewsAnalisada['description'] ?? "Erro na consulta. Tente novamente mais tarde"),
                    // Use o onChanged para forçar a atualização do layout quando o texto for alterado
                    onChanged: (_) => setState(() {}),
                  ),

                  SizedBox(height: 10), // Espaço entre os TextField
                ],
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
          height: 50.0, // Ajuste para diminuir a altura da barra inferior
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            top: 0.0), // Adicionar margem superior ao botão
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
    );
  }
}
