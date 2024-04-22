import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/view/message.dart';
import 'package:sherlock/view/phishing.dart';
import 'package:sherlock/view/call.dart';
import 'package:sherlock/controller/apiAccess.dart';
import 'dart:convert';

Widget _buildIcon(Map senhaAnalisada){
  if (senhaAnalisada['level'] == '...') {
    return Icon(Icons.lock_clock); // Ícone de carregamento
  } else if (senhaAnalisada['level'] == 0 || senhaAnalisada['level'] == 1 || senhaAnalisada['level'] == 2 || senhaAnalisada['level'] == 3 || senhaAnalisada['level'] == 4 || senhaAnalisada['level'] == 5 || senhaAnalisada['level'] == 6) {
    return Icon(Icons.error_outlined, color: Colors.red); // Ícone para cima
  } else {
    return Icon(Icons.tag_faces_outlined, color: Colors.green); // Ícone de carregamento
  }
}

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  int _selectedIndex = 0;

  final _textController = TextEditingController();
  Map<String, dynamic> senhaAnalisada = {'level': '...', 'description': '...'};

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
                  Text('VERIFIQUE A SEGURANÇA DA SENHA',
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
                hintText: 'Digite uma senha',
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
                  var inputPassword = _textController.text;
                  senhaAnalisada = await passwordAnalysis(inputPassword);
                  print(senhaAnalisada['description']);
                  setState(() {}); // Atualiza o estado para reconstruir a UI com os novos valores
                },
                color: Colors.black,
                child: const Text(
                  'Verificar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Campos de texto para exibir o resultado da análise da senha
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                TextField(
                  enabled: false,
                  minLines: 1,
                  maxLines: null, // Isso permite que o campo tenha várias linhas conforme necessário
                  decoration: InputDecoration(
                    labelText: 'Nível',
                    labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black), // Cor da borda
                    ),
                    suffixIcon: _buildIcon(senhaAnalisada),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black), // Cor do texto
                  controller: TextEditingController(text: senhaAnalisada['level'].toString()),
                  // Use o onChanged para forçar a atualização do layout quando o texto for alterado
                  onChanged: (_) => setState(() {}),
                ),

                SizedBox(height: 20), // Espaço entre os TextField

                TextField(
                  enabled: false,
                  minLines: 1,
                  maxLines: null, // Isso permite que o campo tenha várias linhas conforme necessário
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black), // Cor da borda
                    ),
                  ),
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black), // Cor do texto
                  controller: TextEditingController(text: senhaAnalisada['description']),
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Password()),
                  );
                } else if (_selectedIndex == 1) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Message()),
                  );
                } else if (_selectedIndex == 3) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Call()),
                  );
                } else if (_selectedIndex == 4) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Phishing()),
                  );
                } else {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              });
              print(index);
            },
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                active: _selectedIndex == 0,
                icon: Icons.password_rounded,
              ),
              GButton(
                icon: Icons.message_rounded,
              ),
              GButton(icon: Icons.security_rounded),
              GButton(
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