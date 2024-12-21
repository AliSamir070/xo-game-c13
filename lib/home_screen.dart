import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:x_o_c13_maadi/CustomTextField.dart';
import 'package:x_o_c13_maadi/board_screen.dart';
import 'package:x_o_c13_maadi/planet.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();

  String selectedPlayer = "X";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player1Controller.addListener(() {
      setState(() {

      });
    });
    player2Controller.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff00D2FF),
              Color(0xff3A7BD5)
            ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/images/xo-image.png",
                    fit: BoxFit.cover,
                    width: double.infinity,),
                  Text("Tic-Tac-Toe",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 40
                  ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomTextField(
                    hint: "Player 1 name",
                    controller: player1Controller,
                  ),
                  SizedBox(height: 15,),
                  CustomTextField(hint: "Player 2 name",
                  controller: player2Controller,
                  ),
                  SizedBox(height: 17,),
                  Text("Pick who goes first?",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    color: Colors.white
                  ),),
                  SizedBox(height: 17,),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                selectedPlayer = "X";
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: selectedPlayer == "X"
                                      ?Colors.white
                                      :Colors.transparent
                                ),
                                child: SvgPicture.asset(  "assets/images/x.svg")),
                          )),
                      SizedBox(width: 15,),
                      Expanded(child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedPlayer = "O";
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: selectedPlayer == "O"
                                    ?Colors.white
                                    :Colors.transparent
                            ),
                            child: SvgPicture.asset("assets/images/o.svg")),
                      )),

                    ],
                  ),
                  SizedBox(height: 17,),

                  Visibility(
                    visible: player1Controller.text.isNotEmpty && player2Controller.text.isNotEmpty,
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacementNamed(BoardScreen.routeName,
                              arguments:BoardScreenArgs(
                                  player1Name: player1Controller.text,
                                  player2Name: player2Controller.text,
                                  selectedPlayer: selectedPlayer));
                        },
                        child: Text(
                          "Start Game"
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
