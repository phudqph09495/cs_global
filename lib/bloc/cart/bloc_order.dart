import 'package:cs_global/model/model_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';
import 'event_bloc2.dart';

class BlocOrder extends Bloc<EventBloc2, StateBloc> {
  BlocOrder() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc2 event) async* {
    if (event is CreateOrder) {
      yield Loading();
      try {
        Map<String, dynamic> req = event.toJson();
        print(req);
        var res = await Api.postAsync(
          endPoint: ApiPath.order,
          req: req,
        );
print(res);
        if (res['status'] == 'success') {
          yield LoadSuccess();
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
