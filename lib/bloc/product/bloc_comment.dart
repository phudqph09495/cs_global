
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocComment extends Bloc<EventBloc, StateBloc> {
  BlocComment() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is Comment) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
       req['productId']=event.productID;
       req['star']=event.star;
req['comment']=event.comment;

        var res = await Api.postAsync(endPoint: ApiPath.commentL, req: req,);
print(res);
        // yield LoadSuccess(
        // );
        if (res['status'] == 'success'){



          yield LoadSuccess(
         mess:res['message']
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
