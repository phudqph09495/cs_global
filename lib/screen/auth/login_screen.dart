import 'package:cs_global/screen/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/bloc_login.dart';
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
import 'check_code_screen.dart';
import 'forget_pass_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BlocLogin blocLogin = BlocLogin();
  final keyFormLogin = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover,),
            ),
          ),
          Positioned(top: 30,left: 10,child: InkWell(onTap: (){
            Navigator.pop(context);
          },child: Icon(Icons.arrow_back_ios_new))),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: keyFormLogin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/logoDoc.png',height: MediaQuery.of(context).size.height*0.3,
                    fit: BoxFit.fitHeight,),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(
                        borderColor: Color(0xffFAFAFA),

                        colorShadow: Colors.transparent,
                        controller: phone,
                        radius: 5,
                        label: 'Số điện thoại',
                        hasLeading: true,
                        iconPreFix: Icon(Icons.person),
                        validator: (val) {
                          return ValidatorApp.checkPhone(text: val,);
                        },

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText2(
                        validator: (val) {
                          return ValidatorApp.checkPass(text: val);
                        },
                        radius: 5,
                        colorShadow: Colors.transparent,
                        controller: pass,
                        label: 'Mật Khẩu',
                        iconData: Icons.lock,
                        hasLeading: true,
                        obscureText: true,
                        hasPass: true,
                      ),

                      Column(
                        children: [

                          SizedBox(
                            height: 20,
                          ),

                          BlocListener(
                            listener: (context, StateBloc state) {
                              ModelLogin model = ModelLogin();
                              if (state is LoadSuccess) {
                                model = state.data;
                              }
                              CheckLogState.check(context,
                                  state: state, msg: 'Đăng nhập thành công',
                                  success: () async {
                                    await SharePrefsKeys.saveUserKey(model);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyHomePage()));
                                  });
                            },
                            bloc: blocLogin,
                            child: InkWell(
                              onTap: () {
                                if (keyFormLogin.currentState!.validate()) {
                                  blocLogin.add(LoginApp(
                                      userName: phone.text,
                                      password: pass.text));
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ColorApp.green00,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'ĐĂNG NHẬP  ',
                                    style: StyleApp.textStyle500(
                                        color: Colors.white
                                    ),textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassScreen()));
                                },
                                child: Text(
                                  'Quên mật khẩu',
                                  style: StyleApp.textStyle500(),
                                ),
                              ),
                              SizedBox()
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),


                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Row(
                            children: [
                              Text(
                                'Bạn chưa có tài khoản? ',
                                style: StyleApp.textStyle500(),
                              ),
                              InkWell(
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  Future.delayed(Duration(milliseconds: 200),(){
                                    showDialog(

                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            actionsPadding: EdgeInsets.zero,
                                            titlePadding: EdgeInsets.zero,
                                            insetPadding:
                                            EdgeInsets.symmetric(
                                                horizontal: 15),
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom:
                                                            BorderSide())),
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
                                                        border: Border(
                                                            bottom:
                                                            BorderSide())),
                                                  ),
                                                  flex: 1,
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckCodeScreen()));

                                                },
                                                child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                        'Đồng ý',
                                                        textAlign:
                                                        TextAlign.center,
                                                        style: StyleApp
                                                            .textStyle500(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    )),
                                              )
                                            ],
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.45,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text:
                                                      'Chào mừng bạn đến với ',
                                                      style: StyleApp
                                                          .textStyle500(),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                            'CS Global!',
                                                            style: StyleApp
                                                                .textStyle500(
                                                                color: Colors
                                                                    .green)),
                                                        TextSpan(
                                                            text:
                                                            'Chúng tôi rất coi trọng quyền riêng tư và bảo vệ thông tin cá nhận của bạn. Trước khi sử dụng dịch vụ của ',
                                                            style: StyleApp
                                                                .textStyle500()),
                                                        TextSpan(
                                                            text:
                                                            'CS Global!',
                                                            style: StyleApp
                                                                .textStyle500(
                                                                color: Colors
                                                                    .green)),
                                                        TextSpan(
                                                            text:
                                                            ' App, vui lòng đọc kỹ các điều khoản của '),
                                                        TextSpan(
                                                            text:
                                                            'CS Global!',
                                                            style: StyleApp
                                                                .textStyle500(
                                                                color: Colors
                                                                    .green)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Quy định sử dụng chung',
                                                    style:
                                                    StyleApp.textStyle500(
                                                        decoration:
                                                        TextDecoration
                                                            .underline,
                                                        color: ColorApp
                                                            .blue00),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Chính sách bảo mật',
                                                    style:
                                                    StyleApp.textStyle500(
                                                        decoration:
                                                        TextDecoration
                                                            .underline,
                                                        color: ColorApp
                                                            .blue00),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Quy chế hoạt động',
                                                    style:
                                                    StyleApp.textStyle500(
                                                        decoration:
                                                        TextDecoration
                                                            .underline,
                                                        color: ColorApp
                                                            .blue00),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Giải quyết tranh chấp',
                                                    style:
                                                    StyleApp.textStyle500(
                                                        decoration:
                                                        TextDecoration
                                                            .underline,
                                                        color: ColorApp
                                                            .blue00),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Bạn đồng ý và chấp nhận tất cả các điều khoản trước khi bắt đầu sử dụng các dịch vụ của chúng tối',
                                                    style: StyleApp
                                                        .textStyle500(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  });
                                },
                                child: Text(
                                  'Đăng Ký',
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
