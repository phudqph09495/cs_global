import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/OTP/bloc_getOTP.dart';
import '../../bloc/auth/bloc_login.dart';
import '../../bloc/auth/bloc_register.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../home.dart';
import '../../model/model_login.dart';
import '../../styles/init_style.dart';
import '../../styles/styles.dart';
import '../../validator.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/input/text_filed2.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
 String code;
 SignUpScreen({required this.code});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  final GlobalKey _key = GlobalKey();
BlocGetOTP blocGetOTP=BlocGetOTP();
  TextEditingController rePass = TextEditingController();
  TextEditingController code = TextEditingController();
  final keyFormSignUp = GlobalKey<FormState>();
  void _showOverlay(context) async {
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: offset.dy - 80,
        left: offset.dx,
        child: _buildInfo(),
      ),
    );
    Overlay.of(context).insert(entry);
    await Future.delayed(Duration(seconds: 2));
    entry.remove();
  }

  Widget _buildInfo() {
    return Material(
      child: Container(
        width: 300,
        color: Colors.red[200],
        padding: EdgeInsets.all(8),
        child: Text(
          'Sử dụng số điện thoại Zalo của bạn để nhận thông báo',
          style: StyleApp.textStyle500(fontSize: 16),
        ),
      ),
    );
  }

  BlocRegister blocRegister = BlocRegister();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(top: 30,left: 10,child: InkWell(onTap: (){
            Navigator.pop(context);
          },child: Icon(Icons.arrow_back_ios_new))),
          Padding(
            padding: EdgeInsets.only( left: 12, right: 12),
            child: Center(
              child: Form(
                key: keyFormSignUp,
                child: SingleChildScrollView(
                  child: Column(


                    children: [
                      Text(
                        'ĐĂNG KÝ',
                        style: StyleApp.textStyle500(fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputText1(
                        controller: name,
                        label: 'Họ và tên',
                        hasLeading: true,
                        iconPreFix: Icon(Icons.person),
                        validator: (val) {
                          return ValidatorApp.checkNull(
                              isTextFiled: true, text: val);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(
                        controller: phone,
                        globalKey: _key,
                        onTap: () {
                          _showOverlay(context);
                        },
                        keyboardType: TextInputType.phone,
                        label: 'Số điện thoại',
                        hasLeading: true,
                        iconPreFix: Icon(Icons.phone),
                        validator: (val) {
                          return ValidatorApp.checkPhone(text: val);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText2(
                        controller: pass,
                        label: 'Mật Khẩu',
                        iconData: Icons.lock,
                        hasLeading: true,
                        obscureText: true,
                        hasPass: true,
                        validator: (val) {
                          return ValidatorApp.checkPass(
                              text: val, text2: rePass.text, isSign: true);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText2(
                        controller: rePass,
                        label: 'Nhập lại mật khẩu',
                        iconData: Icons.lock,
                        hasLeading: true,
                        obscureText: true,
                        hasPass: true,
                        validator: (val) {
                          return ValidatorApp.checkPass(
                              text: val, text2: pass.text, isSign: true);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(
                        controller: code,
                        label: 'Mã OTP',
                        iconPreFix: Icon(FontAwesomeIcons.key),
                        hasLeading: false,
                        Wsuffix: BlocListener(
                          bloc: blocGetOTP,
                          listener: (_, StateBloc state) {
                            CheckLogState.check(
                              context,
                              state: state,
                              msg: state is LoadSuccess
                                  ? state.mess
                                  : 'Đã gửi lại OTP',
                            );
                          },
                          child: InkWell(
                            onTap: ()async {
                              blocGetOTP.add(getOTP(
                                  phone: phone.text, type: 'dang_ky'));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                'Gửi OTP',
                                style: StyleApp.textStyle700(
                                    fontSize: 16, color: ColorApp.redText),
                              ),
                            ),
                          ),
                        ),
                        validator: (val) {
                          return ValidatorApp.checkNull(
                              isTextFiled: true, text: val);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          BlocListener(
                            bloc: blocRegister,
                            listener: (_, StateBloc state) {
                              CheckLogState.check(context,
                                  state: state,
                                  msg: 'Đăng ký thành công', success: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen()));
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                if (keyFormSignUp.currentState!.validate()) {
                                  blocRegister.add(CreateAcc(
                                      name: name.text,
                                      pass: pass.text,
                                      rePass: rePass.text,
                                      phone: phone.text,
                                      otp: code.text,
                                      code: widget.code));
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'ĐĂNG KÝ  ',
                                    style: StyleApp.textStyle500(),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
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
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  'Đăng nhập',
                                  style:
                                  StyleApp.textStyle500(color: Colors.green),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
