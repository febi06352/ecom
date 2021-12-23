import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class model_db {
  static model_db? _model_db;
  static Database? db;

  model_db._createObject();

  factory model_db() {
    if (_model_db == null) {
      _model_db = model_db._createObject();
    }
    return _model_db!;
  }

  static const NEW_DB_VERSION = 1;

  Future<String> getDatabasesPath() => databaseFactory.getDatabasesPath();
  Future<bool> databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  Future<Database> get getDatabase async {
    if (Platform.isAndroid) {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + 'kp_kasir.db';
      var todoDatabase = openDatabase(
        path,
        version: NEW_DB_VERSION,
        onCreate: _createDb,
      );

      return todoDatabase;
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = p.join(directory.toString(), 'kp_kasir.db');
      Database database = await openDatabase(
        path,
        version: NEW_DB_VERSION,
        onCreate: _createDb,
      );
      return database;
    }
  }

  void _createDb(Database db_client, int version) async {
    String create_barang = "CREATE TABLE IF NOT EXISTS data_barang (" +
        "id integer primary key autoincrement, " +
        "kode_barang varchar(225), " +
        "nama_barang varchar(225), " +
        "kategori varchar(225), " +
        "stok real, " +
        "harga_beli real, " +
        "harga_jual real, " +
        "diskon real, " +
        "berat_dan_satuan varchar(225), " +
        "letak_rak varchar(225), " +
        "keterangan text, " +
        "rating real, " +
        "favorit real, " +
        "gambar text)";
    await db_client.execute(create_barang);

    String create_user = "create table if not exists " +
        "user" +
        " (" +
        "id integer primary key autoincrement, " +
        "nama varchar(255), " +
        "email varchar(255), " +
        "data text, " +
        "created_at DEFAULT CURRENT_TIMESTAMP, " +
        "deleted_at DEFAULT CURRENT_TIMESTAMP);";
    await db_client.execute(create_user);

    String create_pesanan = "create table if not exists " +
        "transaksi_struk_sementara" +
        " (" +
        "id integer primary key autoincrement, " +
        "nama varchar(225), " +
        "id_user integer default 0, " +
        "status integer default 0, " +
        "created_at DEFAULT CURRENT_TIMESTAMP, " +
        "deleted_at DEFAULT CURRENT_TIMESTAMP);";
    await db_client.execute(create_pesanan);

    String create_detail_pesanan = "create table if not exists " +
        "detail_struk_sementara" +
        " (" +
        "id integer primary key autoincrement, " +
        "nama varchar(225), " +
        "kode_barang varchar(225), " +
        "harga_beli real, " +
        "harga_jual real, " +
        "banyak_barang real, " +
        "diskon real, " +
        "pajak real, " +
        "id_pesanan integer default 0, " +
        "created_at DEFAULT CURRENT_TIMESTAMP, " +
        "deleted_at DEFAULT CURRENT_TIMESTAMP);";
    await db_client.execute(create_detail_pesanan);

    String create_diskon = "create table if not exists " +
        "diskon" +
        " (" +
        "id integer primary key autoincrement, " +
        "nama varchar(255), " +
        "jumlah real, " +
        "mode integer default 0, " +
        "id_diskon varchar(255)  default 0, " +
        "data_update integer default 0, " +
        "created_at DEFAULT CURRENT_TIMESTAMP, " +
        "deleted_at DEFAULT CURRENT_TIMESTAMP);";
    await db_client.execute(create_diskon);

    String create_pajak = "create table if not exists " +
        "pajak" +
        " (" +
        "id integer primary key autoincrement, " +
        "id_pajak varchar(255)  default 0, " +
        "nama varchar(255), " +
        "jumlah real, " +
        "data_update integer default 0, " +
        "created_at DEFAULT CURRENT_TIMESTAMP, " +
        "deleted_at DEFAULT CURRENT_TIMESTAMP);";
    await db_client.execute(create_pajak);

    String create_kategori = "create table if not exists " +
        "kategori_barang" +
        " (" +
        "id integer primary key autoincrement, " +
        "kategori varchar(255), " +
        "created_at DEFAULT CURRENT_TIMESTAMP, " +
        "deleted_at DEFAULT CURRENT_TIMESTAMP);";
    await db_client.execute(create_kategori);

  }
}
