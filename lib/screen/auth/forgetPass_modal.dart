// import 'package:cs_global/bloc/check_log_state.dart';
// import 'package:cs_global/bloc/event_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../bloc/OTP/bloc_getOTP.dart';
// import '../../bloc/state_bloc.dart';
// import '../../config/const.dart';
// import '../../styles/init_style.dart';
// import '../../widget/item/input/text_filed.dart';
// import '../../widget/item/input/text_filed2.dart';
// import 'otp_modal.dart';
//
// class ForgetModal extends StatefulWidget {
//   @override
//   State<ForgetModal> createState() => _ForgetModalState();
// }
//
// class _ForgetModalState extends State<ForgetModal> {
//   TextEditingController phone = TextEditingController();
//   final keyFormForget = GlobalKey<FormState>();
//   BlocGetOTP blocGetOTP = BlocGetOTP();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.35,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Form(
//           key: keyFormForget,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   'QUÊN MẬT KHẨU',
//                   style: StyleApp.textStyle500(fontSize: 16),
//                 ),
//               ),
//               Column(
//                 children: [
//                   InputText1(
//                     keyboardType: TextInputType.phone,
//                     controller: phone,
//                     label: 'Số điện thoại',
//                     hasLeading: true,
//                     iconPreFix: Icon(Icons.person),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(),
//                       BlocListener(
//                         bloc: blocGetOTP,
//                         listener: (_, StateBloc state) {
//                           CheckLogState.check(context,
//                               state: state,
//                               msg: state is LoadSuccess
//                                   ? state.mess
//                                   : 'Đã gửi OTP',
//                           success: (){
//                             Const.showScreen(
//                                 OTPModal(
//                                   phone: phone.text,
//                                 ),
//                                 context);
//                           });
//                         },
//                         child: InkWell(
//                           onTap: () {
//                             if (keyFormForget.currentState!.validate()) {
//                               blocGetOTP.add(getOTP(
//                                   phone: phone.text, type: 'doi_mat_khau'));
//                               // Const.showScreen(
//                               //     OTPModal(
//                               //       phone: phone.text,
//                               //     ),
//                               //     context);
//                             }
//                           },
//                           child: Row(
//                             children: [
//                               Text(
//                                 'GỬI OTP  ',
//                                 style: StyleApp.textStyle500(),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.green,
//                                     borderRadius: BorderRadius.circular(12)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Icon(
//                                     Icons.arrow_forward_rounded,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
