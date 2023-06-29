import 'dart:convert';
import 'dart:io';

import 'package:cs_global/bloc/auth/bloc_profile.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/config/const.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:cs_global/screen/account/profile_screen.dart';
import 'package:cs_global/screen/account/vi/rutTien_screen.dart';
import 'package:cs_global/screen/account/vi/viCS_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import '../../../widget/item/custom_toast.dart';
import '../../../widget/item/load_image.dart';
import '../../../widget/loadPage/item_loadfaild.dart';
import '../changPass_screen.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

import '../gioithieu_screen.dart';
import '../khtk_screen.dart';
import 'acc_bank_screen.dart';
import 'lichSuGD_screen.dart';
import 'nap_vi_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2), // Border width
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size:
                                      const Size.fromRadius(30), // Image radius
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      LoadImage(
                                        url:
                                            '${Const.image_host}${modelProfile.walletProfile!.avatar}',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    modelProfile.walletProfile!.name ?? '',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'ID :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        modelProfile.walletProfile!.code ?? '',
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Số dư(VNĐ) :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            showMoney2
                                                ? '${Const.convertPrice(modelProfile.walletProfile!.balance)} đ'
                                                : '*******',
                                            style: StyleApp.textStyle500(
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showMoney2 = !showMoney2;
                                                });
                                              },
                                              child: Icon(
                                                showMoney2
                                                    ? CupertinoIcons.eye_slash
                                                    : CupertinoIcons.eye,
                                                size: 14,
                                              ))
                                        ],
                                      )
                                      // Text(
                                      //   '0',
                                      //   style: TextStyle(
                                      //       color: Colors.green, fontSize: 16),
                                      // )
                                    ],
                                  ),
                                  RowInfo(
                                      title: 'Điểm kích hoạt tài khoản : ',
                                      score:
                                          '${modelProfile.walletProfile!.score}'),
                                  RowInfo(
                                      title: 'Tiền tiêu dùng : ',
                                      score:
                                          '${Const.convertPrice(modelProfile.walletProfile!.totalCost)} đ'),
                                  RowInfo(
                                      title: 'Phí quản lý tài khoản : ',
                                      score:
                                          '${Const.formatPrice(modelProfile.walletProfile!.manageFee)} đ'),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if(modelProfile
                                      .walletProfile!.statusBank!.key==false){
                                    CustomToast.showToast(
                                        context: context,
                                        msg: 'Bạn phải xác thực tài khoản ngân hàng trước',
                                        gravity: ToastGravity.BOTTOM,
                                        duration: 2);

                                  }else{
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NapViScreen()))
                                        .then((value) => blocProfile.add(GetData()));                                  }

                                },
                                child: const ButtonPay(
                                    icon: Icons.credit_card,
                                    title: 'Nạp tiền vào ví'),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                if(modelProfile
                                    .walletProfile!.statusBank!.key==false){
                                  CustomToast.showToast(
                                      context: context,
                                      msg: 'Bạn phải xác thực tài khoản ngân hàng trước',
                                      gravity: ToastGravity.BOTTOM,
                                      duration: 2);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const AccountBankScreen()))
                                      .then((value) => blocProfile.add(GetData()));
                                }else{
Navigator.push(context, MaterialPageRoute(builder: (context)=>RutTienScreen()));
                                }
                                },
                                child: ButtonPay(
                                    icon: Icons.account_balance,
                                    title: 'Rút tiền'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   width: double.infinity,
                        //   height: 60,
                        //   decoration: BoxDecoration(
                        //       color: ColorApp.greyE6,
                        //       borderRadius: BorderRadius.circular(40)),
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 8, vertical: 2),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             const SizedBox(
                        //               width: 5,
                        //             ),
                        //             Image.asset(
                        //               'assets/images/quydinh.png',
                        //               width: 35,
                        //               height: 35,
                        //             ),
                        //             const SizedBox(
                        //               width: 15,
                        //             ),
                        //             Text(
                        //               'Ví thường',
                        //               style:
                        //                   StyleApp.textStyle700(fontSize: 16),
                        //             ),
                        //           ],
                        //         ),
                        //         const FaIcon(FontAwesomeIcons.longArrowRight)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ViCsScreen()))
                                .then((value) => blocProfile.add(GetData()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        'assets/images/htkh.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Thông tin tài khoản ví CS',
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
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LichSuGD()));
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
                                      Image.asset('assets/images/htkh.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Lịch sử giao dịch',
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          if (state is LoadFail) {
            return ItemLoadFaild(
              error: state.error,
              onTap: () {},
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
