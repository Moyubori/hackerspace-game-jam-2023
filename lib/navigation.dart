import 'package:hackerspace_game_jam_2023/main.dart';

void nextDungeon(int size) => navigatorKey.currentState!.popAndPushNamed('/dungeon', arguments: size);
