import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/item/dialog_item.dart';

class DetailNewsScreen extends StatefulWidget {
  String title;
  String dess;
  DetailNewsScreen({required this.title, required this.dess});

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ColorApp.green00,
        centerTitle: true,
        title: Text(
          widget.title,
          maxLines: 1,
          style: StyleApp.textStyle400(color: Colors.white, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: HtmlWidget(
             widget.dess,
              onTapUrl: (url)
            async{

               await Const.launchURL(url);

               return false;
            }
          ),
        ),
      ),
    );
  }
}
