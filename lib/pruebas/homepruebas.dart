//import 'package:Selio/devzone/firestore.dart';
import 'dart:convert';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:juego1/pruebas/bola2.dart';
import 'package:juego1/pruebas/joystick.dart';
import 'package:juego1/navehorizontal.dart';
import 'package:juego1/pruebas/particles.dart';
import 'package:juego1/pruebas/saveearth.dart';
import 'package:juego1/pruebas/girl.dart';
import 'dart:ui' as ui;
import 'package:juego1/pruebas/home.dart';
import 'package:juego1/pruebas/saveearth2.dart';
//import 'package:camera/camera.dart';

class Homepruebas extends StatefulWidget {
  Homepruebas({Key? key}) : super(key: key);

  @override
  _HomepruebasState createState() => new _HomepruebasState();
}


class _HomepruebasState extends State<Homepruebas> {

  @override
  Widget build(BuildContext context) {

    return
      new Scaffold(
        //    backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text ("Pruebas",style: new TextStyle(fontSize: 25.0,)),


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

                    child: Text('Bola 1',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: MyGame(),
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

                    child: Text('Bola 2',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: Bola2(),
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

                    child: Text('Girl',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: GirlGame(),
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

                    child: Text('Salva la tierra',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: FreeFall(),
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

                    child: Text('Salva la tierra 2',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: salvarTierra(),
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

                    child: Text('Joystick',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: JoystickExample(),
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

                    child: Text('Particles',style: new TextStyle(fontSize: 20.0,color:Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameWidget(
                              game: ParticlesExample(),
                            )),
                      );

                    },
                  )),









            ],
          ),
        ),

      );
  }


}