import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final x;
  final y;
  final width;
  final thisIsPlayer;

  MyBrick ({this.x, this.y, this.width, this.thisIsPlayer});
  
  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment((2*x+width)/(2-width),y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisIsPlayer? Colors.blue[300] : Colors.red[400],
          height: 20,
          width: MediaQuery.of(context).size.width * width/2,
        )
      ),
    );
  }
}
