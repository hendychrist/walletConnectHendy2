// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:testing_app/screen/account.dart';
import 'package:testing_app/const/myColors.dart';
import 'package:testing_app/screen/pairings.dart';
import 'package:testing_app/screen/session.dart';
import 'package:testing_app/screen/setting.dart';
import 'package:testing_app/screen/walletConnect.dart';


class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List _pages;
  int _selectedIndex = 2;

  @override
  void initState() {
    _pages = [
      AccountScreen(), 
      SessionsScreen(),
      WalletConnectScreen(),
      PairingsScreen(),
      SettingScreen(),
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        
        elevation: 0,
        notchMargin: 5, // notch uzaklığı
        clipBehavior: Clip.antiAlias, // notch kısmındaki border'ın görünürlüğü yumuşatıldı
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.3,
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0.0,
            onTap: _selectedPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: MyColors.mainColor,
            selectedItemColor: MyColors.secondaryColor,
            currentIndex: _selectedIndex,
            items: [
              
              BottomNavigationBarItem(
                icon:  Image.asset('assets/menuIcon.png' , height: 30, width: 55,),
                tooltip: 'Account',
                label: '',
              ),

              BottomNavigationBarItem(
                icon: Image.asset('assets/sessionIcon.png' , height: 30, width: 55,),
                tooltip: 'Session',
                label: '',
              ),
              BottomNavigationBarItem(
                // activeIcon: null,
                icon: Icon(null),
                tooltip: '',
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/pairingIcon3.png' , height: 30, width: 55,),
                tooltip: 'Pairing',
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/settingIcon.png' , height: 30, width: 55,),
                tooltip: 'Setting',
                label: '',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        tooltip: 'Search',
        elevation: 7,
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Image(
                   image: AssetImage('assets/walletIcon5.png')
                  ),
        ),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
    );
  }
}
