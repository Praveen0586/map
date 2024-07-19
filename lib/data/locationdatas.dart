import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4;

var locationdatas = [Locationdatas('sd')];

class Locationdatas {
  Locationdatas(this.title) : id = uuid.toString();
  String title;
  String id;
}
