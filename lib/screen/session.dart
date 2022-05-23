// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/screen/account.dart';
import 'package:testing_app/screen/session_details.dart';
import 'package:testing_app/screen/walletConnect.dart';

class SessionsScreen extends StatefulWidget {
     SessionsScreen({ Key? key }) : super(key: key);

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {

  showConfirmationDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(isFromSession: true,);
      },
    );
   }

  Widget listContainer(){
    return InkWell(
      onTap:(){
           showConfirmationDialog(context);
         //Hendie disini
          //  Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (BuildContext context) => SessionDetailScreen()));
      },
      child: Container(
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
                            
                            Text("React App"),         
                              Flexible(
                                child: Container(    
                                  padding:  EdgeInsets.only(right: 13.0),
                                  child: Text(
                                          'react-app...onnect.com',
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
                            
                            width: 180,
                            child: Container(
                              // color: Colors.cyan,
                              width: 50,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5,top: 5, left: 5, right: 5),
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  // fillColor: Colors.red[200],
                                  child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,),
                                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), //
                                ),
                              ),
                            ),
                          ),
                        ),
    
                    ],
                  ),
                ),
    );
                
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
      // appBar: AppBar(
      //   title: Text("Connect Wallet"),
      // ),

      body: SafeArea(
        child: Padding(
          padding:    EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              GradientText(
                      'Sessions',
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
                width: MediaQuery.of(context).size.width * 0.9,
              ),
      
              SizedBox(
                height: 30,
              ),
      
              listContainer(),

              SizedBox(
                height: 20,
              ),
      
              listContainer()
      
            ],
          ),
        ),
      ),
    

    );
    
  }
}