// ignore_for_file: prefer_ _ ructors, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/screen/account.dart';


class PairingsScreen extends StatefulWidget {
    PairingsScreen({ Key? key }) : super(key: key);

  @override
  State<PairingsScreen> createState() => _PairingsScreenState();
}

class _PairingsScreenState extends State<PairingsScreen> {
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              GradientText(
                    'Pairings',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                        letterSpacing: -2.0, 
                    ),
                    gradient: LinearGradient(colors: const [
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
                width: MediaQuery.of(context).size.width * 0.95,
              ),
      
              SizedBox(
                height: 30,
              ),
                        
              Container(
                height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Image(image: AssetImage('assets/walletImage.png'),)
                      ),
                
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          
                          Text("React Wallet"),         
                            Flexible(
                              child: Container(    
                                padding:  EdgeInsets.only(right: 13.0),
                                child: Text(
                                        'walletconnect.com/',
                                        style: TextStyle(
                                            letterSpacing: -1.0, 
                                        ),
                                  ),
                              ), 
                            ),
                                  
                          ],
                        ),
                      ),  
                
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerRight,
                          // color: Colors.yellow,
                          width: 180,
                          child: Container(
                            // color: Colors.cyan,
                            width: 50,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5,top: 5, left: 5, right: 5),
                              child: RawMaterialButton(
                                onPressed: () {},
                                elevation: 2.0,
                                fillColor: Colors.red[200],
                                child: Icon(Icons.delete_forever_outlined, color: Colors.red,),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), //
                              ),
                            ),
                          ),
                        ),
                      ),

                  ],
                ),
              ),
                
                
            ],
          ),
        ),
      ),
    

    );
    
  }
}