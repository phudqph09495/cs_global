import 'package:cs_global/screen/auth/sign_up_screen.dart';
import 'package:cs_global/screen/auth/signup_modal.dart';
import 'package:cs_global/widget/item/button.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/item/input/text_filed2.dart';
import 'check_code_screen.dart';
import 'login_modal.dart';
import 'login_screen.dart';



class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                Image.asset('assets/images/logo.png'),
                Button1(
                  ontap: () {
                   // Const.showScreen(Login(),context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                  colorButton: ColorApp.whiteF7,
                  textColor: Colors.green,
                  textButton: 'ĐĂNG NHẬP',
                  radius: 20,
                  border: Border.all(color: Colors.green),
                ),
                SizedBox(
                  height: 10,
                ),
                Button1(
                  ontap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsPadding: EdgeInsets.zero,
                            titlePadding: EdgeInsets.zero,
                            insetPadding: EdgeInsets.symmetric(horizontal: 15),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide())),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Image.asset('assets/images/splash.png'),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide())),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            actions: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckCodeScreen()));

                                },
                                child: Container(
                                    width: double.infinity,
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Đồng ý',
                                        textAlign: TextAlign.center,
                                        style: StyleApp.textStyle500(
                                            color: Colors.white),
                                      ),
                                    )),
                              )
                            ],
                            content: Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Chào mừng bạn đến với ',
                                      style: StyleApp.textStyle500(),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'CS Global!',
                                            style: StyleApp.textStyle500(
                                                color: Colors.green)),
                                        TextSpan(
                                            text:
                                                'Chúng tôi rất coi trọng quyền riêng tư và bảo vệ thông tin cá nhận của bạn. Trước khi sử dụng dịch vụ của ',
                                            style: StyleApp.textStyle500()),
                                        TextSpan(
                                            text: 'CS Global!',
                                            style: StyleApp.textStyle500(
                                                color: Colors.green)),
                                        TextSpan(
                                            text:
                                                ' App, vui lòng đọc kỹ các điều khoản của '),
                                        TextSpan(
                                            text: 'CS Global!',
                                            style: StyleApp.textStyle500(
                                                color: Colors.green)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Quy định sử dụng chung',
                                    style: StyleApp.textStyle500(
                                        decoration: TextDecoration.underline,
                                        color: ColorApp.blue00),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Chính sách bảo mật',
                                    style: StyleApp.textStyle500(
                                        decoration: TextDecoration.underline,
                                        color: ColorApp.blue00),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Quy chế hoạt động',
                                    style: StyleApp.textStyle500(
                                        decoration: TextDecoration.underline,
                                        color: ColorApp.blue00),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Giải quyết tranh chấp',
                                    style: StyleApp.textStyle500(
                                        decoration: TextDecoration.underline,
                                        color: ColorApp.blue00),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Bạn đồng ý và chấp nhận tất cả các điều khoản trước khi bắt đầu sử dụng các dịch vụ của chúng tối',
                                    style: StyleApp.textStyle500(),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  colorButton: Colors.green,
                  textColor: ColorApp.whiteF7,
                  textButton: 'ĐĂNG KÝ',
                  radius: 20,
                ),
              ],
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}



