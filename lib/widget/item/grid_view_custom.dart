import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewCustom extends StatelessWidget {
  bool shrinkWrap;
  bool showFull;
  ScrollPhysics? physics;
  int itemCount;
  int? crossAxisCount;
  IndexedWidgetBuilder itemBuilder;
  double mainAxisExtent;
  double maxWight;
  double crossAxisSpacing;
  double mainAxisSpacing;
  EdgeInsetsGeometry? padding;
  ScrollController? controller;
  Axis scrollDirection;

  GridViewCustom({
    this.physics,
    this.shrinkWrap = false,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.mainAxisExtent = 100,
    this.maxWight = 150,
    this.padding,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.crossAxisCount = 2,
    this.showFull = false,
  });

  checkSize(Size size) {
    double a = size.width / maxWight;
    double b = a - a.floor();
    int count = 2;
    if (b > 0.75) {
      count = a.round();
    } else {
      count = a.floor();
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    checkSize(size);
    return itemCount!=0? GridView.builder(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount > (checkSize(size) * 2) && !showFull
          ? (checkSize(size) * 2)
          : itemCount,
      padding: padding,
      scrollDirection: scrollDirection,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: scrollDirection == Axis.horizontal
            ? crossAxisCount
            : checkSize(size),
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    ):Container();
  }
}
