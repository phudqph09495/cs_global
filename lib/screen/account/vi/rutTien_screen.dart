import 'package:cs_global/bloc/bank/model_profileWallet.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/bank/bloc_rutTien.dart';
import '../../../bloc/bank/bloc_walletProfile.dart';
import '../../../bloc/event_bloc.dart';
import '../../../bloc/state_bloc.dart';
import '../../../config/const.dart';
import '../../../styles/init_style.dart';
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
            });
          },
          child: InkWell(
            onTap: () {
              if (money.text != '') {
                blocRutTien.add(napTien(
                  price: int.parse(money.text.replaceAll('.', '')),
                ));
              } else if (money.text == '') {
                CustomToast.showToast(
                    context: context,
                    msg: 'Bạn phải nhập số tiền cần rút',
                    gravity: ToastGravity.BOTTOM,
                    duration: 2);
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
                      controller: money,
                      colorShadow: Colors.transparent,
                      label: 'Nhập số tiền cần rút',
                      inputformater: [ThousandsSeparatorInputFormatter()],
                    )
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
