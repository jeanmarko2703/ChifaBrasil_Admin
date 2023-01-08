
import 'dart:convert';
import 'dart:io';

import 'package:chifabrasil_admin/models/printer.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';


class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
  
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'printersDB.db');
    print('el path es: '+path);
   

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          ''' CREATE TABLE Printers(id INTEGER PRIMARY KEY, address TEXT ) ''');
      
    });

  
  }

  Future<int> updatePrinterSelection(String newPrinter) async {
    final db = await database;
    // final res = await db.insert('Printers',{"address":newPrinter} );
    List<Printer>list=await printers();
  
    if(list!=[]){
      final res = await db.rawUpdate('UPDATE Printers SET address = ? WHERE id = 1',[newPrinter]);
      return res;

    }
    else{
      
      final res= await newPrinterFunc(newPrinter);
      return res;

    }

    

   
  }
  Future<int> newPrinterFunc(String newPrinter) async {
    
    final db = await database;
    final res = await db.insert('Printers',{"address":newPrinter} );

    return res;
  }

  Future<List<Printer>> printers() async {
    final db = await database;
    final res = await db.query('Printers');
  
   
    

     return res.isNotEmpty ? res.map((e) => Printer.fromMap(e)).toList() : [];
  }

  // Future<int> deletePrinter(String id) async {
  //   final db = await database;

  //   final res = await db.delete('Projects', where: 'id = ?', whereArgs: [id]);
  //   return res;
  // }

 

}