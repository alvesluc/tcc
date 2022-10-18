import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/item.dart';

class Cell extends StatefulWidget {
  final Item item;

  const Cell({Key? key, required this.item}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CellState createState() {
    return _CellState();
  }
}

class _CellState extends State<Cell> with TickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    SchedulerBinding.instance.addPostFrameCallback((_) => startAnimation());
  }

  void startAnimation() {
    rotationController.repeat(
      min: 0.0,
      max: 1.0,
      period: const Duration(milliseconds: 5000),
    );
  }

  static String getImage(index) {
    var url = 'assets/images/${index % 20}.jpeg';
    return url;
  }

  @override
  void dispose() {
    rotationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: widget.item.color,
      child: Row(
        children: <Widget>[
          Image.asset(
            getImage(widget.item.index),
            height: 100.0,
            width: 100.0,
            cacheHeight: 100,
            cacheWidth: 100,
            fit: BoxFit.fill,
          ),
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
            child: Image.asset(
              getImage(widget.item.index),
              height: 100.0,
              width: 100.0,
              fit: BoxFit.fill,
              cacheHeight: 100,
              cacheWidth: 100,
            ),
          ),
          Center(
            child: Text(
              widget.item.index.toString(),
              key: ValueKey('item_${widget.item.index}_text'),
            ),
          ),
        ],
      ),
    );
  }
}
