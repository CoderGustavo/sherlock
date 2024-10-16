import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/controller/apiAccess.dart';

Widget _buildIcon(Map appAnalisado) {
  if (appAnalisado['score'] == '...' || appAnalisado['score'] == null) {
    return Icon(Icons.app_registration_outlined);
  } else if (appAnalisado['score'] <= 30) {
    return Icon(Icons.tag_faces_outlined, color: Colors.green);
  } else {
    return Icon(Icons.error_outlined, color: Colors.red);
  }
}

class CheckApp extends StatefulWidget {
  const CheckApp({Key? key}) : super(key: key);

  @override
  State<CheckApp> createState() => _CheckAppState();
}

class _CheckAppState extends State<CheckApp> {
  final _textController = TextEditingController();
  Map<String, dynamic> appAnalisado = {
    'score': '...',
    'description': '...',
    'play_store': '...',
    'app_store': '...',
  };

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
                    'APLICATIVO CONFIÁVEL?',
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
                  hintText: 'Digite o nome do aplicativo',
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
                    var inputApp = _textController.text;
                    appAnalisado = await appAnalysis(inputApp);
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
                      labelText: 'Possibilidade de ser um aplicativo malicioso',
                      labelStyle: TextStyle(
                          color: Colors.black), // Cor do texto do label
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Cor da borda
                      ),
                      suffixIcon: _buildIcon(appAnalisado),
                    ),
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black), // Cor do texto
                    controller: TextEditingController(
                        text: appAnalisado['score'] == null ? "Erro na consulta!" : appAnalisado['score'].toString()),
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
                      labelText: 'Descrição',
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
                    controller: TextEditingController(
                        text: appAnalisado['description'] ?? "Erro na consulta. Tente novamente mais tarde"),
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
                      labelText: 'Disponível na Play Store?',
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
                    controller: TextEditingController(
                        text: (appAnalisado['play_store'] ?? 0) == 1
                            ? "Disponível"
                            : (appAnalisado['play_store'] == null || appAnalisado['play_store'] == "..." || appAnalisado['play_store'] == 555)
                            ? "..."
                            : "Não disponível"),
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
                      labelText: 'Disponível na Apple Store?',
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
                    controller: TextEditingController(
                        text: (appAnalisado['app_store'] ?? 0) == 1
                            ? "Disponível"
                            : (appAnalisado['app_store'] == null || appAnalisado['app_store'] == "..." || appAnalisado['app_store'] == 555)
                            ? "..."
                            : "Não disponível"),
                    // Use o onChanged para forçar a atualização do layout quando o texto for alterado
                    onChanged: (_) => setState(() {}),
                  ),

                  SizedBox(height: 20), // Espaço entre os TextField
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
