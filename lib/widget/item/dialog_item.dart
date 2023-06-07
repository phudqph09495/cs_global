import 'package:flutter/material.dart';

import '../../config/path/share_pref_path.dart';

import '../../styles/init_style.dart';

class DialogItem {
  static showMsg({
    required BuildContext context,
    required String title,
    String? titleButton,
    bool checkErr = true,
    bool login = false,
    bool logout = false,
    required String msg,
    Function()? onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: StyleApp.textStyle700(
              color: checkErr ? Colors.red : ColorApp.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
          style: StyleApp.textStyle400(),
          textAlign: TextAlign.left,
        ),
        actions: [
          onTap != null ?  TextButton(
            onPressed: onTap,
            child: Text(
              "Xác nhận",
              style: StyleApp.textStyle400(
                  color: ColorApp.blue6D),
            ),
          ) : const SizedBox(),
          login || logout
              ? TextButton(
            onPressed: () async {
              if (logout) {
                await SharePrefsKeys.removeAllKey();
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              titleButton ?? "Đăng nhập",
              style: StyleApp.textStyle400(
                  color: checkErr ? Colors.red : ColorApp.main),
            ),
          )
              : const SizedBox(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Đóng",
              style: StyleApp.textStyle400(
                  color: checkErr ? Colors.red : ColorApp.main),
            ),
          ),
        ],
      ),
    );
  }

  static showPayMent({
    required BuildContext context,
    required String title,
    required String msg,
    Function()? onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: StyleApp.textStyle700( color: ColorApp.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        content: Text(
          msg,
          style: StyleApp.textStyle400(),
          textAlign: TextAlign.left,
        ),
        actions: [
          onTap != null ?  TextButton(
            onPressed: onTap,
            child: Text(
              "Xác nhận",
              style: StyleApp.textStyle400(
                  color: ColorApp.blue6D),
            ),
          ) : const SizedBox(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Đóng",
              style: StyleApp.textStyle400(
                  color: ColorApp.main),
            ),
          ),
        ],
      ),
    );
  }

  static showLoading({
    required BuildContext context,
    String title = "Đang tải",
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 80,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black.withOpacity(0.75),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "$title...",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleApp.textStyle400(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.of(context).pop(DialogItem);
  }
}