import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/create_room.dart';
import 'package:tic_tac_toe/screens/join_room.dart';

import '../Responsive/responsive.dart';
import '../widgets/custome_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/tic-tac-toe.png",scale: 0.5),
              const SizedBox(height: 40),
        
              CustomButton(
                onTap: () => createRoom(context),
                text: 'Create Room',
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () => joinRoom(context),
                text: 'Join Room',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
