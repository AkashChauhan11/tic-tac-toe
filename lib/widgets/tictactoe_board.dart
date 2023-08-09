import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/socket/sockets_methods.dart';

import '../provider/room_data_provider.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();
  tapped(int index, RoomdataProvider roomdataProvider) {
    _socketMethods.tapGrid(index, roomdataProvider.roomData['_id'],
        roomdataProvider.displayElements);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomdataProvider roomdataProvider = Provider.of<RoomdataProvider>(context);

    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: AbsorbPointer(
        absorbing: roomdataProvider.roomData['turn']['socketID'] != _socketMethods.socketClient.id,
        child: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => tapped(index, roomdataProvider),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white24)),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(microseconds: 200),
                    child: Text(
                      roomdataProvider.displayElements[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100,
                          shadows: [
                            Shadow(
                                blurRadius: 40,
                                color:
                                    roomdataProvider.displayElements[index] == 'O'
                                        ? Colors.red
                                        : Colors.blue),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
