import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/screen/account.dart';


class PairingsScreen extends StatefulWidget {
  const PairingsScreen({ Key? key }) : super(key: key);

  @override
  State<PairingsScreen> createState() => _PairingsScreenState();
}

class _PairingsScreenState extends State<PairingsScreen> {
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
      // appBar: AppBar(
      //   title: Text("Connect Wallet"),
      // ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              const GradientText(
                      'Pairings',
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
      
              const SizedBox(
                height: 15,
              ),
      
              Container(
                color: Color.fromARGB(255, 165, 165, 165),
                height: 1,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
      
              const SizedBox(
                height: 30,
              ),
      
      
            ],
          ),
        ),
      ),
    

    );
    
  }
}