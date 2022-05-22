// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:testing_app/screen/account.dart';


class WalletConnectScreen extends StatefulWidget {
  const WalletConnectScreen({ Key? key }) : super(key: key);

  @override
  State<WalletConnectScreen> createState() => _WalletConnectScreenState();
}

class _WalletConnectScreenState extends State<WalletConnectScreen> {
  final TextEditingController _controllerCoinAddress = TextEditingController();
  bool isShowQr = false;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;

  // Get battery level.
  String _batteryLevel = 'battery level.';
  static const platform = MethodChannel('samples.flutter.dev/battery');
  

@override
void initState(){
  super.initState();  
  _getBatteryLevel();
}

//~~~~~~~~~~~~~~~~~~~~~~~~ TESTING METHOD CHANNEL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
  Future getBatteryLevel() async{
    final arguments = {'name':'Sarah Abs'};
    final String newBatteryLevel = 
           await walletChannel.invokeMethod('getBatteryLevel', arguments);

    setState(() => batteryLevel = '$newBatteryLevel');
  }


Future<void> _getDocuments() async {
  MethodChannel _methodChannel = MethodChannel('flutter/MethodChannelDemo');
    List<dynamic> documentList=[""];
    try {
      documentList = await _methodChannel.invokeMethod("Documents");
    } on PlatformException catch(e){
      print("exceptiong");
    }
    documentList.forEach((document) {
      print("Document: $document");  // seach in Logcat "Document" 
    });
  }
  
  _getBatteryLevel() async{
    var temp = await StartService().getBatteryLevel;
    setState(() {
      battery = temp;
    });
  }
  */
  
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

// ~~~~~~~~~~~~~~~~~~~~~~~~ TESTING METHOD CHANNEL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

  Widget buildQrView(BuildContext context) => QRView(
     key: qrKey,

     onQRViewCreated: (QRViewController qrViewController){
       this.qrViewController = qrViewController;
       qrViewController.scannedDataStream.listen((val) { 
         print('Hendie - ${val.code}');
       });
     },

     overlay: QrScannerOverlayShape(
       borderColor: Theme.of(context).accentColor,
       borderRadius: 10,
       borderLength: 20,
       borderWidth: 10,
       cutOutSize: MediaQuery.of(context).size.width * 0.8 ,
     ),
    );

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController?.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController?.resumeCamera();
    }
  }

  Widget buttonScanShow(String text){
    return Container(
                width: 250,
                height: 44.0,
                decoration: BoxDecoration(
                                gradient: LinearGradient(
                                              colors: [
                                                  Color.fromARGB(240, 124, 67, 240),
                                                  Color.fromARGB(255, 41, 108, 243),
                                                ]
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              ),
                child: ElevatedButton(
                  onPressed: () {
                                 setState(() {
                                  if(text == 'Scan QR Code'){
                                      if(isShowQr == false){
                                          isShowQr = true;
                                      }else{
                                          isShowQr = false;
                                      }
                                   }else{
                                     // hendie - disini
                                    //  getBatteryLevel();
                                    //  _getDocuments();
                                   }
                               
                                });
                            
                              },
                  style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
                  child: Text('$text'),
                ),
              );
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    isShowQr = false;
    super.dispose();
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
                              'WalletConnect',
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
                      
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              child: Center(
                                child: Container(
                                  alignment: Alignment.center,
              
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                  
                                  
                                      Container(
                                        width: 150,
                                        height: 200,
                                        child: (isShowQr == true) ?  buildQrView(context) :    
                                            Image(
                                              image: AssetImage('assets/barcode.png'),
                                              width: 150,
                                            ),
                                        // child: buildQrView(context),
                                        ),
                                                
                                        SizedBox(
                                            height: 25,
                                          ),
                                                
                                       buttonScanShow('Scan QR Code'),
                                  
                                        SizedBox(
                                            height: 25,
                                          ),
                                  
                                        buttonScanShow('Test Method Channel'),
                                  
                                          SizedBox(
                                            height: 25,
                                          ),
                                  
                                        Text('$_batteryLevel'),         
                                      ],
                                    ),
                                  ),
              
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              
                      SizedBox(
                        height: 30,
                      ),
              
                      Center(
                        child: Text(
                          'or use walletconnect uri',
                                style:  TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF212121),
                                    fontWeight: FontWeight.w300,
                                  ),
                          )
                        ),
              
                      SizedBox(
                        height: 30,
                      ),
              
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                                controller: _controllerCoinAddress,
                                  onChanged: (text) {
                                      setState(() {
                                        
                                      });
                                    },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.grey[800]),
                                    hintText: "eg.wc:a281567bb3e44..",
                                    fillColor: Colors.white70,
                                    suffixIcon: Container(
                                                    width: 100,
                                                    height: 20.0,
                                                    margin: EdgeInsets.only(right: 5),
                                                    decoration: BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                                colors: ( _controllerCoinAddress.text.toString() == '' || _controllerCoinAddress.text == null) 
                                                                                  ?  
                                                                                    [ 
                                                                                      Color.fromARGB(255, 226, 226, 226),
                                                                                      Color.fromARGB(255, 226, 226, 226),
                                                                                    ]
                                                                                  :
                                                                            
                                                                                    [
                                                                                      Color.fromARGB(240, 124, 67, 240),
                                                                                      Color.fromARGB(255, 41, 108, 243),
                                                                                    ] 
                                                                              ),
                                                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                  ),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
                                                      child: Text(
                                                              'Connect',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: ( _controllerCoinAddress.text.toString() == '' || _controllerCoinAddress.text == null) ? Colors.black : Colors.white
                                                              ),
                                                              ),
                                                    ),
                                                  ),
                                            ),
                                ),
                            ),
                        ),

                      SizedBox(
                        height: 100,
                      ),
                  ],
                ),
              ),
            ),
          ),
        
    );
    
  }
}

// class MyViewController: UIViewController, WalletConnectClientDelegate {
    
//     override func viewDidLoad() {
//         super.viewDidLoad()
//         client.delegate = self
//     }
// }