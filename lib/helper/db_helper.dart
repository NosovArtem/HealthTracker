import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';

import '../model/medical_record.dart';

class DatabaseHelper {
  static const databaseName = "MedicalCards2.db";
  static const _databaseVersion = 1;

  static const tableRecords = 'records';
  static const recordsColumnId = 'med_rec_id';
  static const recordsColumnUserId = 'user_id';
  static const recordsColumnType = 'type';
  static const recordsColumnDate = 'date';
  static const recordsColumnNote = 'note';

  static const tableLabTests = 'lab_tests';
  static const labTestsColumnTestName = 'test_name';
  static const labTestsColumnResult = 'result';

  static const tableDiagnosis = 'diagnosis';
  static const diagnosisColumnName = 'name';

  static const tablePhysicalExams = 'physical_exams';
  static const physicalExamsColumnHeight = 'height';
  static const physicalExamsColumnWeight = 'weight';

  static const tableSymptoms = 'symptoms';
  static const symptomsColumnId = 'symptoms_id';
  static const symptomsColumnSymptom = 'symptom';

  static const tableVaccines = 'vaccines';
  static const vaccinesColumnName = 'name';

  static const tableVitalInfo = 'vital_info';
  static const vitalInfoColumnTemperature = 'temperature';
  static const vitalInfoColumnHeartPulse = 'heart_pulse';
  static const vitalInfoColumnBloodPressure = 'blood_pressure';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableRecords (
      $recordsColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $recordsColumnUserId INTEGER,
      $recordsColumnType TEXT,
      $recordsColumnDate DATE,
      $recordsColumnNote TEXT
    ); ''');

    await db.execute('''
    CREATE TABLE $tableDiagnosis (
      $recordsColumnId INTEGER PRIMARY KEY,
      $diagnosisColumnName TEXT,
      FOREIGN KEY ($recordsColumnId) REFERENCES $tableRecords($recordsColumnId) ON DELETE CASCADE
    ); ''');

    await db.execute('''
    CREATE TABLE $tableLabTests (
      $recordsColumnId INTEGER PRIMARY KEY,
      $labTestsColumnTestName TEXT,
      $labTestsColumnResult TEXT,
      FOREIGN KEY ($recordsColumnId) REFERENCES $tableRecords($recordsColumnId) ON DELETE CASCADE
    ); ''');

    await db.execute('''
    CREATE TABLE $tablePhysicalExams (
      $recordsColumnId INTEGER PRIMARY KEY,
      $physicalExamsColumnHeight TEXT,
      $physicalExamsColumnWeight TEXT,
      FOREIGN KEY ($recordsColumnId) REFERENCES $tableRecords($recordsColumnId) ON DELETE CASCADE
    ); ''');

    await db.execute('''
    CREATE TABLE $tableSymptoms (
      $symptomsColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $recordsColumnId INTEGER,
      $symptomsColumnSymptom TEXT,
      FOREIGN KEY ($recordsColumnId) REFERENCES $tableRecords($recordsColumnId) ON DELETE CASCADE
    ); ''');

    await db.execute('''
    CREATE TABLE $tableVaccines (
      $recordsColumnId INTEGER PRIMARY KEY,
      $vaccinesColumnName TEXT,
      FOREIGN KEY ($recordsColumnId) REFERENCES $tableRecords($recordsColumnId) ON DELETE CASCADE
    ); ''');

    await db.execute('''
    CREATE TABLE $tableVitalInfo (
      $recordsColumnId INTEGER PRIMARY KEY,
      $vitalInfoColumnTemperature TEXT,
      $vitalInfoColumnHeartPulse TEXT,
      $vitalInfoColumnBloodPressure TEXT,
      FOREIGN KEY ($recordsColumnId) REFERENCES $tableRecords($recordsColumnId) ON DELETE CASCADE
    );
  ''');
  }

  Future<int> insert(MedicalRecord record) async {
    final Database db = await instance.database;
    final recordId = await db.insert(tableRecords, record.toMapBaseRecord());
    final String recordType = record.type.name;

    final Map<String, String> tableMapping = {
      'diagnosis': tableDiagnosis,
      'labTest': tableLabTests,
      'symptom': tableSymptoms,
      'vaccine': tableVaccines,
      'vitalInfo': tableVitalInfo,
      'physicalExam': tablePhysicalExams,
    };

    final String? targetTable = tableMapping[recordType];

    if (targetTable == null) {
      throw ArgumentError('Неизвестный тип записи: $recordType');
    }

    return await db.insert(targetTable, record.toMapAdditionalPart(recordId));
  }

  Future<int> update(MedicalRecord record) async {
    final Database db = await instance.database;
    await db.update(tableRecords, record.toMapBaseRecord(id: record.id),
        where: 'med_rec_id = ?', whereArgs: [record.id]);
    final String recordType = record.type.name;

    final Map<String, String> tableMapping = {
      'diagnosis': tableDiagnosis,
      'labTest': tableLabTests,
      'symptom': tableSymptoms,
      'vaccine': tableVaccines,
      'vitalInfo': tableVitalInfo,
      'physicalExam': tablePhysicalExams,
    };

    final String? targetTable = tableMapping[recordType];

    if (targetTable == null) {
      throw ArgumentError('Неизвестный тип записи: $recordType');
    }

    return await db.update(targetTable, record.toMapAdditionalPart(record.id),
        where: 'med_rec_id = ?', whereArgs: [record.id]);
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    var delete = db
        .delete(tableRecords, where: recordsColumnId + ' = ?', whereArgs: [id]);
    return await delete;
  }

  Future<List<MedicalRecord>> getAllRecords() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> diagnosisRecords = await db.rawQuery('''
      SELECT * FROM $tableRecords
      JOIN $tableDiagnosis
      ON $tableRecords.$recordsColumnId = $tableDiagnosis.$recordsColumnId
    ''');
    List<Map<String, dynamic>> labTestRecords = await db.rawQuery('''
      SELECT * FROM $tableRecords
      JOIN $tableLabTests
      ON $tableRecords.$recordsColumnId = $tableLabTests.$recordsColumnId
    ''');
    List<Map<String, dynamic>> physicalExamRecords = await db.rawQuery('''
      SELECT * FROM $tableRecords
      JOIN $tablePhysicalExams
      ON $tableRecords.$recordsColumnId = $tablePhysicalExams.$recordsColumnId
    ''');
    List<Map<String, dynamic>> vitalInfoRecords = await db.rawQuery('''
      SELECT * FROM $tableRecords
      JOIN $tableVitalInfo
      ON $tableRecords.$recordsColumnId = $tableVitalInfo.$recordsColumnId
    ''');
    List<Map<String, dynamic>> symptomsRecords = await db.rawQuery('''
      SELECT * FROM $tableRecords
      JOIN $tableSymptoms
      ON $tableRecords.$recordsColumnId = $tableSymptoms.$recordsColumnId
    ''');
    List<Map<String, dynamic>> vaccinesRecords = await db.rawQuery('''
      SELECT * FROM $tableRecords
      JOIN $tableVaccines
      ON $tableRecords.$recordsColumnId = $tableVaccines.$recordsColumnId
    ''');

    List<Map<String, dynamic>> combinedRecordsFinal = diagnosisRecords +
        physicalExamRecords +
        vitalInfoRecords +
        symptomsRecords +
        vaccinesRecords +
        labTestRecords;
    return List.generate(combinedRecordsFinal.length, (i) {
      return MedicalRecord.fromMap(combinedRecordsFinal[i]);
    });
  }

  // --------------------------------------------------------

  Future<void> backup(String destinationPath) async {
    Fluttertoast.showToast(msg: 'Экспорт базы данных начат...');
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String sourcePath = join(appDocDir.path,
        join(await getDatabasesPath(), DatabaseHelper.databaseName));

    try {
      await _database?.close();
      final destinationDirectory = Directory(destinationPath);
      if (!destinationDirectory.existsSync()) {
        destinationDirectory.createSync(recursive: true);
      }
      requestPermissions();
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('yyyy_MM_dd_HH_mm').format(now);
      final sourceFile = File(sourcePath);
      final destinationFile = File(
          join(destinationPath, '${formattedDateTime}_backup_database.db'));
      await sourceFile.copy(destinationFile.path);

      shareFile(destinationFile.path);
      await _initDatabase();
      print(
          'Резервная копия базы данных успешно сохранена в: ${destinationFile.path}');
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Ошибка при создании резервной копии базы данных: $e',
          backgroundColor: Colors.red);
      print('Ошибка при создании резервной копии базы данных: $e');
    }
  }

  void shareFile(String filePath) {
    Share.shareFiles([filePath], text: 'Поделиться файлом');
  }

  Future<void> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> restore(String dumpFilePath) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path,
        join(await getDatabasesPath(), DatabaseHelper.databaseName));

    final backupFile = File(dumpFilePath);
    await backupFile.copy(databasePath);

    final newDatabaseFile = File(databasePath);
    if (await newDatabaseFile.exists()) {
      Fluttertoast.showToast(
          msg: 'База данных успешно восстановлена из бэкапа.');
    } else {
      Fluttertoast.showToast(
          msg: 'Ошибка восстановления базы данных из бэкапа.',
          backgroundColor: Colors.red);
    }
  }
}
