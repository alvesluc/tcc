import 'package:flutter/material.dart';
import 'dart:math';

import 'models/item.dart';
import 'widgets/cell.dart';

class ScrollPage extends StatelessWidget {
  ScrollPage({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  final rand = Random();

  randomColor() {
    return Color((rand.nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }

  final scrollDuration = Duration(seconds: 500);

  @override
  Widget build(BuildContext context) {
    var data = generateData();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await scrollController.animateTo(
            1000.0 * (100 + 16),
            duration: scrollDuration,
            curve: Curves.linear,
          );
        },
        child: Icon(Icons.arrow_downward),
      ),
      body: Stack(
        children: <Widget>[
          ListView.separated(
            cacheExtent: 0.0,
            controller: scrollController,
            key: ValueKey('long_list'),
            separatorBuilder: (context, int) {
              return Divider();
            },
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Cell(item: data[index]);
            },
          ),
        ],
      ),
    );
  }

  List<Item> generateData() {
    var data = <Item>[];
    for (int i = 0; i < 1001; i++) {
      data.add(Item(i, randomColor()));
    }
    return data;
  }
}
