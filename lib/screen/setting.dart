// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/screen/account.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switchValue = false;

  Widget floatingContainer(String text){
    return  Padding(
      padding: EdgeInsets.only(left: 5),
      child: Center(
        child: Container(
                     width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '$text',
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 3,
                            height: 1.5,
                          ),
                          )),
                    ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  
                 GradientText(
                        'Setting',
                        style: TextStyle(
                         fontSize: 30.0,
                         fontWeight: FontWeight.bold,
                           letterSpacing: -2.0, 
                       ),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 122, 74, 220),
                          Color(0xff0956ef),
                          Color.fromARGB(255, 41, 108, 243),
                        ]),
                      ),
                
                 SizedBox(
                  height: 15,
                ),
                
                Container(
                  color: Color.fromARGB(255, 165, 165, 165),
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                
                SizedBox(
                  height: 30,
                ),
                
                Text(
                  'Testnets',
                  style: TextStyle(
                    color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -2.0, 
                          ),
            
                ),
                
                SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    CupertinoSwitch(
                      value: _switchValue,
                      activeColor: Colors.blue[900],
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                          debugPrint('Hendie - _switchValue  : $_switchValue');
                        });
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                              (_switchValue == true) ? 'Enabled' : 'Disabled', 
                              style: TextStyle(fontSize: 16),
                          ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Warning: mnemonics and secret keys are provided for development purposes only and should not be used elsewhere!',
                  style: TextStyle(
                    color: Color.fromRGBO(240, 149, 28, 1),
                    fontSize: 16,
                    height: 1.5 
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                  Text(
                  'EIP155 Mnemonic',
                  style: TextStyle(
                    color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -2.0, 
                          ),
            
                ),

                SizedBox(
                  height: 20,
                ),

                floatingContainer('much virtual film blur entry apology fringe panic off sight stumble fan'),

                SizedBox(
                  height: 30,
                ),

                Text(
                  'Cosmos Mnemonic',
                  style: TextStyle(
                    color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -2.0, 
                          ),
            
                ),

                SizedBox(
                  height: 20,
                ),

                floatingContainer('discover cool pass subject struggle unit virus staff skin found quantum drip'),

                SizedBox(
                  height: 30,
                ),

                Text(
                  'Solana Secret Key',
                  style: TextStyle(
                    color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -2.0, 
                          ),
            
                ),

                SizedBox(
                  height: 20,
                ),

                floatingContainer('237,101,33,241,1,39,19,153,239,216,109,110,75,138,1,14,187,179,194,5,7,237,193,37,219,180,255,213,205,214,127,243,62,62,237,89,195,205,220,39,8,137,16,243,69,229,190,239,22,32,244,6,75,68,156,47,189,198,13,84,247,20,127,157'),

                 SizedBox(
                  height: 25,
                ),

              ],
            ),
          ),
        ),
      ),
    
    );
    
  }
}