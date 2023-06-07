import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageBloc extends Cubit<XFile?> {
  ChooseImageBloc() : super(null);

  void getImage({XFile? image}) {
    emit(image);
  }
}
