
import 'package:flutter/material.dart';


import '../models/models.dart';



class DishesBuilder extends StatelessWidget {
  const DishesBuilder({
    Key? key,
    required this.dish, required this.catId,
  }) : super(key: key);
  final Dish dish;
  final String catId;

  

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 50,
        child: GestureDetector(
          onTap: () => showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return DishDetail(
                  dishInfo: dish, catId: catId,
                );
              }),
          child: Card(
              shadowColor: Colors.black.withOpacity(0.5),
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                        dish.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                  ),
                ),
              )),
        ),
      
    );
  }
}

class DishDetail extends StatefulWidget {
  
  const DishDetail({
    Key? key,
    required this.dishInfo, required this.catId
    
    
  }) : super(key: key);
  

  final Dish dishInfo;
  final String catId;

  @override
  State<DishDetail> createState() => _DishDetailState();
  
}

class _DishDetailState extends State<DishDetail> {
  

  int amount = 1;
  void _incrementCount() {
    setState(() {
      amount++;
    });
  }

  void _decrementCount() {
    setState(() {
      if (amount <= 1) return;
      amount--;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      
      contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
      // insetPadding: EdgeInsets.symmetric(vertical: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 5,
      title: Text(
        widget.dishInfo.name,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Descripción:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(widget.dishInfo.description.toString().toLowerCase()),
          const SizedBox(
            height: 20,
          ),
          Row(children: [const Text(
            'Precio:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10,),
          Text('S/.'+widget.dishInfo.price.toString().toLowerCase()),],)
          
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
              onPressed: () {
                Navigator.pushNamed(context, 'addDishScreen', arguments:Arguments(widget.catId, widget.dishInfo));
                
                

              },
                  
              child: const Text('Editar'),
            ),
          ),
        ),
      ],
    );
  }
}
