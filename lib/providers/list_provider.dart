import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map/data/locationdatas.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class AddStateNotifier extends StateNotifier<List<Locationdatas>> {
  AddStateNotifier() : super(const []);

  void additem(String title, File image, LocationDetails location) async {
    final filename = path.basename(image.path);
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final copiedpath = await image.copy('${appDir.path}/$filename');
    var newitem = Locationdatas(title, copiedpath, location);
    state = [newitem, ...state];
  }
}

var addplacenotifier =
    StateNotifierProvider<AddStateNotifier, List<Locationdatas>>(
        (ref) => AddStateNotifier());
