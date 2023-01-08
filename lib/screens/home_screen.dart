import 'package:chifabrasil_admin/services/orders_service.dart';
import 'package:chifabrasil_admin/services/services.dart';
import 'package:chifabrasil_admin/theme/app_theme.dart';
import 'package:chifabrasil_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int status=1;
  void hola(){}
  
  void pendiente() {
    setState(() {
      status=1;
      onRefresh('PENDIENTE');
    });

  }
  void cocina() {
     setState(() {
      status=2;
      onRefresh('EN CAMINO');
    });


  }
  void enviado() {
     setState(() {
      status=3;
       onRefresh('ENTREGADO');
    });

  }
  Future<void> onRefresh(String status) async {
    await Future.delayed(const Duration(milliseconds: 1));
    
      // _ordersList.clear();
      WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
        final ordersService =
            Provider.of<OrdersService>(context, listen: false);
       
        setState(() {
          ordersService.clearOrders();
          
          ordersService.loadOrdersToday(status);
          
          print('hola');
         
          

        });
         
      
    });
    
  }
  @override
  void initState() {
    // TODO: implement initState
    
    onRefresh('PENDIENTE');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ordersService= Provider.of<OrdersService>(context);
    final menuService= Provider.of<MenuService>(context);
    List<Order> orders=ordersService.orders;
    final List<String>statusList=['Pendientes', 'En camino','Entregados'];
    
    return Scaffold(
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: size.width,
                  height: 10,
                ),
                const Text(
                  'Chifa Brasil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                    onPressed: () async {

                      


                      bool pass= await  menuService.updateMenuOpen();

                     if(pass){

                      showDialog(context: context, builder:(context)=> AlertDialog(
                        
                        title: Text('Se abrió el menú'),
                        actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Volver'))],
                      ));

                     }

                    },
                    child: const Text(
                      'Abrir Menú',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    SizedBox(width: 10,),
                    ElevatedButton(
                    onPressed: () async {

                      bool pass= await  menuService.updateMenuClose();

                     if(pass){

                      showDialog(context: context, builder:(context)=> AlertDialog(
                        
                        title: Text('Se cerró el menú'),
                        actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Volver'))],
                      ));

                     }

                    },
                    child: const Text(
                      'Cerrar Menú',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Pedidos Totales:',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      orders.length.toString() ,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: pendiente,
                    child: Text(
                        'Pendientes',
                        style:status==1?AppTheme.statusActiveStyle:AppTheme.statusStyle,
                      ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: cocina,
                    child: Text(
                        'En camino',
                        style:status==2?AppTheme.statusActiveStyle:AppTheme.statusStyle,
                      ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: enviado,
                    child: Text(
                        'Entregados',
                        style:status==3?AppTheme.statusActiveStyle:AppTheme.statusStyle,
                      ),
                  ),
                ],
              ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(child:

                ordersService.isLoading?Center(child: CircularProgressIndicator(color: AppTheme.primary,),):
                orders.isNotEmpty? ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderCard(order: orders[index], orderService: ordersService);
                  },
                ):Center(child:Column( mainAxisSize: MainAxisSize.min, children: [Icon(Icons.no_food_rounded, size: 50,),SizedBox(height: 10,),Text('No hay pedidos '+ statusList[status-1].toLowerCase() +' el día de hoy', style: TextStyle(fontWeight: FontWeight.bold),)],))
                
                 )

                
              ]),
        ),
      ),
      
    );
  }

  
}

  

