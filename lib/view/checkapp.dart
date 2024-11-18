import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/controller/apiAccess.dart';
import 'package:sherlock/view/widgets/infoCard.dart';

Widget _buildIcon(Map appAnalisado) {
  if (appAnalisado['score'] == '...' || appAnalisado['score'] == null) {
    return Icon(Icons.app_registration_outlined, size: 30);
  } else if (appAnalisado['score'] <= 30) {
    return Icon(Icons.tag_faces_outlined, color: Colors.green, size: 50);
  } else {
    return Icon(Icons.error_outline, color: Colors.red, size: 50);
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
        'Verifique se um Aplicativo é Confiável',
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
                  hintText: 'Digite o nome do aplicativo',
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
                  var inputApp = _textController.text;
                  appAnalisado = await appAnalysis(inputApp);
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
                  'Verificar Aplicativo',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              InfoCard(
                label: 'Chance de ser malicioso:',
                value: appAnalisado['score'] == null
                    ? "Erro na consulta!"
                    : appAnalisado['score'].toString(),
                icon: _buildIcon(appAnalisado)
              ),
              InfoCard(
                label: 'Descrição:',
                value: appAnalisado['description'] ?? "Erro na consulta. Tente novamente mais tarde",
              ),
              InfoCard(
                label: 'Disponível na Play Store?',
                value: (appAnalisado['play_store'] ?? 0) == 1
                    ? "Sim, está Disponível"
                    : (appAnalisado['play_store'] == null ||
                            appAnalisado['play_store'] == "..." ||
                            appAnalisado['play_store'] == 555)
                        ? "..."
                        : "Não está disponível",
              ),
              InfoCard(
                label: 'Disponível na Apple Store?',
                value: (appAnalisado['app_store'] ?? 0) == 1
                    ? "Sim, está Disponível"
                    : (appAnalisado['app_store'] == null ||
                            appAnalisado['app_store'] == "..." ||
                            appAnalisado['app_store'] == 555)
                        ? "..."
                        : "Não está disponível",
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

  Widget _buildInfoCard({required String label, required String value, Widget? icon}) {
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
