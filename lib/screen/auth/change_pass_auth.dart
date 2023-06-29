import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/OTP/bloc_getOTP.dart';
import '../../bloc/auth/bloc_forgetPass.dart';
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

class ChangePassStart extends StatefulWidget {
  String phone;
  ChangePassStart({required this.phone});

  @override
  State<ChangePassStart> createState() => _ChangePassStartState();
}

class _ChangePassStartState extends State<ChangePassStart> {
  TextEditingController pass = TextEditingController();

  TextEditingController rePass = TextEditingController();
  TextEditingController code = TextEditingController();
  final keyFormCPS1 = GlobalKey<FormState>();
  BlocGetOTP blocGetOTP = BlocGetOTP();
  BlocForgetPass blocForgetPass = BlocForgetPass();

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
          Positioned(
              top: 30,
              left: 10,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new))),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Center(
              child: Form(
                key: keyFormCPS1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'ĐỔI MẬT KHẨU',
                        style: StyleApp.textStyle500(fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
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
                        hasLeading: true,
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
                            onTap: () {
                              blocGetOTP.add(getOTP(
                                  phone: widget.phone, type: 'doi_mat_khau'));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                'Gửi lại',
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
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          BlocListener(
                            bloc: blocForgetPass,
                            listener: (_, StateBloc state) {
                              CheckLogState.check(context,
                                  state: state,
                                  msg: state is LoadSuccess
                                      ? state.mess
                                      : 'Đổi mật khẩu thành công', success: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                if (keyFormCPS1.currentState!.validate()) {
                                  blocForgetPass.add(changePass(
                                      otp: code.text,
                                      phone: widget.phone,
                                      newPassword: pass.text,
                                      rePassword: rePass.text));
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'ĐỔI MẬT KHẨU ',
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
