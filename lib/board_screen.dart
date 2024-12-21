import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:x_o_c13_maadi/BoardBtn.dart';

class BoardScreen extends StatefulWidget {
  static const String routeName = 'board';

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<String> boardState = [
    "","","",
    "","","",
    "","",""

  ];
  int player1Score = 0;
  int player2Score = 0;
  String message = "Player 1’s Turn";
  late String selectedPlayer;
  @override
  Widget build(BuildContext context) {
    BoardScreenArgs args = ModalRoute.of(context)?.settings.arguments as BoardScreenArgs;
    selectedPlayer = args.selectedPlayer;
    playerSymbol = selectedPlayer=="X"?"x":"o";
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 15,
          ),
          body:Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(44)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("${args.player1Name} (${args.selectedPlayer})",style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                          )),
                          Text(player1Score.toString(),style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                          )),

                        ],
                      ),
                      Column(
                        children: [
                          Text("${args.player2Name} (${args.selectedPlayer=="X"?"O":"X"})",style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                          ),),
                          Text(player2Score.toString(),style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                          )),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32,),
                Text(message,style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),),
                SizedBox(height: 24,),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 22
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(44)
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              BoardBtn(symbol: boardState[0],onClick: onBoardBtnClick,index: 0,),
                              const VerticalDivider(
                                color: Colors.black,
                                width: 0,
                              ),
                              BoardBtn(symbol: boardState[1],onClick: onBoardBtnClick,index: 1,),
                              const VerticalDivider(
                                color: Colors.black,
                                width: 0,
                              ),
                              BoardBtn(symbol: boardState[2],onClick: onBoardBtnClick,index: 2,),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              BoardBtn(symbol: boardState[3],onClick: onBoardBtnClick,index: 3,),
                              const VerticalDivider(
                                color: Colors.black,
                                width: 0,
                              ),
                              BoardBtn(symbol: boardState[4],onClick: onBoardBtnClick,index: 4,),
                              const VerticalDivider(
                                color: Colors.black,
                                width: 0,
                              ),
                              BoardBtn(symbol: boardState[5],onClick: onBoardBtnClick,index: 5,),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              BoardBtn(symbol: boardState[6],onClick: onBoardBtnClick,index: 6,),
                              const VerticalDivider(
                                color: Colors.black,
                                width: 0,
                              ),
                              BoardBtn(symbol: boardState[7],onClick: onBoardBtnClick,index: 7,),
                              const VerticalDivider(
                                color: Colors.black,
                                width: 0,
                              ),
                              BoardBtn(symbol: boardState[8],onClick: onBoardBtnClick,index: 8,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  // player1: 1,3,5,7,9
  // player2: 2,4,6,8
  late String playerSymbol;
  int count = 1;
  onBoardBtnClick(int index,){
   if(boardState[index].isEmpty){
     setState(() {
       if(playerSymbol==(selectedPlayer=="X"?"x":"o")){
         boardState[index] = selectedPlayer=="X"?"x":"o";
         if(checkWinner(selectedPlayer=="X"?"x":"o")){
           player1Score+=10;
           message = "Player 1 Win";
           resetGame();
           return;
         }
         message = "Player 2’s Turn";
       }else{
         boardState[index] = selectedPlayer=="X"?"o":"x";
         if(checkWinner(selectedPlayer=="X"?"o":"x")){
           player2Score+=10;
           message = "Player 2 Win";
           resetGame();
           return;
         }
         message = "Player 1’s Turn";
       }
       if(count==9){
         message = "Draw";
         resetGame();
       }
       count++;
       playerSymbol = playerSymbol=="x"?"o":"x";
     });
   }
  }
  bool checkWinner(String symbol){
    for(int i=0;i<=6;i+=3){
      if(boardState[i]==symbol && boardState[i+1]==symbol && boardState[i+2]==symbol){
        return true;
      }
    }
    for(int i=0;i<=2;i++){
      if(boardState[i]==symbol && boardState[i+3]==symbol && boardState[i+6]==symbol){
        return true;
      }
    }
    if(boardState[0]==symbol && boardState[4]==symbol && boardState[8]==symbol){
      return true;
    }
    if(boardState[2]==symbol && boardState[4]==symbol && boardState[6]==symbol){
      return true;
    }
    return false;
  }
  resetGame(){
    Timer(Duration(
      seconds: 2
    ), () {
      boardState = [
        "","","",
        "","","",
        "","",""

      ];
      count = 1;
      message = "Player 1’s Turn";
      setState(() {

      });
    });
  }
}

class BoardScreenArgs{
  String player1Name;
  String player2Name;
  String selectedPlayer;
  BoardScreenArgs({required this.player1Name , required this.player2Name , required this.selectedPlayer});
}
