import 'package:cs_global/screen/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/OTP/bloc_getOTP.dart';
import '../../bloc/auth/bloc_checkCode.dart';
import '../../bloc/auth/bloc_forgetPass.dart';
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
import 'change_pass_auth.dart';

class CheckCodeScreen extends StatefulWidget {
  const CheckCodeScreen({super.key});

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  TextEditingController phone = TextEditingController();
  final keyFormCheck = GlobalKey<FormState>();
  BlocCheckCode blocGetOTP = BlocCheckCode();

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
          InkWell(onTap: (){
            Navigator.pop(context);
          },child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
            child: Icon(Icons.arrow_back_ios_new),
          )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: keyFormCheck,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'NHẬP MÃ GIỚI THIỆU',
                      style: StyleApp.textStyle500(fontSize: 24),
                    ),
                  ),
                  Column(
                    children: [

                      SizedBox(height: 25,),
                      InputText1(
                        radius: 5,
colorShadow: Colors.transparent,
                        controller: phone,
                        label: 'Mã giới thiệu',
                        hasLeading: true,
                        validator: (val){
                          return ValidatorApp.checkNull(text: val,isTextFiled: true);
                        },
                        iconPreFix: Icon(FontAwesomeIcons.rotate),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocListener(
                        bloc: blocGetOTP,
                        listener: (_, StateBloc state) {
                          CheckLogState.check(context,
                              state: state,
                              msg: state is LoadSuccess
                                  ? state.mess
                                  : 'Thành Công',
                              success: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen(code: phone.text,)));
                              });
                        },
                        child: InkWell(
                          onTap: () {

                            if (keyFormCheck.currentState!.validate()) {
                              blocGetOTP.add(GetData(param: phone.text));
                              // Const.showScreen(
                              //     OTPModal(
                              //       phone: phone.text,
                              //     ),
                              //     context);
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
                                'TIẾP THEO',
                                style: StyleApp.textStyle500(
                                    color: Colors.white
                                ),textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox()
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
