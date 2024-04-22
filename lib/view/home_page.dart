import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sherlock/view/call.dart';
import 'package:sherlock/view/message.dart';
import 'package:sherlock/view/phishing.dart';
import 'package:sherlock/view/password.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('INFORMAÇÕES DE CYBERSEGURANÇA'),
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
                } else
                if (_selectedIndex == 1) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Message()),
                  );
                } else
                if (_selectedIndex == 3) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Call()),
                  );
                } else
                if (_selectedIndex == 4) {
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
              ),
              GButton(
                icon: Icons.message_rounded,
              ),
              GButton(
                  active: _selectedIndex == 2,
                  icon: Icons.security_rounded,
              ),
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

