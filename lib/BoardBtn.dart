import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// "" , "x" , "o"
typedef boardBtnClick = void Function(int);
class BoardBtn extends StatelessWidget {
  String symbol;
  boardBtnClick onClick;
  int index;
  BoardBtn({required this.symbol,required this.onClick,required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          onTap: (){
            // change board btn symbol -> x : o
            onClick(index);
          },
          child: Container(
              alignment: Alignment.center,
              child: symbol.isEmpty
                  ?null
                  :SvgPicture.asset(symbol=="x"
                  ?"assets/images/x.svg"
                  :"assets/images/o.svg")),
        )
    );
  }
}
