import 'package:cs_global/widget/item/input/text_filed2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/OTP/bloc_getOTP.dart';
import '../../bloc/auth/bloc_changePass.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/share_pref.dart';
import '../../styles/init_style.dart';
import '../../validator.dart';
import '../../widget/item/input/text_filed.dart';

class ChangePassProfile extends StatefulWidget {
  const ChangePassProfile({Key? key}) : super(key: key);

  @override
  State<ChangePassProfile> createState() => _ChangePassProfileState();
}

class _ChangePassProfileState extends State<ChangePassProfile> {
  final key = GlobalKey<FormState>();
  TextEditingController oldPass=TextEditingController();
  TextEditingController newPass=TextEditingController();
  TextEditingController rePass=TextEditingController();
  TextEditingController code=TextEditingController();
  BlocGetOTP blocGetOTP = BlocGetOTP();
  Future<String> phone()async{
    return await SharedPrefs.readString('phone');
  }

  BlocChangePass blocChangePass=BlocChangePass();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Đổi mật khẩu',
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 10,
                ),
                InputText2(
                  controller: oldPass,
                 obscureText: true,
                  hasPass: true,
                  label: 'Nhập mật khẩu cũ',
validator: (val){
  return ValidatorApp.checkNull(text: val,isTextFiled: true);
},
                ),


                SizedBox(
                  height: 10,
                ),
                InputText2(
                  obscureText: true,
                  hasPass: true,
                  label: 'Nhập mật khẩu mới',
controller: newPass,
                  validator: (val){
                    return ValidatorApp.checkPass(isSign: true,text: val,text2: rePass.text);
                  },
                ),


                SizedBox(
                  height: 10,
                ),
                InputText2(
                  obscureText: true,
                  hasPass: true,
                  label: 'Nhập lại mật khẩu mới',
controller: rePass,
                  validator: (val){
                    return ValidatorApp.checkPass(isSign: true,text: val,text2: newPass.text);
                  },
                ),
                SizedBox(
                  height: 15,
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
                            phone: await phone(), type: 'doi_mat_khau'));
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
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocListener(
          bloc: blocChangePass,
          listener: (_,StateBloc state) {
            CheckLogState.check(context, state: state,msg: state is LoadSuccess? state.mess:'Đổi mật khẩu thành công',
            success: (){
              oldPass.clear();
              newPass.clear();
              rePass.clear();
              code.clear();
            });
          },
          child: InkWell(
            onTap: (){

              if(key.currentState!.validate()){
                blocChangePass.add(changePass(currentPassword: oldPass.text,newPassword: newPass.text,rePassword: rePass.text,otp: code.text));
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorApp.green00,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('ĐỔI MẬT KHẨU',style: StyleApp.textStyle500(color: Colors.white,fontSize: 16),textAlign: TextAlign.center,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
