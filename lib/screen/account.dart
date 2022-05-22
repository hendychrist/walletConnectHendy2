// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hovering/hovering.dart';
import 'package:testing_app/model/item_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({ Key? key }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String dropdownValue = 'Account 1';
  bool isCopied = false;
  var showLoading = false;

  final List<ItemModel> list1 = [
    ItemModel(coinName: "Ethereum", coinAddress: "0x8796eA4A6b9857263ad3aBa971A17903B5825741", coinImage: AssetImage('assets/ethImage.png')),
    ItemModel(coinName: "Avalanche C-Chain", coinAddress: "0x8796eA4A6b9857263ad3aBa971A17903B5825741", coinImage: AssetImage('assets/avaImage.png')),
    ItemModel(coinName: "Polygon", coinAddress: "0x8796eA4A6b9857263ad3aBa971A17903B5825741", coinImage: AssetImage('assets/polygonImage.png')),
    ItemModel(coinName: "Cosmos Hub", coinAddress: "cosmos19zcyu9k322k3crgrp9q3a9vpnhrufh5f3s83hz", coinImage: AssetImage('assets/cosmosImage.png')),
    ItemModel(coinName: "Solana", coinAddress: "5ByvxhwNFpuDn6Jj1G7GKRqXbviWEV4S8qy8EY1dGneG", coinImage: AssetImage('assets/solanaImage.png')),
  ];

  final List<ItemModel> list2 = [
    ItemModel(coinName: "Ethereum", coinAddress: "0x03628192918c1f638B795b55c50D9e6542CEA38c", coinImage: AssetImage('assets/ethImage.png')),
    ItemModel(coinName: "Avalanche C-Chain", coinAddress: "0x03628192918c1f638B795b55c50D9e6542CEA38c", coinImage: AssetImage('assets/avaImage.png')),
    ItemModel(coinName: "Polygon", coinAddress: "0x03628192918c1f638B795b55c50D9e6542CEA38c", coinImage: AssetImage('assets/polygonImage.png')),
    ItemModel(coinName: "Cosmos Hub", coinAddress: "cosmos1gamgrueffeh8m9yd7wsg20sutw9w68mnt2vfvu", coinImage: AssetImage('assets/cosmosImage.png')),
    ItemModel(coinName: "Solana", coinAddress: "DrEJrPKTMB6mdkyNueqSFzL746LghW8Unyr9LsK3H3XU", coinImage: AssetImage('assets/solanaImage.png')),
  ];

  //ADDED
  var colors = [
    Color.fromRGBO(236, 183, 188, 0.8),
    Color.fromRGBO(197, 202, 239, 0.8),
    Color.fromRGBO(206, 183, 236, 0.8),
    Color.fromRGBO(200, 200, 212, 0.8),
    Color.fromRGBO(183, 241, 218, 0.8),
  ];

  void refresh(){
    setState(() {
      showLoading = !showLoading;
    });
    Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showLoading = !showLoading;
          });
        }
      });
  }

  Widget myCopiedWidget(){
      return Container(
          margin: EdgeInsets.only(right: 10),
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Text('Copied')
            ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        );
  }
   
  Widget myIconButton() {
      if (!showLoading) {
        return Container();
      } else {
        return myCopiedWidget();
      }
  }

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
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
      
                      const GradientText(
                      'Accounts',
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
      
                      DecoratedBox(
                          decoration: const ShapeDecoration(
                            color:Color.fromARGB(255, 226, 226, 226),
                            shape:  RoundedRectangleBorder(
                              side:  BorderSide(width: 2.0, style: BorderStyle.solid, color:Color.fromARGB(255, 194, 194, 194),),
                              borderRadius:  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                      
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white,),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                        
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['Account 1', 'Account 2'].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  onTap: (){
                                    setState(() {
                                       dropdownValue = value;
                                       debugPrint('hendie - dropdownValue : $dropdownValue');
                                    });
                                   
                                  },
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                        ),
                      ),
      
                ],
              
              ),
      
              const SizedBox(
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
                'Mainnets',
                style: TextStyle(
                  color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -2.0, 
                        ),
          
              ),
      
              Expanded(
                child: ListView.builder(
                  itemCount: (dropdownValue == "Account 1") ? list1.length : list2.length,
                  itemBuilder: (context, index){
                    final item = (dropdownValue == "Account 1") ? list1[index] : list2[index];
                    return ListContainer(
                      coinSubName: item.coinName,
                      coinSubAddress: item.coinAddress,
                      coinSubImage: item.coinImage,
                      warna: colors[index],
                      onSetState: refresh,
                      iconButton: myIconButton(),
                    );
                  }
                ),
              ),
      
            ],
          ),
        ),
      ),
    
    
    );
  }
}


class ListContainer extends StatelessWidget {
  final String coinSubName;
  final String coinSubAddress;
  final AssetImage coinSubImage;
  final Color warna;
  final void Function() onSetState;
  final Widget iconButton;

  ListContainer({required this.onSetState,required this.coinSubName, required this.coinSubAddress, required this.coinSubImage, required this.warna, required this.iconButton});
  final _key = GlobalKey<ScaffoldState>();


  Widget copyWidget(String alamatCoin){
    return InkWell(
      onTap: (){
        onSetState();
        Clipboard.setData(ClipboardData(text: "$alamatCoin"));
      },
      child: Container(
                  width: 30,
                  height: 30,
                    child: Icon(
                              Icons.copy, 
                              color: Colors.white,
                              size: 20,
                            ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Color.fromARGB(255, 184, 184, 184),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(227, 226, 225, 0.4), spreadRadius: 3),
                      ],
                    ),
                  ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 70,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: warna,
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

            Container(
              margin: EdgeInsets.all(10),
              child: Image(image: coinSubImage,)
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      
                  Text(
                    "$coinSubName",
                    style:  TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Roboto',
                            color: Color(0xFF212121),
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.0, 
                          ),
                    ),
                      
                  Flexible(
                    child: Container(
                      padding:  EdgeInsets.only(right: 13.0),
                      child: Text(
                              coinSubAddress,
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

            iconButton,

            Flexible(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10),
                child: copyWidget(coinSubAddress),
              ),
            ),

        ],
      ),
    );

  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
