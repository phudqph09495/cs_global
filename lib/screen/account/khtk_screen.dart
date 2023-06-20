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
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorApp.dark500)),
                    height: Const.size(context).height * 0.2,
                    width: double.infinity,
                    child: LoadImage(
                      url: '${Const.image_host}${modelProfile.profile!.banner}',
                      fit: BoxFit.cover,
                    ),
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
                            'Hiệu lực kinh doanh: ${modelProfile.profile!.dateActiveBussiness==null?'Chưa kích hoạt':'Đã kích hoạt'}',
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
                SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SvgPicture.asset('assets/svg/acco.svg'),
                        SizedBox(width: 5,),
                        Column(
                          children: [
                            Text('Người giới thiệu',style: StyleApp.textStyle500(),),
                       SizedBox(height: 5,),
                       modelProfile.profile!.beRefered!.length>0?     Text(modelProfile.profile!.beRefered![0].name??'',style: StyleApp.textStyle500(),):Text(''),

                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: MediaQuery.of(context).size.width*0.27,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                            )
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(flex: 1,child: SvgPicture.asset('assets/svg/share.svg')),
                                Expanded(flex: 1,child: Text('Share',style: StyleApp.textStyle500(),))
                              ],
                            ),
                          ),
                        ),
                        Container(width: MediaQuery.of(context).size.width*0.27,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                              )
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(flex: 1,child: SvgPicture.asset('assets/svg/share.svg')),
                                Expanded(flex: 1,child: Text('Share',style: StyleApp.textStyle500(),))
                              ],
                            ),
                          ),
                        ),
                        Container(width: MediaQuery.of(context).size.width*0.27,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                              )
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(flex: 1,child: SvgPicture.asset('assets/svg/share.svg')),
                                Expanded(flex: 1,child: Text('Share',style: StyleApp.textStyle500(),))
                              ],
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                  Container(alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text('Kích hoạt quyền kinh doanh'),
                        Text('data')
                      ],
                    ),
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
