import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Nesse momento estou criando o nomes das colunas no banco de dados SQflite, os nomes já são finais
const String devicesTable = 'devicesTable';
const String idaparelhoColumn = 'idaparelhoColumn';
const String tipoColumn = 'tipoColumn';
const String modeloColumn = 'modeloColumn';
const String memoriaColumn = 'memoriaColumn';
const String corColumn = 'corColumn';
const String custoColumn = 'custoColumn';
const String numerodeserieColumn = 'numerodeserieColumn';
const String bateriaColumn = 'bateriaColumn';

// Essa é classe com apenas um objeto, que ele apenas podera ser criado por aqui.
class DevicesHelper {
  static final DevicesHelper _instance = DevicesHelper._internal();

  factory DevicesHelper() {
    return _instance;
  }

  DevicesHelper._internal();

  // Criamos o banco de dados é afirmamos que apenas essa classe pode acessalo.
  static Database? _db;
  // Criamos a regra para que caso o banco esteja inicializado ele sejá retornado, caso não o inicaremos com a função initDb
  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDb();
      return _db;
    }
  }

  // Essa função é uma função que cria o banco de dados, como ela deve ser processada é não é instantaneo o return, temos uma função Future, com async e await.
  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'devices.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      db.execute(
          'CREATE TABLE $devicesTable ($idaparelhoColumn INTERGER PRIMARY KEY, $tipoColumn TEXT, $modeloColumn TEXT, $memoriaColumn TEXT, $corColumn TEXT, $custoColumn TEXT, $numerodeserieColumn TEXT, $bateriaColumn TEXT)');
    });
  }

// Nessa função estamos salvando os Device
  Future<Devices> saveDevices(Devices devices) async {
    Database dbDevices = await db;
    devices.idaparelho = await dbDevices.insert(devicesTable, devices.toMap());
    return devices;
  }

// Nessa função estamos buscando um Device
  Future<Devices> getDevices(int idaparelho) async {
    Database dbDevices = await db;
    List<Map> maps = await dbDevices.query(devicesTable,
        columns: [
          idaparelhoColumn,
          tipoColumn,
          modeloColumn,
          memoriaColumn,
          corColumn,
          custoColumn,
          numerodeserieColumn,
          bateriaColumn
        ],
        where: "$idaparelhoColumn = ?",
        whereArgs: [idaparelho]);
    if (maps.length > 0) {
      return Devices.fromMap(maps.first);
    }
    // quando usamos o else retunr null, o código apresenta erro pelo fator de não ser anulavel a classe.
    throw Exception('null'); //else  {
    //return null;
    //}
  }

  // Nessa função deletamos um Device
  Future<int> deleteDevices(int idaparelho) async {
    Database dbDevices = await db;
    return await dbDevices.delete(devicesTable,
        where: '$idaparelhoColumn = ?', whereArgs: [idaparelho]);
  }

  // Nessa função editamos um Device
  Future<int> updateDevices(Devices devices) async {
    Database dbDevices = await db;
    return await dbDevices.update(
        devicesTable, devices.toMap().toString() as dynamic,
        where: '$idaparelhoColumn = ?', whereArgs: [devices.idaparelho]);
  }

  Future<List> getAllDevices() async {
    Database dbDevices = await db;
    List listMap = await dbDevices.rawQuery('SELECT * FROM $devicesTable');
    List<Devices> listDevices = [];
    for (Map m in listMap) {
      listDevices.add(Devices.fromMap(m));
    }
    return listDevices;
  }

  // Future<int> getNumber() async {
  //   Database dbDevices = await db;
  //     return Sqflite.firstIntValue(
  //         await dbDevices.rawQuery('SELECT COUNT(*) FROM $devicesTable'));
  // }

  Future close() async {
    Database dbDevices = await db;
    dbDevices.close();
  }
}

// Aqui foi criado a classe do meu device, onde foi apresentado todos atributos
class Devices {
  int? idaparelho;
  String? tipo;
  late String modelo;
  late String memoria;
  late String cor;
  late String custo;
  late String numerodeserie;
  late String bateria;

  Devices();

  // Para passagem para o banco de dados será utizado o formato map, aqui criamos o construtor MAP para classe device.
  Devices.fromMap(Map map) {
    idaparelho = map[idaparelhoColumn];
    tipo = map[tipoColumn];
    modelo = map[modeloColumn];
    memoria = map[memoriaColumn];
    cor = map[corColumn];
    custo = map[custoColumn];
    numerodeserie = map[numerodeserieColumn];
    bateria = map[bateriaColumn];
  }

  // Estamos construindo nosso mapa, colocando os dados dentro das colunas.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      tipoColumn: tipo,
      modeloColumn: modelo,
      memoriaColumn: memoria,
      corColumn: cor,
      custoColumn: custo,
      numerodeserieColumn: numerodeserie,
      bateriaColumn: bateria
    };
    if (idaparelho != null) {
      map[idaparelhoColumn] = idaparelho;
    }
    return map;
  }

  @override
  String toString() {
    return 'Device(Tipo: $tipo, Modelo: $modelo, Memoria: $memoria, Cor: $cor, Custo: $custo, NS: $numerodeserie, Porcetagem bateria: $bateria) ';
  }
}
