
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocForgetPass extends Bloc<EventBloc, StateBloc> {
  BlocForgetPass() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is changePass) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
        req['currentPassword'] = event.currentPassword;
        req['newPassword'] = event.newPassword;
        req['re_newPassword'] = event.rePassword;
        req['otp'] = event.otp;
print(req);

        var res = await Api.postAsync(endPoint: ApiPath.forgetPass, req: req,isToken: false);
print(res);
        // yield LoadSuccess(
        // );
        if (res['status'] == 'success'){




          yield LoadSuccess(
mess: res['message']
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
