import 'dart:convert';
import 'dart:io';

import 'package:cs_global/bloc/auth/bloc_profile.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/config/const.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:cs_global/screen/account/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/auth/bloc_deleteAcc.dart';
import '../../../bloc/auth/bloc_updateProfile.dart';
import '../../../bloc/bank/bloc_walletProfile.dart';
import '../../../bloc/bank/model_profileWallet.dart';
import '../../../bloc/choose_image_bloc.dart';
import '../../../bloc/state_bloc.dart';
import '../../../config/path/share_pref_path.dart';
import '../../../start.dart';
import '../../../styles/init_style.dart';
import '../../../widget/item/load_image.dart';
import '../../../widget/loadPage/item_loadfaild.dart';
import '../changPass_screen.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

import '../gioithieu_screen.dart';
import '../khtk_screen.dart';
import 'acc_bank_screen.dart';

class ViCsScreen extends StatefulWidget {
  const ViCsScreen({Key? key}) : super(key: key);

  @override
  State<ViCsScreen> createState() => _ViCsScreenState();
}

class _ViCsScreenState extends State<ViCsScreen> {
  bool showMoney = true;
  bool showMoney2 = true;
  BlocProfileWallet blocProfile = BlocProfileWallet()..add(GetData());
  ChooseImageBloc chooseImageBloc = ChooseImageBloc();
  BlocUpdateProfile blocUpdateProfile = BlocUpdateProfile();
  BlocDeleteAcc blocDeleteAcc = BlocDeleteAcc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        builder: (_, StateBloc state) {
          if (state is LoadSuccess) {
            ModelProfileWallet modelProfile = state.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            height: Const.size(context).height * 0.25,
                            width: double.infinity,
                            child: LoadImage(
                              url: '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Ví CS của bạn ${modelProfile.walletProfile!.statusBank!.name}',
                                    style: StyleApp.textStyle500(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          top: 30,
                          left: 10,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('Thông tin ví CS', style: StyleApp.textStyle500()),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.account_balance_wallet_outlined),
                                    SizedBox(
                                      width: 5,
                                    ),

                                    Text(
                                      'Số tài khoản',
                                      style: StyleApp.textStyle500(),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  modelProfile.walletProfile!.bankAccount ?? '',
                                  style: StyleApp.textStyle500(),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(FontAwesomeIcons.bank),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Ngân hàng',
                                      style: StyleApp.textStyle500(),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  modelProfile.walletProfile!.bankName ?? '',
                                  style: StyleApp.textStyle500(),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.greyE6,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      'assets/images/vi.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Đổi mật khẩu ví CS',
                                      style:
                                      StyleApp.textStyle700(fontSize: 16),
                                    ),
                                  ],
                                ),
                                const FaIcon(FontAwesomeIcons.longArrowRight)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountBankScreen())).then((value) => blocProfile.add(GetData()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                                color: ColorApp.greyE6,
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        'assets/images/vi.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Thông tin định danh ví CS',
                                        style:
                                        StyleApp.textStyle700(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const FaIcon(FontAwesomeIcons.longArrowRight)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const SizedBox();
        },
        bloc: blocProfile,
      ),
    );
  }
}

class ButtonPay extends StatelessWidget {
  const ButtonPay({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Icon(
              icon,
              size: 30,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class RowInfo extends StatelessWidget {
  const RowInfo({
    super.key,
    required this.title,
    required this.score,
  });
  final String title;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          score,
          style: const TextStyle(color: Colors.green, fontSize: 16),
        )
      ],
    );
  }
}
