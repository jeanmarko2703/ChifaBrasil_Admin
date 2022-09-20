import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';



class ScheduleService extends ChangeNotifier {
  final String _baseUrl = 'chifabrasil-app-default-rtdb.firebaseio.com';
  List<Day> schedules=[];



  Day day= Day(minClose: 0, hourClose: 0, hourOpen: 0, minOpen: 0, number: 0);
  bool isLoading = true;
  ScheduleService() {
    loadSchedule();
  }
  bool horario( int hourClose, int minClose, int hourOpen, int minOpen){
  if(hourClose>=DateTime.now().hour && hourOpen<=DateTime.now().hour){
    
    if(hourClose>DateTime.now().hour && hourOpen<DateTime.now().hour)return true;
    
    if( (hourOpen<=DateTime.now().hour&& minOpen<DateTime.now().minute)|| 
       (hourClose>=DateTime.now().hour && minClose>DateTime.now().minute ))return true;
    
    return false;
    
  }else{
    
    return false;
  }
}
  Future loadSchedule() async {
    isLoading = true;
    notifyListeners();
    // final String idToken= await storage.read(key: 'tokenId')??'';
    final url = Uri.https(_baseUrl, 'SCHEDULE.json', );
    final resp = await http.get(url);

    final Map<String, dynamic> categoriesMap = json.decode(resp.body);

    categoriesMap.forEach((key, value) {
      final tempDays = Day.fromMap(value);
      tempDays.id = key;
     
      schedules.clear();
    final Map<String, dynamic> horarioMap =
        json.decode(resp.body) ?? <String, dynamic>{};
    if (horarioMap.isNotEmpty) {
      // print(dishesMap);
      horarioMap.forEach((key, value) {
        final tempSchedule = Day.fromMap(value);
        tempSchedule.id = key;
        
        schedules.add(tempSchedule);
        
      });
    }
      
      
      }
      
    );
    Day aux;
    for(int i=0;i<6;i++){
      for(int j=0; j<6;j++){

        if(schedules[j].number>schedules[j+1].number){

          aux=schedules[j];
          schedules[j]=schedules[j+1];
          schedules[j+1]=aux;



        }


      }
    }
    isLoading=false;
    notifyListeners();
    return day;
  }
  Future<String> changeSchedule(String day, Day schedule) async{

    
    final url = Uri.https( _baseUrl, 'SCHEDULE/$day.json');
    final resp = await http.put( url, body: schedule.toJson());
    final decodedData = json.decode( resp.body );
    
    

    

    print(decodedData);



    return'';
  }
}
