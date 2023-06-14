import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../styles/init_style.dart';
class LoadImage extends StatefulWidget {
  String url;
  double? width;
  double? height;
  BoxFit fit;
  Alignment alignment;
  bool ans;
  bool bangtin;
  Function()? ontap;
  LoadImage({
    this.ans = true,
    required this.url,
    this.height ,
    this.width ,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.bangtin=false,
    this.ontap
  });

  @override
  _LoadImageState createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

      return InkWell(
        onTap: widget.ontap,
        child: Image.network(
        widget.url,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
        alignment: widget.alignment,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator(
                color: ColorApp.main,
                strokeWidth: 2,
              )
                  : CupertinoActivityIndicator(),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return
            Container(
              width: widget.width,
              height: widget.height,
              color: Colors.white,
              child: Center(
                child: Image.network(
                  'https://www.ncenet.com/wp-content/uploads/2020/04/no-image-png-2.png',
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                ),
              ),
            );

        },
    ),
      );

  }
}
