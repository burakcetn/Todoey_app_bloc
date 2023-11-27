import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_bootcamp/data/models/task_model.dart';

class DatabaseHelper {
  static const String database = "task.sqlite";

  static Future<Database> instance() async {
    String veritabaniYolu = join(await getDatabasesPath(), database);

    if (await databaseExists(veritabaniYolu)) {
      print("Veritabanı daha önce kopyalanmış");
    } else {
      ByteData data = await rootBundle.load("databases/$database");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes, flush: true);
      print("Veritabanı kopyalandı");
    }

    return openDatabase(veritabaniYolu);
  }
}
