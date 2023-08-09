import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/socket/sockets_methods.dart';
import 'package:tic_tac_toe/widgets/score_board.dart';
import 'package:tic_tac_toe/widgets/waiting_lobby.dart';

import '../widgets/tictactoe_board.dart';

class GameScreen extends StatefulWidget {
  static String routeame = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketmethods = SocketMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketmethods.updateRoomListener(context);
    _socketmethods.updatePlayersStateListener(context);
    _socketmethods.pointIncreaseListener(context);
    _socketmethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomdataProvider roomdataProvider = Provider.of<RoomdataProvider>(context);
    return Scaffold(
      body: roomdataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : const SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [ScoreBoard(), TicTacToeBoard()],
                ),
              ),
            ),
    );
  }
}
