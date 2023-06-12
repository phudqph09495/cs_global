import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../styles/init_style.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/input/text_filed2.dart';

class OTPModal extends StatefulWidget {
  const OTPModal({Key? key}) : super(key: key);

  @override
  State<OTPModal> createState() => _OTPModalState();
}

class _OTPModalState extends State<OTPModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.35,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'QUÊN MẬT KHẨU',
                    style: StyleApp.textStyle500(fontSize: 16),
                  ),
                  Text('Vui lòng nhập mã xác nhận gồm 6 chữ số đã được gửi về số điện thoại 093****857',style: StyleApp.textStyle500(),textAlign: TextAlign.center,)
                ],
              ),
            ),

            Column(
              children: [

                PinCodeTextField(cursorColor: ColorApp.blue00,enableActiveFill :true,appContext: context, length: 6, onChanged: (value){
                  print(value);
                },keyboardType: TextInputType.number, pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
inactiveFillColor: Colors.white
                  ,selectedFillColor: ColorApp.green,
                  inactiveColor: ColorApp.whiteF0,

                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Row(
                      children: [
                        Text(
                          'TIẾP TỤC  ',
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
            SizedBox()

          ],
        ),
      ),
    );
  }
}
