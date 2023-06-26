import 'package:cs_global/bloc/bank/bloc_updateBank.dart';
import 'package:cs_global/bloc/bank/bloc_walletProfile.dart';
import 'package:cs_global/bloc/bank/model_listBank.dart';
import 'package:cs_global/bloc/bank/model_profileWallet.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bank/bloc_listBank.dart';
import '../../../bloc/state_bloc.dart';
import '../../../config/const.dart';
import '../../../styles/init_style.dart';
import '../../../widget/item/load_image.dart';

class AccountBankScreen extends StatefulWidget {
  const AccountBankScreen({super.key});

  @override
  State<AccountBankScreen> createState() => _AccountBankScreenState();
}

class _AccountBankScreenState extends State<AccountBankScreen> {
  TextEditingController bankname = TextEditingController();
  TextEditingController bankAcc = TextEditingController();
  TextEditingController bankAccName = TextEditingController();
  BlocListBank blocListBank = BlocListBank()..add(GetData());
  BlocUpdateBank blocUpdateBank = BlocUpdateBank();
  BlocProfileWallet blocProfileWallet = BlocProfileWallet()..add(GetData());
  Bank bank = Bank();
  String bankName = 'Chọn ngân hàng';
  String bankCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocListener(
        bloc: blocUpdateBank,
        listener: (_, StateBloc state) {
          CheckLogState.check(context,
              state: state,
              msg:
                  'Gửi yêu cầu cập nhật thành công!\n Vui lòng chờ admin kiểm tra',
              success: () {
            Navigator.pop(context);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () {
              blocUpdateBank.add(UpdateBank(bankname.text, bankCode, bankAcc.text,
                  bankAccName.text.toUpperCase()));
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
                  style:
                      StyleApp.textStyle500(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder(
        builder: (_, StateBloc state) {
          if(state is LoadSuccess){
            ModelProfileWallet modelProfileWallet=state.data;
bankname.text=modelProfileWallet.walletProfile!.bankName??'';
bankAcc.text=modelProfileWallet.walletProfile!.bankAccount??'';
bankCode=modelProfileWallet.walletProfile!.bankCode??'';
bankAccName.text=modelProfileWallet.walletProfile!.account_name??'';
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
                            child: Image.asset(
                              'assets/images/img.png',
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Row(
                                      children: [
                                        Text(
                                          'Ví CS cuả bạn ${modelProfileWallet.walletProfile!.statusBank!.name}',
                                          style: StyleApp.textStyle500(
                                              color: Colors.white, fontSize: 16),
                                        ),

                                      ],
                                    ),
                                    SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                          top: 25,
                          left: 5,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: ColorApp.dark500.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                  ),
                                )),
                          ))
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Thông tin ví CS',
                    style: StyleApp.textStyle500(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text('Ngân hàng'),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder(
                          builder: (_, StateBloc state) {
                            if (state is LoadSuccess) {
                              ModelListBank model = state.data;
                              return InputText1(
                                hasSuffix: true,
                                colorShadow: Colors.transparent,
                                label: 'Hãy chọn ngân hàng',
                                readOnly: true,
                                controller: bankname,
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    bank = model.data![index];
                                                    bankCode=bank.code!;
                                                    bankname.text =
                                                    bank.name!;
                                                    Navigator.pop(context);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          LoadImage(
                                                            url:
                                                            '${model.data![index].logo}',
                                                            height: 30,
                                                            fit: BoxFit.fitWidth,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.6,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  '${model.data![index].shortName}',
                                                                  style: StyleApp
                                                                      .textStyle700(),
                                                                ),
                                                                Text(
                                                                  '${model.data![index].name}',
                                                                  style: StyleApp
                                                                      .textStyle400(
                                                                      fontSize:
                                                                      12),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Icon(Icons
                                                              .arrow_forward_ios)
                                                        ],
                                                      ),
                                                      Divider()
                                                    ],
                                                  ),
                                                );
                                              },
                                              shrinkWrap: true,
                                              itemCount: model.data!.length,
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                                suffix: Icons.keyboard_arrow_down_rounded,
                                suffixColor: Colors.black,
                              );
                            }
                            return InputText1(
                              label: '',
                              colorShadow: Colors.transparent,
                            );
                          },
                          bloc: blocListBank,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Số tài khoản'),
                        SizedBox(
                          height: 10,
                        ),
                        InputText1(
                          onChanged: (val){
                            modelProfileWallet.walletProfile!.bankAccount=val;
                          },
                          label: 'Hãy nhập số tài khoản',
                          controller: bankAcc,
                          colorShadow: Colors.transparent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Hò và tên chủ tài khoản'),
                        SizedBox(
                          height: 10,
                        ),
                        InputText1(
                          onChanged: (val){
                            modelProfileWallet.walletProfile!.account_name=val;
                          },
                          label: 'Nhập họ và tên chủ tài khoản',
                          controller: bankAccName,
                          colorShadow: Colors.transparent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Xác minh thông tin',
                          style: StyleApp.textStyle500(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Bảo mật thông tin của bạn luôn là ưu tiên hàng đầu của CS Global. Tất cả các thông tin người dùng để xác minh danh tính đều được thực hiện theo yêu cầu của chính phủ và các cơ quan liên quan nhằm ngăn chặn hành vi đánh cắp thông tin và đề phòng rủi ro trong giao dịch',
                          style: StyleApp.textStyle500(),
                        ),
                        SizedBox(
                          height: 100,
                        ),

                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return SizedBox();
        },
        bloc: blocProfileWallet,
      ),
    );
  }
}
