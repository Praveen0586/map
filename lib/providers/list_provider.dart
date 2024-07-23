import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map/data/locationdatas.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDataBase() async {
  final dbpath = await sql.getDatabasesPath();
  final database = await sql.openDatabase(
    path.join(dbpath, 'places1.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_place(id TEXT PRIMARY KEY,title TEXT,lat REAL,long REAL,image TEXT )');
    },
    version: 1,
  );
  return database;
}

class AddStateNotifier extends StateNotifier<List<Locationdatas>> {
  AddStateNotifier() : super(const []);

//getting extracting data from sql
  Future<void> loaddata() async {
    print('data recieve started ');
    final database = await _getDataBase();
    final data = await database.query('user_place');
    print('stage 1 ');
    final places = data.map((row) {
      return Locationdatas(
          row['title'] as String,
          File(row['image'] as String),
          LocationDetails(
              latitude: row['lat'] as double, longitude: row['long'] as double),
          id: row['id'] as String);
    }).toList();
    print('stage 2 ');
    state = places;
    print('stage 3 ');
  }

  void additem(String title, File image, LocationDetails location) async {
    final filename = path.basename(image.path);
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final copiedpath = await image.copy('${appDir.path}/$filename');
    final newitem = Locationdatas(title, copiedpath, location);
    state = [newitem, ...state];
    print('1111111111111111');
    print(newitem);
    print(newitem.id);
    print(newitem.imgae.path);
    print(newitem.place.latitude);
    print(newitem.place.longitude);
    print(newitem.title);

    final database = await _getDataBase();
    database.insert('user_place', {
      'id': newitem.id,
      'title': newitem.title,
      'lat': newitem.place.latitude,
      'long': newitem.place.longitude,
      'image': newitem.imgae.path
    });
    print('test working 222222222222222222');
  }
}

var addplacenotifier =
    StateNotifierProvider<AddStateNotifier, List<Locationdatas>>(
        (ref) => AddStateNotifier());
