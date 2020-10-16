import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'food_list.dart';





class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Future.delayed(
      Duration(seconds: 3),
      (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>FoodList(),),);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(
                          
                          child: Image.asset('images/Untitled-trr.png',
                          height: 300,
                          width: 300,
                          ),
                        ),

                      ),
                      // Padding(padding: EdgeInsets.only(top:1.0),),
                      // Text("متجر ضوء", style: TextStyle(color: Color(0xfff8d008)),)
                    ],
                  ),
                ),
              
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                         CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text('الشركة السودانية لتوزيع الكهرباء المحدودة',
                      style:GoogleFonts.cairo(
                      textStyle: TextStyle(color: Colors.red,fontSize: 10, ),
                      )

                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}