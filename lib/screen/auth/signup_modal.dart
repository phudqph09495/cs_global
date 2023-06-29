//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../bloc/auth/bloc_register.dart';
// import '../../bloc/check_log_state.dart';
// import '../../bloc/event_bloc.dart';
// import '../../bloc/state_bloc.dart';
// import '../../config/const.dart';
// import '../../styles/init_style.dart';
// import '../../validator.dart';
// import '../../widget/item/input/text_filed.dart';
// import '../../widget/item/input/text_filed2.dart';
// import 'login_modal.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   TextEditingController phone = TextEditingController();
// TextEditingController name=TextEditingController();
//   TextEditingController pass=TextEditingController();
//   final GlobalKey _key = GlobalKey();
//
//   TextEditingController rePass=TextEditingController();
//   TextEditingController code=TextEditingController();
//   final keyForm = GlobalKey<FormState>();
//   void _showOverlay(context) async {
//     final box = _key.currentContext!.findRenderObject() as RenderBox;
//     final offset = box.localToGlobal(Offset.zero);
//     final entry = OverlayEntry(
//       builder: (_) => Positioned(
//         top: offset.dy-80,
// left:offset.dx ,
//         child: _buildInfo(),
//       ),
//     );
//     Overlay.of(context).insert(entry);
//     await Future.delayed(Duration(seconds:2));
//     entry.remove();
//   }
//
//   Widget _buildInfo() {
//     return Material(
//       child: Container(
//         width: 300,
//         color: Colors.red[200],
// padding: EdgeInsets.all(8),
//         child: Text('Sử dụng số điện thoại Zalo của bạn để nhận thông báo',style: StyleApp.textStyle500(fontSize: 16),),
//       ),
//     );
//   }
//   BlocRegister blocRegister=BlocRegister();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.65,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Form(
//           key: keyForm,
//           child: SingleChildScrollView(
//             child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     'ĐĂNG KÝ',
//                     style: StyleApp.textStyle500(fontSize: 16),
//                   ),
//                 ),
//
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     InputText1(
//                       controller: name,
//                       label: 'Họ và tên',
//                       hasLeading: true,
//                       iconPreFix: Icon(Icons.person),
//                       validator: (val){
//                         return ValidatorApp.checkNull(isTextFiled: true,text: val);
//                       },
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     InputText1(
//  controller: phone,
//                       globalKey: _key,
//                       onTap: (){
//                         _showOverlay(context);
//                       },
//                       keyboardType: TextInputType.phone,
//                       label: 'Số điện thoại',
//                       hasLeading: true,
//
//                       iconPreFix: Icon(Icons.phone),
//                       validator: (val){
//                         return ValidatorApp.checkPhone(text: val);
//                       },
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     InputText2(
//                       controller: pass,
//                       label: 'Mật Khẩu',
//                       iconData: Icons.lock,
//                       hasLeading: true,
//                       obscureText: true,
//                       hasPass: true,
//                       validator: (val){
//                         return ValidatorApp.checkPass(text: val,text2: rePass.text,isSign: true);
//                       },
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     InputText2(
//                       controller: rePass,
//                       label: 'Nhập lại mật khẩu',
//                       iconData: Icons.lock,
//                       hasLeading: true,
//                       obscureText: true,
//                       hasPass: true,
//                       validator: (val){
//                         return ValidatorApp.checkPass(text: val,text2: pass.text,isSign: true);
//                       },
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     InputText2(
//                       controller: code,
//                       label: 'Mã giới thiệu',
//                       iconData:     FontAwesomeIcons.rotate,
//                       hasLeading: true,
//                       obscureText: true,
//                       hasPass: true,
//                     ),
//                     SizedBox(height: 15,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(),
//                         BlocListener(bloc: blocRegister,
//                           listener: (_,StateBloc state) {
//                             CheckLogState.check(context, state: state,msg: 'Đăng ký thành công',
//                             success: (){
//                               Navigator.pop(context);
//
//                             });
//                           },
//                           child: InkWell(
//                             onTap: (){
//                               if (keyForm.currentState!.validate()) {
//                                 blocRegister.add(CreateAcc(
//                                   name: name.text,
//                                   pass: pass.text,
//                                   rePass: rePass.text,
//                                   phone:phone.text,
//                                   code: code.text
//                                 ));
//                               }
//                             },
//                             child: Row(
//                               children: [
//                                 Text(
//                                   'ĐĂNG KÝ  ',
//                                   style: StyleApp.textStyle500(),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.green,
//                                       borderRadius: BorderRadius.circular(12)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Icon(
//                                       Icons.arrow_forward_rounded,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(),
//                     Row(
//                       children: [
//                         Text(
//                           'Bạn đã có tài khoản? ',
//                           style: StyleApp.textStyle500(),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             Const.showScreen(Login(),context);
//                           },
//                           child: Text(
//                             'Đăng nhập',
//                             style: StyleApp.textStyle500(
//                                 color: Colors.green),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }