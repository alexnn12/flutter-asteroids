//import 'package:Selio/devzone/firestore.dart';
import 'dart:convert';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:juego1/corredor/juego.dart';
import 'package:juego1/pruebas/bola2.dart';
import 'package:juego1/pruebas/homepruebas.dart';
import 'package:juego1/pruebas/joystick.dart';
import 'package:juego1/navehorizontal.dart';
import 'package:juego1/pruebas/particles.dart';
import 'package:juego1/pruebas/saveearth.dart';
import 'package:juego1/pruebas/girl.dart';
import 'dart:ui' as ui;
import 'package:juego1/pruebas/home.dart';
import 'package:juego1/pruebas/saveearth2.dart';
//import 'package:camera/camera.dart';

class JuegoSelector extends StatefulWidget {
  JuegoSelector({Key? key}) : super(key: key);

  @override
  _JuegoSelectorState createState() => new _JuegoSelectorState();
}


class _JuegoSelectorState extends State<JuegoSelector> {

  @override
  Widget build(BuildContext context) {

    return
      new Scaffold(
        //    backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text ("Juegitos",style: new TextStyle(fontSize: 25.0,)),
          //ad a logo in the middle
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0.0,



        ),



        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[


              Container(height: 20,),
              Container(
                  width: MediaQuery.of(context).size.width*.80,
                  height: 60,
                  padding: const EdgeInsets.only(),
                  child: new ElevatedButton(

                    //    textColor: Colors.white,

                    child: Text('Asteroides',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: NaveHorizontal(),
                            )),
                      );


                    },
                  )),
              Container(height: 20,),
              Container(
                  width: MediaQuery.of(context).size.width*.80,
                  height: 60,
                  padding: const EdgeInsets.only(),
                  child: new ElevatedButton(

                    //    textColor: Colors.white,

                    child: Text('Corredor',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: Corredor(),
                            )),
                      );


                    },
                  )),
              Container(height: 20,),
              Container(
                  width: MediaQuery.of(context).size.width*.80,
                  height: 60,
                  padding: const EdgeInsets.only(),
                  child: new ElevatedButton(

                    //    textColor: Colors.white,

                    child: Text('Pruebas',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Homepruebas()),
                      );

                    },
                  )),










            ],
          ),
        ),

      );
  }


}