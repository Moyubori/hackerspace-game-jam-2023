import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

class DungeonBuilder {

  static double tileSize = 45;

  static const String wallBottom = 'tile/wall_bottom.png';
  static const String wall = 'tile/wall.png';
  static const String wallTop = 'tile/wall_top.png';
  static const String wallLeft = 'tile/wall_left.png';
  static const String wallBottomLeft = 'tile/wall_bottom_left.png';
  static const String wallRight = 'tile/wall_right.png';
  static const String floor_1 = 'tile/floor_1.png';
  static const String floor_2 = 'tile/floor_2.png';
  static const String floor_3 = 'tile/floor_3.png';
  static const String floor_4 = 'tile/floor_4.png';

  WorldMap build(List<List<int>> schema) {
    List<TileModel> tiles = [];

    for (int y = 0; y < schema.length; y++) {
      List<int> column = schema[y];
      for (int x = 0; x < column.length; x++) {
        tiles.add(column[x] == 0 ? _buildWall(x, y) : _buildFloor(x, y));
      }
    }

    return WorldMap(tiles);
  }

  Future<WorldMap> buildFromLevelFile(String levelFilename) async {
    List<TileModel> tiles = [];

//     AssetImage provider = const AssetImage('assets/levels/sampleLevel.png');
//
//     // 2. get [ui.Image] by [ImageProvider]
//     ImageStream stream = provider.resolve(ImageConfiguration.empty);
//     Completer completer = Completer<ui.Image>();
//     ImageStreamListener listener = ImageStreamListener((frame, sync) {
//       ui.Image image = frame.image;
//       completer.complete(image);
//       stream.removeListener(listener);
//     });
//     stream.addListener(listener);
//
// // 3. get rgba array/list by [ui.Image]
//     ui.Image loadedImage = await completer.future;
//     ByteData? byteData = await loadedImage.toByteData();

    ByteData byteData = await rootBundle.load('assets/levels/sampleLevel.png');
    img.Image? levelData = img.decodeImage(byteData.buffer.asUint8List());

    // img.Image? levelData = await img.decodeImageFile('assets/levels/sampleLevel.png');
    // assert(levelData != null, );
    for (int x = 0; x < levelData!.width; x++) {
      for (int y = 0; y < levelData!.height; y++) {
        img.Pixel pixel = levelData.getPixel(x, y);
        if (pixel.r == Colors.black.red && pixel.g == Colors.black.green && pixel.b == Colors.black.blue) {
          tiles.add(_buildFloor(x, y));
        } else {
          tiles.add(_buildWall(x, y));
        }
      }
    }
    
    return WorldMap(tiles);
  }

  static TileModel _buildFloor(int x, int y) => TileModel(
    sprite: TileModelSprite(path: randomFloor()),
    x: x.toDouble(),
    y: y.toDouble(),
    width: tileSize,
    height: tileSize,
  );

  static TileModel _buildWall(int x, int y) => TileModel(
    sprite: TileModelSprite(path: wall),
    x: x.toDouble(),
    y: y.toDouble(),
    collisions: [CollisionArea.rectangle(size: Vector2(tileSize, tileSize))],
    width: tileSize,
    height: tileSize,
  );

  static String randomFloor() {
    int p = Random().nextInt(6);
    switch (p) {
      case 0:
        return floor_1;
      case 1:
        return floor_2;
      case 2:
        return floor_3;
      case 3:
        return floor_4;
      case 4:
        return floor_3;
      case 5:
        return floor_4;
      default:
        return floor_1;
    }
  }
}