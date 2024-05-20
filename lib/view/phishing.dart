import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sherlock/view/call.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/view/message.dart';
import 'package:sherlock/view/password.dart';
import 'package:sherlock/controller/apiAccess.dart';

Widget _buildIcon(Map urlAnalisada){
  if (urlAnalisada['valida'] == '...') {
    return Icon(Icons.add_link_rounded);
  } else if (urlAnalisada['valida'] == true)  {
    return Icon(Icons.tag_faces_outlined, color: Colors.green);
  } else {
    return Icon(Icons.error_outlined, color: Colors.red);
  }
}

class Phishing extends StatefulWidget {
  const Phishing({Key? key}) : super(key: key);

  @override
  State<Phishing> createState() => _PhishingState();
}

class _PhishingState extends State<Phishing> {
  int _selectedIndex = 4;

  final _textController = TextEditingController();
  Map<String, dynamic> urlAnalisada = {'valida': '...', 'motivo': '...'};


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
                  Text('VERIFIQUE UM LINK',
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
                hintText: 'Insira um link',
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
                  var inputUrl = _textController.text;
                  urlAnalisada = await urlAnalysis(inputUrl);
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
                    labelText: 'Link confiável?',
                    labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black), // Cor da borda
                    ),
                    suffixIcon: _buildIcon(urlAnalisada),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black), // Cor do texto
                  controller: TextEditingController(text: urlAnalisada['valida'] == true ? "Link confiável" : urlAnalisada['valida'] == "..." ? "..." : "CUIDADO! Link não confiável"),
                  // Use o onChanged para forçar a atualização do layout quando o texto for alterado
                  onChanged: (_) => setState(() {}),
                ),

                SizedBox(height: 20), // Espaço entre os TextField

                TextField(
                  enabled: false,
                  minLines: 1,
                  maxLines: null, // Isso permite que o campo tenha várias linhas conforme necessário
                  decoration: InputDecoration(
                    labelText: 'Avaliação',
                    labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black), // Cor da borda
                    ),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black), // Cor do texto
                  controller: TextEditingController(text: urlAnalisada['motivo']),
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
                icon: Icons.phonelink_ring_rounded,
              ),
              GButton(
                active: _selectedIndex == 4,
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