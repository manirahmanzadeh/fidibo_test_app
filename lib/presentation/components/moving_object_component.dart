import 'dart:async';

import 'package:fidibo_test/domain/usecases/home_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/moving_object_model.dart';


class MovingObjectComponent extends StatefulWidget {
  const MovingObjectComponent({Key? key, required this.movingObjectModel}) : super(key: key);
  final MovingObjectModel movingObjectModel;

  @override
  State<MovingObjectComponent> createState() => _MovingObjectComponentState();
}

class _MovingObjectComponentState extends State<MovingObjectComponent> {

  @override
  void initState() {
    startMoving();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.movingObjectModel.objectX,
      top: widget.movingObjectModel.objectY,
      child: Container(
        width: 50.0,
        height: 50.0,
        color: _colorBuilder(),
        child: Center(
          child: _textBuilder(),
        ),
      ),
    );
  }

  _colorBuilder(){
    switch(widget.movingObjectModel.movingObjectType){
      case MovingObjectType.rock:
        return Colors.grey;
      case MovingObjectType.paper:
        return Colors.white;
      case MovingObjectType.scissors:
        return Colors.red;
    }
  }

  _textBuilder(){
    switch(widget.movingObjectModel.movingObjectType){
      case MovingObjectType.rock:
        return const Text('R');
      case MovingObjectType.paper:
        return const Text('P');
      case MovingObjectType.scissors:
        return const Text('S');
    }
  }

  Timer? _timer;

  startMoving(){
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _updatePositions();
    });
  }

  _updatePositions(){
    setState(() {
      HomeUseCase homeUseCase = Get.find<HomeUseCase>();
      widget.movingObjectModel.objectX += 1 * widget.movingObjectModel.directionX;
      widget.movingObjectModel.objectY += 1 * widget.movingObjectModel.directionY;

      // Check for collision with device boundaries
      if (widget.movingObjectModel.objectX >= MediaQuery.of(context).size.width - 50 ||
          widget.movingObjectModel.objectX <= 0) {
        widget.movingObjectModel.directionX *= -1;
      }
      if (widget.movingObjectModel.objectY >= MediaQuery.of(context).size.height - 100 ||
          widget.movingObjectModel.objectY <= 0) {
        widget.movingObjectModel.directionY *= -1;
      }

      // Check for collision with other objects
      List<MovingObjectModel> deletingObjects = [];
      List<MovingObjectModel> otherObjects = homeUseCase.objects.where((element) => element != widget.movingObjectModel).toList();
      for(var otherObject in otherObjects){
        bool collided = _checkCollision(widget.movingObjectModel, otherObject);
        if(collided){
          MovingObjectModel? deletingObject = _handleCollision(widget.movingObjectModel, otherObject, homeUseCase);
          if(deletingObject != null){
            deletingObjects.add(deletingObject);
          }
        }
      }

      for(var deletingObject in deletingObjects){
        homeUseCase.removeObject(deletingObject);
      }
    });
  }


  bool _checkCollision(
      MovingObjectModel thisObject, MovingObjectModel otherObject) {
    // Calculate the bounding rectangles of the objects
    double object1Left = thisObject.objectX;
    double object1Right = thisObject.objectX + 50;
    double object1Top = thisObject.objectY;
    double object1Bottom = thisObject.objectY + 50;

    double object2Left = otherObject.objectX;
    double object2Right = otherObject.objectX + 50;
    double object2Top = otherObject.objectY;
    double object2Bottom = otherObject.objectY + 50;

    // Check if the bounding rectangles intersect
    if (object1Left < object2Right &&
        object1Right > object2Left &&
        object1Top < object2Bottom &&
        object1Bottom > object2Top) {
      return true; // Collision detected
    }

    return false; // No collision detected
  }

  MovingObjectModel? _handleCollision(
      MovingObjectModel thisObject, MovingObjectModel otherObject, HomeUseCase homeUseCase) {
    if (thisObject.movingObjectType == MovingObjectType.rock &&
        otherObject.movingObjectType == MovingObjectType.scissors) {
      thisObject.directionX *= -1;
      thisObject.directionY *= -1;
      return otherObject;
    } else if (thisObject.movingObjectType == MovingObjectType.scissors &&
        otherObject.movingObjectType == MovingObjectType.paper) {
      thisObject.directionX *= -1;
      thisObject.directionY *= -1;
      return otherObject;
    }
    else if (thisObject.movingObjectType == MovingObjectType.paper &&
        otherObject.movingObjectType == MovingObjectType.rock) {
      thisObject.directionX *= -1;
      thisObject.directionY *= -1;
      return otherObject;
    }
    if(thisObject.movingObjectType == otherObject.movingObjectType){
      thisObject.directionX *= -1;
      thisObject.directionY *= -1;
      otherObject.directionX *= -1;
      otherObject.directionY *= -1;
      return null;
    }
    return null;
  }
}


