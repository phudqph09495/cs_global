import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocRegister extends Bloc<EventBloc, StateBloc> {
  BlocRegister() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is CreateAcc) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
        req['name'] = event.name;
        req['phone'] = event.phone;
        req['password'] = event.pass;
        req['re_password'] = event.rePass;

        var res = await Api.postAsync(
          endPoint: ApiPath.dangky+event.code,
          req: req,
        );
print(res);
        // yield LoadSuccess(
        // );
        if (res['status'] == 'success') {
          yield LoadSuccess(
          );
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
