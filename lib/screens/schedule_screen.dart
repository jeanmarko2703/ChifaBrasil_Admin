import 'package:chifabrasil_admin/providers/providers.dart';
import 'package:chifabrasil_admin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/schedule_service.dart';
import '../widgets/widgets.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Day> schedule = [];
  final List<String> days = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1));

    // _ordersList.clear();
    WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
      final scheduleService =
          Provider.of<ScheduleService>(context, listen: false);

      setState(() {
        scheduleService.loadSchedule();
        schedule = scheduleService.schedules;
      });
    });
  }

  String evaluateNumberToString(int number) {
    return number < 10 ? '0' + number.toString() : number.toString();
  }

  @override
  void initState() {
    onRefresh();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scheduleService = Provider.of<ScheduleService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Horario'),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
              ),
              Expanded(
                child: scheduleService.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primary,
                        ),
                      )
                    : ListView.builder(
                        itemCount: schedule.length,
                        itemBuilder: (BuildContext context, int index) {
                          
                          return DaySchedule(
                            
                            day: days[index],
                            number:schedule[index].number,
                            dayId: schedule[index].id.toString(),
                            openHour: evaluateNumberToString(
                                schedule[index].hourOpen),
                            openMin:
                                evaluateNumberToString(schedule[index].minOpen),
                            closeMin: evaluateNumberToString(
                                schedule[index].minClose),
                            closeHour: evaluateNumberToString(
                                schedule[index].hourClose),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DaySchedule extends StatelessWidget {
  const DaySchedule({
    Key? key,
    required this.day,
    required this.openHour,
    required this.openMin,
    required this.closeHour,
    required this.closeMin, required this.dayId, required this.number,
  }) : super(key: key);
  final String dayId;
  final String day;
  final String openHour;
  final String openMin;
  final String closeHour;
  final String closeMin;
  final int number;

  @override
  Widget build(BuildContext context) {
    final scheduleForm= Provider.of<ScheduleFormProvider>(context);
    final scheduleService =
          Provider.of<ScheduleService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  elevation: 5,
                  title: Center(child: Text(day)),
                  content: Form(
                    key:scheduleForm.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Hora de abir:'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecorationsBorderRadious
                                    .authInputDecoration(hintText: openHour),
                                    onChanged: (value){ scheduleForm.number=number;
                                    scheduleForm.openHour=int.parse(value);},
                                validator: (value) {
                                  return (value != null &&
                                          value.length >= 1 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) < 24 && scheduleForm.openHour<scheduleForm.closeHour)
                                      ? null
                                      : 'no valido';
                                },
                              ),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecorationsBorderRadious
                                    .authInputDecoration(hintText: openMin),
                                    onChanged: (value)=>scheduleForm.openMin=int.parse(value),
                                validator: (value) {
                                  return (value != null &&
                                          value.length >= 1 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) < 60)
                                      ? null
                                      : 'no valido';
                                },
                              ),
                            ),
                          ],
                        ),
                        Text('Hora de cerrado:'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecorationsBorderRadious
                                    .authInputDecoration(hintText: closeHour),
                                    onChanged: (value)=>scheduleForm.closeHour=int.parse(value),
                                validator: (value) {
                                  return (value != null &&
                                          value.length >= 1 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) < 24 &&  scheduleForm.closeHour>scheduleForm.openHour)
                                      ? null
                                      : 'no valido';
                                },
                              ),
                            ),
                            Text(':'),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecorationsBorderRadious
                                    .authInputDecoration(hintText: closeMin),
                                    onChanged: (value){
                                     
                                      scheduleForm.closeMin=int.parse(value);},
                                validator: (value) {
                                  return (value != null &&
                                          value.length >= 1 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) >= 0 &&
                                          int.parse(value) < 60)
                                      ? null
                                      : 'no valido';
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: ElevatedButton(
                              onPressed: () {

                                if(scheduleForm.isValidForm()){
                                  
                                  print('el dia es');
                                  print(number);
                                  scheduleService.changeSchedule(dayId, scheduleForm.finalDay);
                                  scheduleService.loadSchedule();
                                  Navigator.pushReplacementNamed(context, 'navigationScreen');
                                }

                               




                              }, child:  Text(scheduleService.isLoading?'cargando...':'Cambiar horario')),
                        )
                      ],
                    ),
                  ));
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$day:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              height: 40,
              width: 180,
              child: Center(
                  child: Text(
                '$openHour:$openMin - $closeHour:$closeMin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
