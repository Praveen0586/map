import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map/data/locationdatas.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class AddStateNotifier extends StateNotifier<List<Locationdatas>> {
  AddStateNotifier() : super(const []);

  void additem(String title, File image, LocationDetails location) async {
    final filename = path.basename(image.path);
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final copiedpath = await image.copy('${appDir.path}/$filename');
    var newitem = Locationdatas(title, copiedpath, location);
    state = [newitem, ...state];

    final dbpath = await sql.getDatabasesPath();
    final database = await sql.openDatabase(
      path.join(dbpath, 'user_files.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_place ( id TEXT PRIMARY KEY,title TEXT,lat REAL,long REAL,image TEXT )');
      },
      version: 1,
    );
    database.insert('user_place', {
      'id': newitem.id,
      'title': newitem.title,
      'lat': newitem.place.latitude,
      'long': newitem.place.longitude,
      'image': newitem.imgae.path
    });
  }
}

var addplacenotifier =
    StateNotifierProvider<AddStateNotifier, List<Locationdatas>>(
        (ref) => AddStateNotifier());
