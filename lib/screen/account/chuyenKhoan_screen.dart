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
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/auth/bloc_upgradeAcc.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../model/model_profile.dart';
import '../../styles/init_style.dart';
import '../../widget/item/grid_view_custom.dart';
import '../../widget/loadPage/item_loadfaild.dart';

class ChuyenKhoanScreen extends StatefulWidget {
  String type;
  ChuyenKhoanScreen({required this.type});

  @override
  State<ChuyenKhoanScreen> createState() => _ChuyenKhoanScreenState();
}

class _ChuyenKhoanScreenState extends State<ChuyenKhoanScreen> {
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  List<XFile> imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  StreamController imagesController = StreamController.broadcast();
  Stream get imageStream => imagesController.stream;
  BlocUpGrade blocUpGrade = BlocUpGrade();
  String tien = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.type) {
      case 'ctv':
        {
          tien = '1.000.000';
        }
        break;
      case 'dai_ly':
        {
          tien = '2.000.000';
        }
        break;
      case 'truong_nhom_kinh_doanh':
        {
          tien = '3.000.000';
        }
        break;
    }
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
              onTap: () {},
            );
          }
          if (state is LoadSuccess) {
            ModelProfile model = state.data;
            return Scaffold(
              bottomSheet: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocListener(
                  bloc: blocUpGrade,
                  listener: (_, StateBloc state1) {
                    CheckLogState.check(context,
                        state: state1,
                        msg: 'Thành công, chờ một chút để admin xác thực',
                        success: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    });
                  },
                  child: InkWell(
                    onTap: () {

                      if (imageFiles.length > 0) {
                        print(imageFiles.length);
                        final bytes =
                            File(imageFiles[0].path).readAsBytesSync();
                        String img =
                            "data:image/png;base64," + base64Encode(bytes);
                        blocUpGrade.add(upgrade(type: widget.type, img: img));
                      } else {
                        CustomToast.showToast(
                            context: context,
                            msg: 'Bạn phải gửi ảnh giao dịch',
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
                  'Thanh toán chuyển khoản',
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
                        '658933333 ',
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
                        'Vương Văn Thảo ',
                        style: StyleApp.textStyle500(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Số tiền :',
                        style: StyleApp.textStyle700(fontSize: 16),
                      ),
                      Text(
                        '${tien} đ',
                        style: StyleApp.textStyle500(fontSize: 16),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Nội dung',
                        style: StyleApp.textStyle700(fontSize: 16),
                      ),
                      Text(
                        'CS03249820332723',
                        style: StyleApp.textStyle500(fontSize: 16),
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
        mainAxisExtent: 50,
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
