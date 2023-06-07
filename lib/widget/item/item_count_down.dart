import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

import '../../styles/init_style.dart';

class ItemCountDown extends StatefulWidget {
  int time;
  ItemCountDown({required this.time});

  @override
  State<ItemCountDown> createState() => _ItemCountDownState();
}

class _ItemCountDownState extends State<ItemCountDown> {
  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      endTime: widget.time,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return Text(
            'ĐÃ HẾT GIỜ',
            style: StyleApp.textStyle500(color: Colors.white),
          );
        }
        return Row(
          children: [
            Text('Còn ', style: StyleApp.textStyle500(color: Colors.white,fontSize: 18)),
            (time.days != null)
                ? Row(
                  children: [
                    Container(
                        color: Colors.amber,
                        child: Text(
                          '${time.days}',
                          style: StyleApp.textStyle500(color: Colors.white,fontSize: 18),
                        )),
                    Text(
                      '  NGÀY',
                      style: StyleApp.textStyle500(color: Colors.amber,fontSize: 18),
                    ),
                  ],
                )
                : const SizedBox(),
            (time.hours != null)
                ? Row(
                  children: [
                    Container(
                        color: Colors.amber,
                        child: Text('  ${time.hours}  ',
                            style: StyleApp.textStyle500(color: Colors.white,fontSize: 18)),
                      ),Text('  GIỜ  ',
                        style: StyleApp.textStyle500(color: Colors.amber,fontSize: 18)),
                  ],
                )
                : const SizedBox(),
            (time.min != null)
                ? Row(
                  children: [
                    Container(
                        color: Colors.amber,
                        child: Text('  ${time.min}  ',
                            style: StyleApp.textStyle500(color: Colors.white,fontSize: 18)),
                      ),  Text('  PHÚT  ',
                        style: StyleApp.textStyle500(color: Colors.amber,fontSize: 18)),
                  ],
                )
                : const SizedBox(),
            (time.sec != null)
                ? Row(
                  children: [
                    Container(
                        color: Colors.amber,
                        child: Text('  ${time.sec} ',
                            style: StyleApp.textStyle500(color: Colors.white,fontSize: 18)),
                      ), Text('  GIÂY ',
                        style: StyleApp.textStyle500(color: Colors.amber,fontSize: 18)),
                  ],
                )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
