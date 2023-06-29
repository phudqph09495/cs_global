import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocGetOTP extends Bloc<EventBloc, StateBloc> {
  BlocGetOTP() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is getOTP) {
      yield Loading();
      try {
        var res = await Api.getAsync(
            endPoint: ApiPath.getOTP + event.phone + '&type=' + event.type,
            isToken: false);

        // yield LoadSuccess(
        // );
        print(res);
        if (res['status'] == 'success') {
          yield LoadSuccess(mess: res['message']);
        } else if (res['status'] == 'error') {
          yield LoadFail(error: res['message'] ?? "Lỗi kết nối");
        }
      } on DioError catch (e) {
        yield LoadFail(error: e.error.error);
      } catch (e) {
        print(e);
        yield LoadFail(error: e.toString());
      }
    }
  }
}
