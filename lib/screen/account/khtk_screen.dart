import 'package:cs_global/screen/account/kichHoat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_profile.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';

class KichHoatTK extends StatefulWidget {
  const KichHoatTK({Key? key}) : super(key: key);

  @override
  State<KichHoatTK> createState() => _KichHoatTKState();
}

class _KichHoatTKState extends State<KichHoatTK> {
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  List<String> key = ['ctv', 'dai_ly', 'truong_nhom_kinh_doanh'];
  List<String> key1 = ['thuong', 'ctv', 'dai_ly', 'truong_nhom_kinh_doanh'];
  List<String> name = ['Công tác viên', 'Đại Lý', 'Trưởng Nhóm Kinh Doanh'];
  List<String> mota = [
    '''
- Điều kiện :
 + Đăng ký tạo tài khoản nạp 1.000.000đ có ngay 1000 điểm tiêu dùng.
 + Phí quản lý tài khoản 200.000đ ( Hoàn lại sau 12 tháng )
 Quyền lợi :
 + Thưởng chiết khấu 10%-15% trên bất kể đơn hàng
 + Tham gia khoá đào tạo cơ bản CS Global
  ''',
    '''
- Điều kiện :
 + Đăng ký tạo tài khoản nạp 2.000.000đ có ngay 2000 điểm tiêu dùng.
 + Phí quản lý tài khoản 500.000đ ( Hoàn lại sau 12 tháng )
 Quyền lợi :
 + Thưởng chiết khấu 20% trên bất kể đơn hàng
 + Tham gia khoá đào tạo chuyên sâu CS Global
 ''',
    '''
- Điều kiện :
 + Đăng ký tạo tài khoản nạp 3.000.000đ có ngay 3000 điểm tiêu dùng.
 + Phí quản lý tài khoản 1.000.000đ ( Hoàn lại sau 12 tháng )
- Quyền lợi :
 + Thưởng chiết khấu 25% trên bất kể đơn hàng
 + Tham gia khoá đào tạo chuyên sâu CS Global
 '''
  ];
  List<bool> choosen = [false, false, false];
  int intChoose = -1;
  String strChoose = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
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
          ModelProfile modelProfile = state.data;
          if (key1.contains(modelProfile.profile!.type!.key) == false) {
            key.clear();
            name.clear();
          }
          // for(var i=0;i<key.length;i++){
          //   if(key[i]==modelProfile.profile!.type!.key){
          //
          //   }
          // }
          int ind = key.indexOf(modelProfile.profile!.type!.key ?? '');
          if (ind != -1) {
            key.removeRange(0, ind + 1);
            name.removeRange(0, ind + 1);
            choosen.removeRange(0, ind + 1);
            mota.removeRange(0, ind + 1);
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.dark500)),
                        height: Const.size(context).height * 0.2,
                        width: double.infinity,
                        child: LoadImage(
                          url:
                              '${Const.image_host}${modelProfile.profile!.banner}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          top: 30,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/images/logo2.png'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorApp.green00,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hạng tài khoản',
                            style: StyleApp.textStyle600(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 1,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${modelProfile.profile!.name}',
                            style: StyleApp.textStyle600(
                                color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 1,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Hiệu lực kinh doanh: ${modelProfile.profile!.dateActiveBussiness == null ? 'Chưa kích hoạt' : 'Đã kích hoạt'}',
                            style: StyleApp.textStyle600(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Tiền tiêu dùng: ${Const.convertPrice(modelProfile.profile!.balance)} đ',
                            style: StyleApp.textStyle600(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Phí quản lý TK: 0 đ',
                            style: StyleApp.textStyle600(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/svg/acco.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              'Người giới thiệu',
                              style: StyleApp.textStyle500(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            modelProfile.profile!.beRefered!.length > 0
                                ? Text(
                                    modelProfile.profile!.beRefered![0].name ??
                                        '',
                                    style: StyleApp.textStyle500(),
                                  )
                                : Text(''),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all()),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: SvgPicture.asset(
                                        'assets/svg/share.svg')),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Share',
                                      style: StyleApp.textStyle500(),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all()),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: SvgPicture.asset(
                                        'assets/svg/lichSU.svg')),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Lịch sử',
                                      style: StyleApp.textStyle500(),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all()),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: SvgPicture.asset(
                                        'assets/svg/gZalo.svg')),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Nhóm Zalo',
                                      style: StyleApp.textStyle500(),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Kích hoạt quyền kinh doanh',
                          style: StyleApp.textStyle500(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Text(
                            'Vui lòng kích hoạt loại hình bạn muốn kích hoạt quyền kinh doanh',
                            style: StyleApp.textStyle500(),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                            name.length,
                            (index) => InkWell(
                                  onTap: () {
                                    for (int i = 0; i < choosen.length; i++) {
                                      choosen[i] = false;
                                    }
                                    choosen[index] = true;
                                    strChoose = key[index];
                                    intChoose = index;
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    height: MediaQuery.of(context).size.width *
                                        0.27,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: choosen[index] == true
                                                ? Colors.red
                                                : Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${name[index]}',
                                            textAlign: TextAlign.center,
                                            style: StyleApp.textStyle500(
                                                fontSize: 12),
                                          ),
                                          Image.asset(
                                            'assets/images/cslogo.png',
                                            fit: BoxFit.cover,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  ),
                  intChoose != -1
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.red, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Mô tả',
                                    style: StyleApp.textStyle700(
                                        color: ColorApp.redText, fontSize: 18),
                                  ),
                                  Text(
                                    mota[intChoose],
                                    style: StyleApp.textStyle500(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: intChoose != -1
                        ? InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>KichHoatScreen(mota: mota[intChoose],type: strChoose,)));
                      },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: ColorApp.darkGreen,
                                  borderRadius: BorderRadius.circular(20)),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Đồng ý',
                                  textAlign: TextAlign.center,
                                  style: StyleApp.textStyle500(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                        )
                        : Container(
                            decoration: BoxDecoration(
                                color: ColorApp.greyBD,
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Đồng ý',
                                textAlign: TextAlign.center,
                                style: StyleApp.textStyle500(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold();
      },
      bloc: blocProfile,
    );
  }
}
