import 'package:cs_global/bloc/auth/bloc_login.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/screen/auth/signup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/path/share_pref_path.dart';
import '../../home.dart';
import '../../model/model_login.dart';
import '../../styles/init_style.dart';
import '../../validator.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/input/text_filed2.dart';
import 'forgetPass_modal.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  BlocLogin blocLogin = BlocLogin();
  final keyForm1 = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: keyForm1,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ĐĂNG NHẬP',
                      style: StyleApp.textStyle500(fontSize: 16),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        InputText1(
                          controller: phone,
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
                          controller: pass,
                          label: 'Mật Khẩu',
                          iconData: Icons.lock,
                          hasLeading: true,
                          obscureText: true,
                          hasPass: true,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            InkWell(
                              onTap: () {
                                Const.showScreen(ForgetModal(), context);
                              },
                              child: Text(
                                'Quên mật khẩu',
                                style: StyleApp.textStyle500(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
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
                                  if (keyForm1.currentState!.validate()) {
                                    blocLogin.add(LoginApp(
                                        userName: phone.text,
                                        password: pass.text));
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'ĐĂNG NHẬP  ',
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
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Hoặc đăng nhập',
                            style: StyleApp.textStyle500(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    'assets/svg/gmail.svg',
                                    height: 20,
                                  ),
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      'assets/svg/face.svg',
                                      height: 25,
                                    ),
                                  ))
                            ],
                          ),
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
                                                    Navigator.pop(context);
                                                    Const.showScreen(
                                                        SignUp(), context);
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
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
