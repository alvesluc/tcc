import 'package:flutter/material.dart';

class GridFadeItem extends StatefulWidget {
  final int index;

  const GridFadeItem({Key? key, required this.index}) : super(key: key);

  @override
  _GridFadeItemState createState() => _GridFadeItemState();

  static getImage(index) {
    var url = 'assets/images/${index % 20}.jpeg';
    return url;
  }
}

class _GridFadeItemState extends State<GridFadeItem>
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
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
      child: Image.asset(
        GridFadeItem.getImage(widget.index),
        height: height,
        width: width,
        cacheHeight: height.floor(),
        cacheWidth: width.floor(),
        fit: BoxFit.cover,
      ),
    );
  }
}
