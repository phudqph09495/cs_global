
import 'model_sp.dart';

abstract class EventBloc2 {}
class AddData extends EventBloc2{
  ModelSanPhamMain modelSanPhamMain;
  AddData({required this.modelSanPhamMain});
}
class Reduce extends EventBloc2{
  ModelSanPhamMain modelSanPhamMain;
  Reduce({required this.modelSanPhamMain});
}
class ClearAll extends EventBloc2{}
class GetCart extends EventBloc2{}