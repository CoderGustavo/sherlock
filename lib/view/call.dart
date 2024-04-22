import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sherlock/view/home_page.dart';
import 'package:sherlock/view/message.dart';
import 'package:sherlock/view/phishing.dart';
import 'package:sherlock/view/password.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('CALL PAGE'),
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