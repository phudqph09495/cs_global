
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_listCate.dart';
import '../../model/model_listPro.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocListPro extends Bloc<EventBloc, StateBloc> {
  BlocListPro() : super(StateBloc());
  List<Prod> list = [];


  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is LoadMoreEvent) {

      try {
        if (!event.loadMore) {
          yield Loading();
          list.clear();
        }
        if (event.loadMore) {
          yield LoadSuccess(
            data: list,
            hasMore: true,
          );
        }



        var res = await Api.getAsync(endPoint: ApiPath.listPro+event.id+'?page='+event.page.toString(),);

        if (res['status'] == 'success'){


          if(res['data'].length!=0)     {
            for (var item in res['data']['products']['data']) {
            Prod prod=Prod.fromJson(item);
              list.add(prod);
            }
          }


          yield LoadSuccess(
            data: list,
            hasMore: false,

            checkLength: res['data']['products']['data'].length==0 && event.loadMore
                ? true
                : false,

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
