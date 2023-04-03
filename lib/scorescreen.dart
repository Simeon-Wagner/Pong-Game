import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final bool gameHasStarted;
  final bool itemCollected;
  final enemyScore;
  final playerScore;


  ScoreScreen({required this.gameHasStarted, required this.itemCollected, this.enemyScore, this.playerScore});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted ? Stack(alignment: Alignment(0,0),
    children: [
            //Score Screen
                Container(
                  alignment: Alignment(0, 0),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width / 4,
                    color: Colors.grey[700],

                  ),
                ),
                /*
                Container(
                  alignment: Alignment(0, -0.3),
                    child: Text(
                      enemyScore.toString(),
                      style: TextStyle(color:  Colors.grey[800], fontSize: 100),
                      )
                ),
                */
                Container(
                  alignment: Alignment(0, 0.3),
                    child: Text(
                    playerScore.toString(),
                    style: TextStyle(color:  Colors.grey[800], fontSize: 100),
                    )
                ),

                itemCollected? Container(
                  alignment: Alignment(0,-0.5),
                  child: Text(
                    "Item Collected, ball speed incresed!",
                    style: TextStyle(color: Colors.white),
                  ),
                ) : Container(),
    ]
    ): Container();
  }
}