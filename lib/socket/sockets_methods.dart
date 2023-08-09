import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/socket/socketclient.dart';
import 'package:tic_tac_toe/utils/utils.dart';

import '../utils/games_methods.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {'nickname': nickname});
    }
  }

  void createRoomSuccessListner(BuildContext context) {
    _socketClient.on(
        'createRoomSuccess',
        (room) => {
              Provider.of<RoomdataProvider>(context, listen: false)
                  .updatRoomData(room),
              Navigator.pushNamed(context, GameScreen.routeame)
            });
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == "") {
      _socketClient.emit('tap', {'index': index, 'roomId': roomId});
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {'nickname': nickname, 'roomId': roomId});
    }
  }

  void joinRoomSuccessListner(BuildContext context) {
    _socketClient.on(
        'joinRoomSuccess',
        (room) => {
              Provider.of<RoomdataProvider>(context, listen: false)
                  .updatRoomData(room),
              Navigator.pushNamed(context, GameScreen.routeame)
            });
  }

  void errorOccuredListner(BuildContext context) {
    _socketClient.on('errorOccured', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomdataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomdataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomdataProvider>(context, listen: false).updatRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomdataProvider roomdataProvider =
          Provider.of<RoomdataProvider>(context, listen: false);
      roomdataProvider.updateDisplayElements(data['index'], data['choice']);
      roomdataProvider.updatRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomdataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      cleardatabase(context);
      endgameDialog(context, '${playerData['nickname']} won the game!',playerData['socketID']);
      // Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  void cleardatabase(BuildContext context) {
    var roomDataProvider =
        Provider.of<RoomdataProvider>(context, listen: false);
    _socketClient.emit('clear', {'roomId': roomDataProvider.roomData['_id']});
  }
}
