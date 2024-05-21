import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/view/message.dart';
import 'package:sherlock/view/phishing.dart';
import 'package:sherlock/view/password.dart';
import 'package:sherlock/controller/apiAccess.dart';

Widget _buildIcon(Map telefoneAnalisado){
  if (telefoneAnalisado['number_score'] == '...') {
    return Icon(Icons.settings_phone);
  } else if (telefoneAnalisado['number_score'] <= 30)  {
    return Icon(Icons.tag_faces_outlined, color: Colors.green);
  } else {
    return Icon(Icons.error_outlined, color: Colors.red);
  }
}

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  int _selectedIndex = 3;

  final _textController = TextEditingController();
  Map<String, dynamic> telefoneAnalisado = {'number_score': '...', 'description': '...'};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Image.asset(
                  '../assets/logo.png',
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child:
                  Text('TELEFONE SPAM?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Digite um telefone',
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
                  var inputPhone = _textController.text;
                  telefoneAnalisado = await callAnalysis(inputPhone);
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
                    labelText: 'Possibilidade de SPAM',
                    labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black), // Cor da borda
                    ),
                    suffixIcon: _buildIcon(telefoneAnalisado),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black), // Cor do texto
                  controller: TextEditingController(text: telefoneAnalisado['number_score'].toString()),
                  // Use o onChanged para forçar a atualização do layout quando o texto for alterado
                  onChanged: (_) => setState(() {}),
                ),

                SizedBox(height: 20), // Espaço entre os TextField

                TextField(
                  enabled: false,
                  minLines: 1,
                  maxLines: null, // Isso permite que o campo tenha várias linhas conforme necessário
                  decoration: InputDecoration(
                    labelText: 'Motivo',
                    labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black), // Cor da borda
                    ),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black), // Cor do texto
                  controller: TextEditingController(text: telefoneAnalisado['description']),
                  // Use o onChanged para forçar a atualização do layout quando o texto for alterado
                  onChanged: (_) => setState(() {}),
                ),

                SizedBox(height: 10), // Espaço entre os TextField
              ],
            ),


          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                if (_selectedIndex == 0) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Password()), (route) => false);
                } else if (_selectedIndex == 1) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Message()), (route) => false);
                } else if (_selectedIndex == 3) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Call()), (route) => false);
                } else if (_selectedIndex == 4) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Phishing()), (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                }
              });
            },
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.password_rounded,
              ),
              GButton(
                icon: Icons.message_rounded,
              ),
              GButton(
                  icon: Icons.security_rounded,
              ),
              GButton(
                active: _selectedIndex == 3,
                icon: Icons.phonelink_ring_rounded,
              ),
              GButton(
                icon: Icons.link_rounded,
              ),
            ],
            selectedIndex: _selectedIndex,
          ),
        ),
      ),
    );
  }
}