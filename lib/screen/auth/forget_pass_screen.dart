import 'package:cs_global/screen/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/OTP/bloc_getOTP.dart';
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

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  TextEditingController phone = TextEditingController();
  final keyFormForget = GlobalKey<FormState>();
  BlocGetOTP blocGetOTP = BlocGetOTP();

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
              key: keyFormForget,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'QUÊN MẬT KHẨU',
                      style: StyleApp.textStyle500(fontSize: 24),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Nhập số điện thoại đã đăng ký',
                        style: StyleApp.textStyle500(fontSize: 16),
                      ),
                      SizedBox(height: 25,),
                      InputText1(
                        keyboardType: TextInputType.phone,
                        controller: phone,
                        label: 'Số điện thoại',
                        hasLeading: true,
                        validator: (val){
                          return ValidatorApp.checkPhone(text: val,);
                        },
                        iconPreFix: Icon(Icons.person),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          BlocListener(
                            bloc: blocGetOTP,
                            listener: (_, StateBloc state) {
                              CheckLogState.check(context,
                                  state: state,
                                  msg: state is LoadSuccess
                                      ? state.mess
                                      : 'Đã gửi OTP',
                                  success: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassStart(phone: phone.text,)));
                                  });
                            },
                            child: InkWell(
                              onTap: () {
                                if (keyFormForget.currentState!.validate()) {
                                  blocGetOTP.add(getOTP(
                                      phone: phone.text, type: 'doi_mat_khau'));
                                  // Const.showScreen(
                                  //     OTPModal(
                                  //       phone: phone.text,
                                  //     ),
                                  //     context);
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'GỬI OTP  ',
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
                              ),
                            ),
                          )
                        ],
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
