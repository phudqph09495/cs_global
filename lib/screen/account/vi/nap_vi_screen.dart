import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cs_global/home.dart';
import 'package:cs_global/widget/item/custom_toast.dart';
import 'package:cs_global/widget/item/load_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/OTP/bloc_getOTP.dart';
import '../../../bloc/auth/bloc_profile.dart';
import '../../../bloc/auth/bloc_upgradeAcc.dart';
import '../../../bloc/bank/bloc_naptienVi.dart';
import '../../../bloc/check_log_state.dart';
import '../../../bloc/event_bloc.dart';
import '../../../bloc/state_bloc.dart';
import '../../../config/const.dart';
import '../../../config/share_pref.dart';
import '../../../model/model_profile.dart';
import '../../../styles/init_style.dart';
import '../../../validator.dart';
import '../../../widget/item/grid_view_custom.dart';
import '../../../widget/item/input/text_filed.dart';
import '../../../widget/loadPage/item_loadfaild.dart';

class NapViScreen extends StatefulWidget {
  @override
  State<NapViScreen> createState() => _NapViScreenState();
}

class _NapViScreenState extends State<NapViScreen> {
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  List<XFile> imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  StreamController imagesController = StreamController.broadcast();
  Stream get imageStream => imagesController.stream;
  BlocNapTieNVI blocNapTien = BlocNapTieNVI();
  TextEditingController money = TextEditingController();

  TextEditingController code = TextEditingController();
  BlocGetOTP blocGetOTP = BlocGetOTP();
  Future<String> phone() async {
    return await SharedPrefs.readString('phone');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: blocProfile,
        builder: (_, StateBloc state) {
          if (state is Loading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: ColorApp.main,
                ),
              ),
            );
          }
          if (state is LoadFail) {
            return ItemLoadFaild(
              error: state.error,
              onTap: () {
                blocProfile.add(GetData());
              },
            );
          }
          if (state is LoadSuccess) {
            ModelProfile model = state.data;
            return Scaffold(
              bottomSheet: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocListener(
                  bloc: blocNapTien,
                  listener: (_, StateBloc state1) {
                    CheckLogState.check(context,
                        state: state1,
                        msg: state1 is LoadSuccess
                            ? state1.mess
                            : 'Gửi yêu cầu nạp tiền thành công', success: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    });
                  },
                  child: InkWell(
                    onTap: () {
                      if (imageFiles.length > 0 && money.text != '') {
                        print(imageFiles.length);
                        final bytes =
                            File(imageFiles[0].path).readAsBytesSync();
                        String img =
                            "data:image/png;base64," + base64Encode(bytes);
                        blocNapTien.add(napTien(
                            price: int.parse(money.text.replaceAll('.', '')),
                            img: img,code: code.text));
                      } else if (imageFiles.length == 0) {
                        CustomToast.showToast(
                            context: context,
                            msg: 'Bạn phải gửi ảnh giao dịch',
                            gravity: ToastGravity.BOTTOM,
                            duration: 2);
                      } else if (money.text == '') {
                        CustomToast.showToast(
                            context: context,
                            msg: 'Bạn phải nhập số tiền cần nạp',
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
                          'Gửi ảnh giao dịch',
                          style: StyleApp.textStyle500(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: ColorApp.green00,
                title: Text(
                  'Nạp tiền ',
                  style:
                      StyleApp.textStyle500(fontSize: 20, color: Colors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ngân hàng',
                        style: StyleApp.textStyle500(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              LoadImage(
                                url:
                                    'https://upload.wikimedia.org/wikipedia/commons/7/7c/Techcombank_logo.png',
                                height: 30,
                                fit: BoxFit.fitWidth,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    'Ngân hàng Thương mại cổ phần Kỹ Thương Việt Nam',
                                    style: StyleApp.textStyle500(),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Số tài khoản :',
                        style: StyleApp.textStyle700(fontSize: 16),
                      ),
                      Text(
                        '19066333999996 ',
                        style: StyleApp.textStyle500(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Tên chủ tài khoản :',
                        style: StyleApp.textStyle700(fontSize: 16),
                      ),
                      Text(
                        'CTCP TAP DOAN CS GLOBAL',
                        style: StyleApp.textStyle500(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Số tiền :',
                        style: StyleApp.textStyle700(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InputText1(
                        height: 50,
                        colorShadow: Colors.transparent,
                        keyboardType: TextInputType.number,
                        label: 'Nhập số tiền',
                        controller: money,
                        inputformater: [ThousandsSeparatorInputFormatter()],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Nội dung',
                        style: StyleApp.textStyle700(fontSize: 16),
                      ),
                      Text(
                        'NapTienCS ${model.profile!.code}',
                        style: StyleApp.textStyle500(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Mã OTP',
                        style: StyleApp.textStyle700(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
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
                            onTap: () async {
                              blocGetOTP.add(getOTP(
                                  phone: await phone(), type: 'nap_tien'));
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorApp.dark500.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_outlined,
                                color: ColorApp.dark,
                                size: 50,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    '''Chú ý: nếu thiếu nội dung chuyển khoản này,CS Global sẽ không nhận ra khoản tiền nạp vào ví của bạn. Vui lòng nhập đúng nội dung chuyển khoản''',
                                    style: StyleApp.textStyle500(fontSize: 14),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Bạn vui lòng chụp lại màn hình chuyển khoản và gửi lại cho chúng tôi để xử lý giao dịch',
                        style: StyleApp.textStyle500(fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) {
                            {
                              if (value != null) {
                                if (imageFiles.length == 0) {
                                  imageFiles.add(value);
                                } else {
                                  imageFiles[0] = value;
                                }
                                imagesController.sink.add(imageFiles);
                              }
                            }
                          });
                        },
                        child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            strokeWidth: 1,
                            dashPattern: const [8, 8],
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: StreamBuilder(
                                  stream: imageStream,
                                  initialData: imageFiles,
                                  builder: (context, snapshot) {
                                    return buildImage();
                                  },
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold();
        });
  }

  Widget buildImage() {
    return GridViewCustom(
        itemCount: imageFiles.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        showFull: true,
        maxWight: 100,
        mainAxisExtent: 100,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemBuilder: (_, index) {
          return SizedBox(
            width: double.infinity,
            height: 100,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Image.file(
                      File(imageFiles[index].path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                    ),
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: InkWell(
                    onTap: () {
                      imageFiles.removeAt(index);
                      imagesController.sink.add(imageFiles);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
