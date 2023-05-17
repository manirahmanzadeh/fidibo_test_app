import 'package:fidibo_test/domain/usecases/home_usecase.dart';
import 'package:fidibo_test/presentation/components/moving_object_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<HomeUseCase>().start(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Fidibo Test App'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<HomeUseCase>(
        builder: (controller){
          return Stack(
            children: controller.objects.map((e) => MovingObjectComponent(movingObjectModel: e)).toList(),
          );
        },
      ),
    );
  }
}
