import 'package:flutter/material.dart';

import 'widgets/grid_fade_item.dart';
import 'widgets/grid_rotate_item.dart';
import 'widgets/grid_scale_item.dart';

class AnimatingPhotosPage extends StatefulWidget {
  AnimatingPhotosPage({Key? key}) : super(key: key);

  @override
  _AnimatingPhotosPageState createState() => _AnimatingPhotosPageState();
}

class _AnimatingPhotosPageState extends State<AnimatingPhotosPage> {
  @override
  void didChangeDependencies() {
    var height = MediaQuery.of(context).size.width / 10;
    var width = height;
    for (var index = 0; index < 10; index++) {
      precacheImage(
        Image.asset(
          GridRotateItem.getImage(index),
          height: height,
          width: width,
          cacheHeight: height.floor(),
          cacheWidth: width.floor(),
          fit: BoxFit.cover,
        ).image,
        context,
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 200,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
        ),
        itemBuilder: (context, index) {
          var animateIndex = index % 3;
          if (animateIndex == 0) {
            return GridRotateItem(index: index);
          }
          if (animateIndex == 1) {
            return GridFadeItem(index: index);
          }
          return GridScaleItem(index: index);
        },
      ),
    );
  }
}
