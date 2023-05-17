
import 'package:fidibo_test/domain/usecases/home_usecase.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<HomeUseCase>(HomeUseCase());
  }
}