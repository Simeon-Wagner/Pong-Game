import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget{

  //currently only itemOnScreen has a use
  final x;
  final y;
  final symbol;
  final itemOnScreen;

  Item({required this.itemOnScreen, this.x,this.y,this.symbol});
  @override
  Widget build(BuildContext context) {
    return itemOnScreen? Container(
      child: Center(
        child:Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.deepPurpleAccent,
                    CupertinoColors.systemPurple,
                    Colors.pink,
                  ]
              ),
              shape: BoxShape.circle
          ),
          child:  Text(
            "$symbol",
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            // style: positionTextStyle,
          ),
        )
      )
    ): Container();
  }

}