import 'package:cs_global/widget/item/input/text_filed2.dart';
import 'package:flutter/material.dart';

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
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            if(key.currentState!.validate()){}
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
    );
  }
}
