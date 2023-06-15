
import 'package:cs_global/bloc/state_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';



import '../widget/item/custom_toast.dart';
import '../widget/item/dialog_item.dart';



class CheckLogState {
  static check(BuildContext context,
      {required StateBloc state,
      String? msg,
        String? err,
      bool isShowMsg = true,
      bool isShowDlg = false,
      int duration = 2,
      Function()? ontap,
      Function()? success}) {
    if (state is Loading) {
      DialogItem.showLoading(context: context);
    }
    if (state is LoadSuccess) {
      DialogItem.hideLoading(context: context);

      isShowMsg
          ? CustomToast.showToast(
              context: context,
              msg: msg ?? state.data,
              duration: 3,
              gravity: ToastGravity.CENTER)
          : null;
      if (success != null) {
        success();
      }
    }
    if (state is LoadFail) {
      DialogItem.hideLoading(context: context);
      isShowDlg
          ? DialogItem.showMsg(
              context: context,
              title: "Lỗi",
              msg: state.error
                 )
          : CustomToast.showToast(
              context: context,
              msg: state.error,
              duration: 3);
    }
  }
}
