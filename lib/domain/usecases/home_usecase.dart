
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/moving_object_model.dart';


class HomeUseCase extends GetxController{

  late List<MovingObjectModel> objects;

  BuildContext? context;

  start(BuildContext screenContext){
    context = screenContext;
    _fillTheList();
  }


  void _fillTheList() {
    objects = [];
    for (int t=0 ;t<=2;t++){
      MovingObjectType movingObjectType = _objectTypeDecoder(t);
      for(int i=0; i<=5; i++){
        Random random = Random();

        int directionX = random.nextInt(2) * 2 - 1; // Randomly chooses either +1 or -1
        int directionY = random.nextInt(2) * 2 - 1; // Randomly chooses either +1 or -1

        double deviceWidth = MediaQuery.of(context!).size.width - 50;
        double deviceHeight = MediaQuery.of(context!).size.height - 100;

        double objectX = random.nextDouble() * deviceWidth; // Random value between 0 and deviceWidth
        double objectY = random.nextDouble() * deviceHeight; // Random value between 0 and deviceHeight

        objects.add(
            MovingObjectModel(
                movingObjectType: movingObjectType,
                directionX: directionX,
                directionY: directionY,
                objectX: objectX,
                objectY: objectY
            )
        );
      }
    }
  }

  MovingObjectType _objectTypeDecoder(int number){
    switch(number){
      case 0:
        return MovingObjectType.paper;
      case 1:
        return MovingObjectType.rock;
      case 2:
        return MovingObjectType.scissors;
    }
    return MovingObjectType.paper;
  }

  void removeObject(MovingObjectModel movingObjectModel){
    objects.remove(movingObjectModel);
    update();
  }


}