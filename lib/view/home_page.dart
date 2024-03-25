import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super (key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('HOME PAGE'),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 20.0
          ),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index){
              print(index);
            },
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                  icon: Icons.password_rounded,
                  text: 'Senha',
              ),
              GButton(
                  icon: Icons.message_rounded,
                  text: 'Texto',
              ),
              GButton(
                  icon: Icons.phonelink_ring_rounded,
                  text: 'Telefone',
              ),
              GButton(
                  icon: Icons.link_rounded,
                  text: 'Site',
              ),
            ],
          ),
        ),
      ),
    );
  }
}