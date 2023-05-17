
class MovingObjectModel {
  MovingObjectType movingObjectType;
  double objectX;
  double objectY;
  int directionX;
  int directionY;
  MovingObjectModel({
    required this.movingObjectType, required this.directionX,
    required this.directionY, required this.objectX, required this.objectY
  });
}

enum MovingObjectType{
  rock,
  paper,
  scissors
}