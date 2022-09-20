import 'package:chifabrasil_admin/models/models.dart';
import 'package:flutter/cupertino.dart';

class ScheduleFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int number=0;
  int openHour = 0;
  int openMin= 0;
  int closeHour = 0;
  int closeMin= 0;
  Day finalDay= Day(minClose: 0, hourClose: 0, hourOpen: 0, minOpen: 0, number: 0);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    finalDay.number=number;
    finalDay.hourOpen=openHour;
    finalDay.minOpen=openMin;
    finalDay.hourClose=closeHour;
    finalDay.minClose=closeMin;
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
