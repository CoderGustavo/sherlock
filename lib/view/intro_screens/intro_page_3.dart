import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém o tamanho da tela
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/Security.png', // Substitua pelo caminho da sua imagem
              width: screenSize.width * 1.0, // 80% da largura da tela
              height: screenSize.height * 0.6, // 60% da altura da tela
              fit: BoxFit.contain, // Modo de ajuste da imagem
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(
                    5.0), // Adiciona padding de 5 em todos os lados
                child: Text(
                  'Garanta maior confiabilidade',
                  textAlign:
                      TextAlign.center, // Centraliza o texto horizontalmente
                  style: TextStyle(
                      fontWeight: FontWeight.bold, // Define o texto em negrito
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
