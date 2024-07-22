import 'dart:io';

import 'package:uuid/uuid.dart';
import '';

final uuid = const Uuid().v4;

var locationdatas = [];

class LocationDetails {
  LocationDetails(
      {required this.latitude,
      required this.longitude,
      required this.addreass});
  double latitude;
  double longitude;
  String addreass;
}

class Locationdatas {
  Locationdatas(this.title, this.imgae,this.place) : id = uuid.toString();
  String title;
  String id;
  File imgae;
 LocationDetails place;
}
