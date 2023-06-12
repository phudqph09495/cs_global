
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/input/text_filed2.dart';
import 'login_modal.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'ĐĂNG KÝ',
                style: StyleApp.textStyle500(fontSize: 16),
              ),
            ),

            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                InputText1(
                  label: 'Số điện thoại/Email',
                  hasLeading: true,
                  iconPreFix: Icon(Icons.person),
                ),
                SizedBox(
                  height: 10,
                ),
                InputText2(
                  label: 'Mật Khẩu',
                  iconData: Icons.lock,
                  hasLeading: true,
                  obscureText: true,
                  hasPass: true,
                ),
                SizedBox(
                  height: 10,
                ),
                InputText2(
                  label: 'Nhập lại mật khẩu',
                  iconData: Icons.lock,
                  hasLeading: true,
                  obscureText: true,
                  hasPass: true,
                ),
                SizedBox(
                  height: 10,
                ),
                InputText2(
                  label: 'Mã giới thiệu',
                  iconData:     FontAwesomeIcons.rotate,
                  hasLeading: true,
                  obscureText: true,
                  hasPass: true,
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Row(
                      children: [
                        Text(
                          'ĐĂNG KÝ  ',
                          style: StyleApp.textStyle500(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Row(
                  children: [
                    Text(
                      'Bạn đã có tài khoản? ',
                      style: StyleApp.textStyle500(),
                    ),
                    InkWell(
                      onTap: (){
                        Const.showScreen(Login(),context);
                      },
                      child: Text(
                        'Đăng nhập',
                        style: StyleApp.textStyle500(
                            color: Colors.green),
                      ),
                    )
                  ],
                ),
                SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}