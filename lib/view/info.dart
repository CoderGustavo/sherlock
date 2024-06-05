import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherlock/view/home_page.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  "Dicas e Informações de Cibersegurança",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              const ExpansionTile(
                title: Text(
                  "Protegendo seu e-mail",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Seu e-mail é como sua identidade online. Mantenha sua senha segura e não compartilhe com ninguém. Evite clicar em links suspeitos enviados por e-mail, pois eles podem ser usados para roubar suas informações pessoais.',
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
              const ExpansionTile(
                title: Text(
                  "O que é phishing?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Phishing é uma técnica usada por criminosos para enganar você e obter suas informações confidenciais, como senhas e números de cartão de crédito. Fique atento a e-mails ou mensagens suspeitas solicitando suas informações pessoais.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                  "Cuidados com contas bancárias",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Ao acessar sua conta bancária online, certifique-se de estar em um site seguro. Verifique se há um cadeado na barra de endereço e evite realizar transações financeiras em redes Wi-Fi públicas, pois elas podem não ser seguras.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                  "SPAM e Mensagens suspeitas",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Mantenha-se alerta a e-mails ou mensagens não solicitadas, pois podem conter vírus ou tentativas de golpes. Não clique em links ou baixe anexos de remetentes desconhecidos.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                  "O que é Engenharia social?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'A Engenharia Social é uma técnica usada por hackers para manipular pessoas e obter informações confidenciais. Desconfie de solicitações incomuns por telefone ou e-mail, mesmo que pareçam legítimas.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              )
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
