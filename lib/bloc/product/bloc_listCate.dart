
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_listCate.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocListCate extends Bloc<EventBloc, StateBloc> {
  BlocListCate() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {



        var res = await Api.getAsync(endPoint: ApiPath.category,);

        // yield LoadSuccess(
        // );
        if (res['status'] == 'success'){

ModelListCate modelListCate=ModelListCate.fromJson(res['data']);


          yield LoadSuccess(
data: modelListCate
          );
        } else if (res['status'] == 'error') {

          yield LoadFail(error: res['messages'] ?? "Lỗi kết nối");
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
