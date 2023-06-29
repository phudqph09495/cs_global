import 'package:cs_global/bloc/bank/model_profileWallet.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/OTP/bloc_getOTP.dart';
import '../../../bloc/bank/bloc_rutTien.dart';
import '../../../bloc/bank/bloc_walletProfile.dart';
import '../../../bloc/event_bloc.dart';
import '../../../bloc/state_bloc.dart';
import '../../../config/const.dart';
import '../../../config/share_pref.dart';
import '../../../styles/init_style.dart';
import '../../../validator.dart';
import '../../../widget/item/custom_toast.dart';
import '../../../widget/loadPage/item_loadfaild.dart';

class RutTienScreen extends StatefulWidget {
  const RutTienScreen({super.key});

  @override
  State<RutTienScreen> createState() => _RutTienScreenState();
}

class _RutTienScreenState extends State<RutTienScreen> {
  BlocProfileWallet blocProfile = BlocProfileWallet()..add(GetData());
  TextEditingController money = TextEditingController();
  BlocRutTien blocRutTien = BlocRutTien();


  final keyRut = GlobalKey<FormState>();
  TextEditingController code = TextEditingController();
  BlocGetOTP blocGetOTP = BlocGetOTP();
  Future<String> phone()async{
    return await SharedPrefs.readString('phone');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Rút tiền ',
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: BlocListener(
          bloc: blocRutTien,
          listener: (_, StateBloc state) {
            CheckLogState.check(context,
                state: state,
                msg: state is LoadSuccess
                    ? state.mess
                    : 'Gửi yêu cầu thành công',
            success: (){
              money.clear();
              code.clear();
            });
          },
          child: InkWell(
            onTap: () {
              if (keyRut.currentState!.validate()) {
                blocRutTien.add(napTien(
                  price: int.parse(money.text.replaceAll('.', ''),),code: code.text
                ));
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorApp.green00,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Xác nhận',
                  style:
                      StyleApp.textStyle700(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder(
          bloc: blocProfile,
          builder: (_, StateBloc state) {
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorApp.main,
                ),
              );
            }
            if (state is LoadFail) {
              return ItemLoadFaild(
                error: state.error,
                onTap: () {},
              );
            }
            if (state is LoadSuccess) {
              ModelProfileWallet modelProfileWallet = state.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(key: keyRut,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Số dư tài khoản',
                        style: StyleApp.textStyle600(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorApp.green),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            '${Const.convertPrice(modelProfileWallet.walletProfile!.balance)} đ',
                            textAlign: TextAlign.center,
                            style: StyleApp.textStyle600(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Số tiền cần rút',
                        style: StyleApp.textStyle600(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(
                        keyboardType: TextInputType.number,
                        colorError: ColorApp.redText,
                        controller: money,
                        validator: (val) {
                          return ValidatorApp.checkNull(
                              isTextFiled: true, text: val);
                        },
                        colorShadow: Colors.transparent,
                        label: 'Nhập số tiền cần rút',
                        inputformater: [ThousandsSeparatorInputFormatter()],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InputText1(
                        colorError: ColorApp.redText,
                        controller: code,
                        label: 'Mã OTP',
                        colorShadow: Colors.transparent,
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
                                  phone: await phone(), type: 'rut_tien'));
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
              );
            }
            return Container();
          }),
    );
  }
}
