
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class CategoriesContentScreen extends StatefulWidget {
  const CategoriesContentScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesContentScreen> createState() =>
      _CategoriesContentScreenState();
}

class _CategoriesContentScreenState extends State<CategoriesContentScreen> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Category category =
        ModalRoute.of(context)!.settings.arguments as Category;
        Dish newDish = Dish(name: 'Nombre', price: 0.0, description: 'Descripción');

    DishesService dishesService = Provider.of<DishesService>(context, listen: true);

    
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            category.name,
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            
            Padding(
              
              padding: const EdgeInsets.only(right: 20),
              child:IconButton(onPressed: (){ Navigator.pushNamed(context, 'addDishScreen', arguments: Arguments(category.id.toString(), newDish));}, icon: Icon(Icons.add_box_rounded, size: 30,)),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: FutureBuilder(
                future: dishesService.loadDishes(category.id.toString()),
                builder: (_, AsyncSnapshot<List<Dish>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.secondColor,
                      ),
                    );
                  }

                  List<Dish>? dishes = snapshot.data!;

                  if (dishes.isNotEmpty) {
                    return 
                        GridView.builder(
                          padding: EdgeInsets.only(bottom: 25),
                          itemCount: dishes.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: size.width * 0.5,
                                  childAspectRatio: size.height * 0.0016,
                                  crossAxisSpacing: size.width * 0.03,
                                  mainAxisSpacing: size.height * 0.04),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return DishesBuilder(dish: dishes[index], catId: category.id.toString(),);
                          },
                        );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.no_food_rounded,
                              size: 60,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'No se encontraron productos en esta categoría',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ),
        ));
  }
}
