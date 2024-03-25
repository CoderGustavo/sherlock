import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sherlock/view/call.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/view/message.dart';

class Phishing extends StatefulWidget {
  const Phishing({Key? key}) : super(key: key);

  @override
  State<Phishing> createState() => _PhishingState();
}

class _PhishingState extends State<Phishing> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('PHISHING PAGE'),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
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
                if (_selectedIndex == 1) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Message()),
                  );
                } else
                if (_selectedIndex == 2) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Call()),
                  );
                } else
                if (_selectedIndex == 3) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Phishing()),
                  );
                } else{
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
                active: _selectedIndex == 3,
                icon: Icons.link_rounded,
                text: 'Site',
              ),
            ],
            selectedIndex: _selectedIndex,
          ),
        ),
      ),
    );
  }
}