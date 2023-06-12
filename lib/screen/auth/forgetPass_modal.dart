import 'package:flutter/material.dart';

import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/input/text_filed2.dart';
import 'otp_modal.dart';

class ForgetModal extends StatefulWidget {
  const ForgetModal({Key? key}) : super(key: key);

  @override
  State<ForgetModal> createState() => _ForgetModalState();
}

class _ForgetModalState extends State<ForgetModal> {
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
              child: Text(
                'QUÊN MẬT KHẨU',
                style: StyleApp.textStyle500(fontSize: 16),
              ),
            ),

            Column(
              children: [

                InputText1(
                  label: 'Số điện thoại/Email',
                  hasLeading: true,
                  iconPreFix: Icon(Icons.person),
                ),
SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    InkWell(
                      onTap: (){
                        Const.showScreen(OTPModal(), context);
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
