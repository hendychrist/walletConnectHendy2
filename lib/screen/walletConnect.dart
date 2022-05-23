// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

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
  bool checkedValue = false;

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

  sessionProposal(){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to remember?'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

/*
  Widget alert(BuildContext context)  {
    return AlertDialog(
    title: Center(
            child: Text(
                    "Session Proposal"
                    )
           ),
   
    content:  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        

        Container(
          color: Colors.cyan,
          height: 70,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
      
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image(image: AssetImage('assets/ethImage.png'),)
                ),
      
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                     judul("React App"),         
                      Flexible(
                        child: Container(
                          padding:  EdgeInsets.only(right: 13.0),
                          child: Text(
                                  'https://react-app.walletconnect.com/',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      letterSpacing: -1.0, 
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

        divider(),
        SizedBox(height: 20),
         judul('Blockchains(s)'),
         subJudul('Ethereum Kovan'),
        SizedBox(height: 20),

        divider(),
        SizedBox(height: 20),
         judul('Relay Protocol'),
         subJudul('waku'),
        SizedBox(height: 20),

        divider(),
        SizedBox(height: 20),
         judul('Methods'),
         subJudul('eth_sendTransaction,eth_signTransaction,eth_sign,personal_sign, eth_signTypedData'),
        SizedBox(height: 20),

        divider(),
        SizedBox(height: 20),
         judul('Select Ethereum Kovan Accounts'),
        SizedBox(height: 20),

          CheckboxListTile(
            title: Text("title text"),
            value: checkedValue,
            onChanged: (bool? value) {
                          setState(() {
                            checkedValue = value!;
                          });
                          },
            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            activeColor: Colors.green,
            checkColor: Colors.red,
          )

      ],

    ),
    
    actions: [
      TextButton(
          child: Text("OK"),
          onPressed: () { Navigator.pop(context); },
        ),
    ],
  );
  }
  */

 showConfirmationDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(isFromSession: false,);
      },
    );
   }

  Widget buildQrView(BuildContext context) => QRView(
     key: qrKey,

     onQRViewCreated: (QRViewController qrViewController){
       this.qrViewController = qrViewController;
       qrViewController.scannedDataStream.listen((val) { 
         print('Hendie - ${val.code}');

          // Kalau codenya kebaca dan ada value maka munculkan dialog
          if(val.code != "" || val.code != null){
              qrViewController.stopCamera();
             
              setState(() {
                isShowQr = false;
              });
        
             showConfirmationDialog(context);
          }
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
                                      if(isShowQr == false){
                                          isShowQr = true;
                                      }else{
                                          isShowQr = false;
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
                      width: MediaQuery.of(context).size.width * 0.915,
                    ),
                      
                      SizedBox(
                        height: 30,
                      ),
                      
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.9,
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
                                  
                                        // buttonScanShow('Test Method Channel'),
                                  
                                          // SizedBox(
                                          //   height: 25,
                                          // ),
                                  
                                        // Text('$_batteryLevel'),         
                                        
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

class CustomDialog extends StatefulWidget {
  final bool isFromSession;

  CustomDialog({this.isFromSession = false});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<bool> _isChecked = [false, false];
  bool canUpload = false;

  List<String> _texts = [
    "0xBA68..983c0-Account1",
    "0x7Aef...d2e7c-Account2.",
  ];
  
   Widget judul(String textJudul){
    return Text(
                '$textJudul',
                style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Roboto',
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.0, 
                        ),
            );
  }

   Widget subJudul(String textSubjudul){
    return Text(
          '$textSubjudul', 
          style:TextStyle(
                        letterSpacing: -1.0, 
                    ),
        );
  }

  Widget divider(){
    return  Container(
          color: Colors.black,
          height: 1.5,
          width: MediaQuery.of(context).size.width,
          );
  }

  Widget buttonReProve(String textButton, bool isFromReject){
    return 
        InkWell(
          onTap: (){
                (canUpload == true)
                    ?
                      Navigator.pop(context)
                    :
                      Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
                           color: (isFromReject == true && isFromReject != null) ? Colors.red : (canUpload == true) ? Colors.green : Colors.grey[600]!.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
              width: 100,
              height: 50,
              alignment: Alignment.center,
              child: Text('$textButton')
            ),
        );

  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Hendie - isFromSession : ${widget.isFromSession}');

  Widget isFromSessionFlase(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      divider(),
    SizedBox(height: 20),
    judul('Blockchains(s)'),
    subJudul('Ethereum Kovan'),
    SizedBox(height: 20),

    divider(),
    SizedBox(height: 20),
    judul('Relay Protocol'),
    subJudul('waku'),
    SizedBox(height: 20),

    divider(),
    SizedBox(height: 20),
     judul('Methods'),
     subJudul('eth_sendTransaction,eth_signTransaction,eth_sign,personal_sign, eth_signTypedData'),
    SizedBox(height: 20),

    divider(),
    SizedBox(height: 20),
     judul((widget.isFromSession == true) ? 'Ehereum Kovan Accounts' : 'Select Ethereum Kovan Accounts'),
    SizedBox(height: 20),

    Container(
      // color: Colors.pink,
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _texts.length,
        itemBuilder: (_, index) {
    
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration( 
                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                         color: Colors.grey[350],
                        ),
            
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(_texts[index], textAlign: TextAlign.right,),
              value: _isChecked[index],
              onChanged: (bool? val) {
    
                setState(() {
                  _isChecked[index] = val!;
                  // canUpload = true;
    
                  if(val == true ){
                    canUpload = true;
                  }else{
                    canUpload = false;
                  }
    
                  // for (var item in _isChecked) {
                  //   if (item == false) {
                  //     canUpload = false;
                  //   }
                  // }
                });
              },
            ),
          );
        },
      ),
    ),


      ],
    );
  }


  Widget isFromSessionTrue(){
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
          divider(),
          SizedBox(height: 20),
          judul((widget.isFromSession == true) ? 'Ehereum Kovan Accounts' : 'Select Ethereum Kovan Accounts'),
          SizedBox(height: 20),

          Container(
            // color: Colors.pink,
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _texts.length,
              itemBuilder: (_, index) {
          
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration( 
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.grey[350],
                              ),
                  
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(_texts[index], textAlign: TextAlign.right,),
                    value: _isChecked[index],
                    onChanged: (bool? val) {
          
                      setState(() {
                        _isChecked[index] = val!;
                        // canUpload = true;
          
                        if(val == true ){
                          canUpload = true;
                        }else{
                          canUpload = false;
                        }
          
                        // for (var item in _isChecked) {
                        //   if (item == false) {
                        //     canUpload = false;
                        //   }
                        // }
                      });
                    },
                  ),
                );
              },
            ),
          ),

          divider(),
          SizedBox(height: 20),
          judul('Methods'),
          subJudul('eth_sendTransaction,eth_signTransaction,eth_sign,personal_sign, eth_signTypedData'),
          SizedBox(height: 20),

          divider(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            judul('Expiry'),
            subJudul('Fri May 27 2022')

            ],
          ),
          SizedBox(height: 20),
          divider(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            judul('Last Updated'),
            subJudul('Mon May 23 2022')

            ],
          ),
          SizedBox(height: 20),
          divider(),
      ],
    );
  }

    return AlertDialog(
      title: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text((widget.isFromSession == true) ? 'Session Detail' : 'Session Proposal'),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text('X')
                  ),
                ],
              ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: [
                    

    Container(
      // color: Colors.cyan,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
      
            Container(
              margin: EdgeInsets.all(10),
              child: Image(image: AssetImage('assets/walletImage.png'),)
            ),
      
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                   judul("React App"),         
                    Container(
                      padding:  EdgeInsets.only(right: 13.0),
                      child: Text(
                              'https://react-app.walletconnect.com/',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  letterSpacing: -1.0, 
                              ),
                        ),
                    ),
                          
                  ],
                ),
              ),
            ),  
      
        ],
      ),
    ),
  
     if(widget.isFromSession == false) isFromSessionFlase(),
     if(widget.isFromSession == true) isFromSessionTrue(),

          ]),
    ),



          ],
        ),
      ),
      actions: <Widget>[

        if(widget.isFromSession == false) buttonReProve("Reject", true),
        if(widget.isFromSession == false) buttonReProve("Approve", false),
         if(widget.isFromSession == true) InkWell(
            onTap: (){
                  (canUpload == true)
                      ?
                        Navigator.pop(context)
                      :
                        Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                           color: Colors.red,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                height: 50,
                alignment: Alignment.center,
                child: Text('Delete Session',style: TextStyle(color: Colors.white),)
              ),
          ),

      ],
    );
  }
}