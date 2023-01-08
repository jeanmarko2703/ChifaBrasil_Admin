import 'package:chifabrasil_admin/models/models.dart';
import 'package:chifabrasil_admin/providers/providers.dart';
import 'package:chifabrasil_admin/services/dishes_service.dart';
import 'package:chifabrasil_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDishScreen extends StatelessWidget {
  const AddDishScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Arguments arguments =
        ModalRoute.of(context)!.settings.arguments == null
            ? Arguments('', Dish(name: '', price: 0, description: ''))
            : ModalRoute.of(context)!.settings.arguments as Arguments;

    final dishForm = Provider.of<DishFormProvider>(context);
    Dish newDish = Dish(name: 'Nombre', price: 0.0, description: 'Descripción');
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            arguments.dish.name == newDish.name
                ? 'Nuevo plato'
                : arguments.dish.name,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        body: SingleChildScrollView(
            child: DishForm(dishForm: dishForm, newDish: newDish)));
  }
}

class DishForm extends StatelessWidget {
  const DishForm({
    Key? key,
    required this.dishForm,
    required this.newDish,
  }) : super(key: key);

  final DishFormProvider dishForm;
  final Dish newDish;
  static String catId = '';
  static String dishId = '';

  @override
  Widget build(BuildContext context) {
    final Dish dishFinal;
    final dishService = Provider.of<DishesService>(context);
    final Arguments arguments =
        ModalRoute.of(context)!.settings.arguments == null
            ? Arguments('', Dish(name: '', price: 0, description: ''))
            : ModalRoute.of(context)!.settings.arguments as Arguments;
    if (arguments.dish.name != newDish.name) {
      dishId = arguments.dish.id.toString();
    }
    catId = catId = arguments.catId.toString();

    if (newDish.name == '') {
      dishFinal = newDish;
    } else {
      dishFinal = arguments.dish;
    }
     dishForm.name= dishFinal.name;
     dishForm.description= dishFinal.description.toString();
     dishForm.price= dishFinal.price.toDouble();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
          key: dishForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue:
                    dishFinal.name == 'Nombre' ? null : dishFinal.name,
                keyboardType: TextInputType.text,
                decoration: InputDecorationsBorderRadious.authInputDecoration(
                    hintText: dishFinal.name),
                onChanged: (value) => dishForm.name = value,
                validator: (value) {
                  return (value != null  && value.length >= 1)
                      ? null
                      : 'El nombre del plato es obligatorio';
                },
              ),
              SizedBox(height: 20),
              Text('Descripción: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: dishFinal.description == 'Descripción'
                    ? null
                    : dishFinal.description,
                minLines: 3,
                maxLines: 5,
                
                keyboardType: TextInputType.text,
                decoration: InputDecorationsBorderRadious.authInputDecoration(
                    hintText: dishFinal.description!),
                onChanged: (value) => dishForm.description = value,
                validator: (value) {
                  return (value != null  && value.length >= 1)
                      ? null
                      : 'La descripción es obligatoria';
                },
              ),
              SizedBox(height: 20),
              Text('Precio: ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: dishFinal.price.toString() == '0.0'
                    ? null
                    : dishFinal.price.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecorationsBorderRadious.authInputDecoration(
                    hintText: dishFinal.price.toString()),
                onChanged: (value) => dishForm.price = double.parse(value),
                validator: (value) {
                  return (value != null  && value.length >= 1)
                      ? null
                      : 'El precio es obligatorio';
                },
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (arguments.dish.name != newDish.name)
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    elevation: 5,
                                    title: Text('Eliminar plato'),
                                    content: Text(
                                        '¿Estás seguro que lo quieres elimnar?'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 252, 17, 0)),
                                              onPressed: () {
                                                dishService.deleteDish(
                                                    catId, dishId);
                                                Navigator.of(context).popUntil(
                                                    (route) => route.isFirst);
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    'navigationScreen');
                                              },
                                              child: Text('Eliminar'))
                                        ],
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Icon(Icons.delete),
                        ),
                      ElevatedButton(
                          onPressed: () {
                            if (dishForm.isValidForm()) {
                              print(dishForm.dish.toMap());
                              if (dishFinal.name!=dishForm.name || dishFinal.description!=dishForm.description || dishFinal.price!=dishForm.price) {
                                if (arguments.dish.name == newDish.name) {
                                  dishService.createDish(catId, dishForm.dish);
                                } else {
                                  dishService.updateDish(
                                      catId, dishForm.dish, dishId);
                                }
                              }

                              dishService.loadDishes(catId);
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacementNamed(
                                  context, 'navigationScreen');
                            }
                          },
                          child: const Text('Guardar')),
                    ],
                  ))
            ],
          )),
    );
  }
}
