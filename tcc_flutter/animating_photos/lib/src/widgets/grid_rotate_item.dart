import 'package:flutter/material.dart';

class GridRotateItem extends StatefulWidget {
  final int index;

  const GridRotateItem({Key? key, required this.index}) : super(key: key);

  @override
  _GridRotateItemState createState() => _GridRotateItemState();

  static getImage(index) {
    var url = 'assets/images/${index % 20}.jpeg';
    return url;
  }
}

class _GridRotateItemState extends State<GridRotateItem>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double height;
  late double width;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 5),
    );
    animationController.repeat();
  }

  @override
  void didChangeDependencies() {
    height = MediaQuery.of(context).size.width / 10;
    width = height;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
      child: Image.asset(
        GridRotateItem.getImage(widget.index),
        height: height,
        width: width,
        cacheHeight: height.floor(),
        cacheWidth: width.floor(),
        fit: BoxFit.cover,
      ),
    );
  }
}
