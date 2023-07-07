import 'dart:convert';
import 'dart:io';

import 'package:cs_global/bloc/auth/bloc_profile.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/config/const.dart';
import 'package:cs_global/home.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:cs_global/screen/account/profile_screen.dart';
import 'package:cs_global/screen/account/vi/wallet_screen.dart';
import 'package:cs_global/screen/account/vi/acc_bank_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/bloc_deleteAcc.dart';
import '../../bloc/auth/bloc_updateProfile.dart';
import '../../bloc/choose_image_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../auth/auth_screen.dart';
import 'changPass_screen.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

import 'gioiThieu/qlhtKD_screen.dart';
import 'gioithieu_screen.dart';
import 'khtk_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool showMoney = true;
  bool showMoney2 = true;
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  ChooseImageBloc chooseImageBloc = ChooseImageBloc();
  BlocUpdateProfile blocUpdateProfile = BlocUpdateProfile();
  BlocDeleteAcc blocDeleteAcc = BlocDeleteAcc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        builder: (_, StateBloc state) {
          if (state is LoadSuccess) {
            ModelProfile modelProfile = state.data;
            return RefreshIndicator(
              onRefresh: () async {
                blocProfile.add(GetData());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: Const.size(context).height * 0.5,
                          width: double.infinity,
                          child: LoadImage(
                            url:
                                '${Const.image_host}${modelProfile.profile!.banner}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const GioiThieuScreen()));
                        //   },
                        //   child: Container(
                        //     color: Colors.black.withOpacity(0.5),
                        //     width: double.infinity,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           const SizedBox(),
                        //           Row(
                        //             children: [
                        //               Text(
                        //                 'Giới thiệu bạn bè  ',
                        //                 style: StyleApp.textStyle500(
                        //                     color: Colors.white, fontSize: 16),
                        //               ),
                        //               const Icon(
                        //                 Icons.info_rounded,
                        //                 color: Colors.white,
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                      Icons.account_balance_wallet_outlined),
                                  Text(
                                    ' Số dư ví (VNĐ) : ',
                                    style: StyleApp.textStyle500(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    showMoney
                                        ? Const.ConvertPrice.format(int.parse(
                                            '${modelProfile.profile!.balance}'))
                                        : '*******',
                                    style: StyleApp.textStyle500(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMoney = !showMoney;
                                        });
                                      },
                                      child: Icon(showMoney
                                          ? CupertinoIcons.eye_slash
                                          : CupertinoIcons.eye))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(2), // Border width
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(60), // Image radius
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    LoadImage(
                                      url:
                                          '${Const.image_host}${modelProfile.profile!.avatar}',
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                    BlocListener(
                                      bloc: blocUpdateProfile,
                                      listener: (_, StateBloc state) {
                                        CheckLogState.check(context,
                                            state: state,
                                            isShowMsg: false, success: () {
                                          blocProfile.add(GetData());
                                        });
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          ImagePicker _picker = ImagePicker();
                                          _picker
                                              .pickImage(
                                                  source: ImageSource.gallery)
                                              .then((value) {
                                            if (value != null) {
                                              final bytes = File(value.path)
                                                  .readAsBytesSync();
                                              String avatar =
                                                  "data:image/png;base64,${base64Encode(bytes)}";
                                              blocUpdateProfile.add(
                                                  UpdateProfile(
                                                      name: modelProfile
                                                          .profile!.name,
                                                      email: modelProfile
                                                          .profile!.email,
                                                      address: modelProfile
                                                          .profile!.address,
                                                      avatar: avatar));
                                            }
                                          });
                                        },
                                        child: Container(
                                            height: 20,
                                            width: double.infinity,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            child: const Icon(
                                              Icons.camera_alt_outlined,
                                              color: ColorApp.dark500,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            modelProfile.profile!.name!.toUpperCase() ?? '',
                            style: StyleApp.textStyle600(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Row(
                                children: [
                                  Text(
                                    'ID khách hàng: ',
                                    style: StyleApp.textStyle500(fontSize: 16),
                                  ),
                                  Text(
                                    modelProfile.profile!.code ?? '',
                                    style: StyleApp.textStyle700(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                                text: modelProfile
                                                        .profile!.code ??
                                                    ''))
                                            .then((value) {
                                          //only if ->
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Đã copy '))); // -> show a notification
                                        });
                                      },
                                      child: const Icon((Icons.copy)))
                                ],
                              ),
                              const SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const SizedBox(),
                          //     Row(
                          //       children: [
                          //         Text(
                          //           'Cập nhật Sologan ',
                          //           style: StyleApp.textStyle500(fontSize: 16),
                          //         ),
                          //         const SizedBox(
                          //           width: 5,
                          //         ),
                          //         InkWell(
                          //             onTap: () {},
                          //             child: const Icon(
                          //                 (FontAwesomeIcons.penToSquare)))
                          //       ],
                          //     ),
                          //     const SizedBox(),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const SizedBox(),
                          //     Text(
                          //       modelProfile.profile!.phone ?? '',
                          //       style: StyleApp.textStyle500(fontSize: 16),
                          //     ),
                          //     const SizedBox(),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                                color: ColorApp.greyE6,
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/rank.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      'Hạng: ${modelProfile.profile!.type!.name}'),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const KichHoatTK()));
                                  },
                                  child: Text(
                                    'Kích hoạt hạng tài khoản',
                                    style: StyleApp.textStyle500(
                                        color: ColorApp.blue00),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                                color: ColorApp.greyE6,
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/meeting.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Người giới thiệu:',
                                        style: StyleApp.textStyle700(),
                                      ),
                                      (modelProfile.profile!.beRefered!.length >
                                              0)
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  modelProfile.profile!
                                                          .beRefered![0].name ??
                                                      '',
                                                  style:
                                                      StyleApp.textStyle500(),
                                                ),
                                                Text(' - '),
                                                Text(
                                                  modelProfile.profile!
                                                          .beRefered![0].code ??
                                                      '',
                                                  style: StyleApp.textStyle700(
                                                      color:
                                                          ColorApp.darkGreen),
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WalletScreen()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: ColorApp.greyE6,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/vi.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Ví CS',
                                          style: StyleApp.textStyle700(),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Số dư (VNĐ): ',
                                              style: StyleApp.textStyle500(),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  showMoney2
                                                      ? Const.formatPrice(
                                                      modelProfile
                                                          .profile!.balance)
                                                      : '*******',
                                                  style: StyleApp.textStyle500(
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        showMoney2 =
                                                        !showMoney2;
                                                      });
                                                    },
                                                    child: Icon(
                                                      showMoney2
                                                          ? CupertinoIcons
                                                          .eye_slash
                                                          : CupertinoIcons.eye,
                                                      size: 18,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuanLyHTKD(
                                        type:
                                        '${modelProfile.profile!.type!.name}',
                                      )));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
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
                                        Icon(
                                          Icons.info_outline_rounded,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Quản lý hệ thống kinh doanh',
                                          style: StyleApp.textStyle700(
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const FaIcon(
                                        FontAwesomeIcons.longArrowRight)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileScreen()))
                                  .then((value) => blocProfile.add(GetData()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
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
                                        Image.asset(
                                          'assets/images/tttk.png',
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Thông tin tài khoản',
                                          style: StyleApp.textStyle700(
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const FaIcon(
                                        FontAwesomeIcons.longArrowRight)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 70,
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
                                        'assets/images/quydinh.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Quy định App CS Global',
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 70,
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
                                        height: 30,
                                        width: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Hỗ trợ khách hàng',
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 70,
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
                                          'assets/images/LogoTrang.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Giới thiệu CS Global',
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
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePassProfile()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Đổi mật khẩu',
                                      style:
                                          StyleApp.textStyle700(fontSize: 16),
                                    ),
                                    const FaIcon(FontAwesomeIcons.key)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        backgroundColor: ColorApp.whiteF7,
                                        actionsPadding:
                                            const EdgeInsets.only(bottom: 10),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        scrollable: true,
                                        content: SizedBox(
                                            width:
                                                Const.sizeWidth(context, 370),
                                            height:
                                                Const.sizeHeight(context, 80),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Bạn có chắc chắn muốn xoá tài khoản',
                                                style: StyleApp.textStyle500(),
                                              ),
                                            )),
                                        actions: [
                                          BlocListener(
                                            bloc: blocDeleteAcc,
                                            listener: (_, StateBloc state) {
                                              CheckLogState.check(context,
                                                  state: state,
                                                  msg: 'Đã xoá tài khoản',
                                                  success: () async {
                                                await SharePrefsKeys
                                                    .removeAllKey();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyHomePage()));
                                              });
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                blocDeleteAcc.add(GetData());
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: ColorApp.redText),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Đồng ý',
                                                    style:
                                                        StyleApp.textStyle500(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: ColorApp.redText),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Huỷ bỏ',
                                                  style: StyleApp.textStyle500(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Xoá Tài Khoản',
                                      style:
                                          StyleApp.textStyle700(fontSize: 16),
                                    ),
                                    const FaIcon(FontAwesomeIcons.userXmark)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        backgroundColor: ColorApp.whiteF7,
                                        actionsPadding:
                                            const EdgeInsets.only(bottom: 10),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        scrollable: true,
                                        content: SizedBox(
                                            width:
                                                Const.sizeWidth(context, 370),
                                            height:
                                                Const.sizeHeight(context, 50),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Bạn muốn đăng xuất',
                                                style: StyleApp.textStyle500(),
                                              ),
                                            )),
                                        actions: [
                                          InkWell(
                                            onTap: () async {
                                              await SharePrefsKeys
                                                  .removeAllKey();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyHomePage()));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: ColorApp.redText),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Đồng ý',
                                                  style: StyleApp.textStyle500(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: ColorApp.redText),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Huỷ bỏ',
                                                  style: StyleApp.textStyle500(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Đăng xuất',
                                      style:
                                          StyleApp.textStyle700(fontSize: 16),
                                    ),
                                    const FaIcon(
                                        FontAwesomeIcons.rightFromBracket)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorApp.main,
              ),
            );
          }
          if (state is LoadFail) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.error,
                    style: StyleApp.textStyle400(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthScreen()));
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                                color: ColorApp.main, width: 1))),
                    child: Text(
                      'Đăng nhập',
                      style: StyleApp.textStyle400(),
                    ),
                  ),
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
