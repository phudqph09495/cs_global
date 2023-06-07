import 'package:flutter/material.dart';

import '../../bloc/state_bloc.dart';
import '../../styles/init_style.dart';
import 'item_loadfaild.dart';

Widget ItemLoadPage({
  required StateBloc state,
  Widget? success,
  Widget? loadError,
  Widget? loading,
  String? errorText,
  Function()? onTapErr,
}) {
  if (state is Loading) {
    return loading ??
        const Center(
          child: CircularProgressIndicator(
            color: ColorApp.main,
          ),
        );
  }
  if (state is LoadFail) {
    return loadError ??
        ItemLoadFaild(
          error: state.error,
          onTap: onTapErr,
        );
  }
  if (state is LoadSuccess) {
    return success ?? const SizedBox();
  }
  return Container();
}
