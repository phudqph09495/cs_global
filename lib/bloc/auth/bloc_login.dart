
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocLogin extends Bloc<EventBloc, StateBloc> {
  BlocLogin() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is LoginApp) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
        req['userName'] = event.userName;
        req['password'] = event.password;


        var res = await Api.postAsync(endPoint: ApiPath.login, req: req,);

        // yield LoadSuccess(
        // );
        if (res['status'] == 'success'){

          ModelLogin model = ModelLogin.fromJson(res['data']);


          yield LoadSuccess(
            data: model,
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
