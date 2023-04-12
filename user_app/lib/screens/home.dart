import "package:flutter/material.dart";
import 'package:user_app/screens/code_pin.dart';
import 'package:user_app/screens/code_qr.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w900);
  static const List<Widget> _widgetOptions = <Widget>[
    CodePINScreen(),
    QRScannerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 10,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.pin),
              icon: Icon(Icons.pin),
              label: 'Enter PIN',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Scan QR',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[700],
          backgroundColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
