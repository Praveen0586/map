import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4;

var locationdatas = [];

class Locationdatas {
  Locationdatas(this.title, this.imgae) : id = uuid.toString();
  String title;
  String id;
  File imgae;
}
