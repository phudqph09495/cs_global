
import 'package:cs_global/model/model_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';
import 'model_listBank.dart';

class BlocListBank extends Bloc<EventBloc, StateBloc> {
  BlocListBank() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {



        var res = await Api.getAsync2(endPoint: 'https://api.vietqr.io/v2/banks', );
        // yield LoadSuccess(
        // );
        if (res['code'] == '00'){

          ModelListBank model = ModelListBank.fromJson(res);


          yield LoadSuccess(
            data: model,
          );
        } else  {

          yield LoadFail(error: res['desc'] ?? "Lỗi kết nối");
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
