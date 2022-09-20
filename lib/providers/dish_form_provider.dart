import 'package:chifabrasil_admin/models/models.dart';
import 'package:flutter/cupertino.dart';

class DishFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = '';
  String description= '';
  double price=0.0;
  Dish dish=Dish(name: '', price: 0.0,description: '');
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    dish.name=name.toUpperCase();
    dish.price=price;
    dish.description=description.toUpperCase();
    print(formKey.currentState?.validate());
    print('$name-$description-$price');
    return formKey.currentState?.validate() ?? false;
  }
}
