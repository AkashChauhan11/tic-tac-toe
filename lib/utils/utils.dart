import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/utils/games_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              GameMethods().clearBoard(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Play Again',
            ),
          ),
        ],
      );
    },
  );
}

void endgameDialog(BuildContext context, String text, String winner_socketID) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        content: SizedBox(
          height: 400,
          width: 400,
          child: Lottie.asset("assets/winner.json"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              GameMethods().clearBoard(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text(
              'OK',
            ),
          ),
        ],
      );
    },
  );
}
