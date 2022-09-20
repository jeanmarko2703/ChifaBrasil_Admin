import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import '../widgets/order_card_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders =[];
  Future<void> onRefresh(String status) async {
    await Future.delayed(const Duration(milliseconds: 1));
    
      // _ordersList.clear();
      WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
        final ordersService =
            Provider.of<OrdersService>(context);
       
        setState(() {
          ordersService.clearOrders();
          
          ordersService.loadOrders();
          orders=ordersService.orders;

        });
         
      
    });
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrdersService>(context);
    
     

    return Scaffold(
        appBar: AppBar(title: Text('Pedidos')),
        body: Column(
          children: [
            Expanded(
                child: ordersService.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primary,
                        ),
                      )
                    : orders.isNotEmpty
                        ? ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OrderCard(
                                  order: orders[index],
                                  orderService: ordersService);
                            },
                          )
                        : Center(
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.no_food_rounded,
                                size: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'No hay pedidos ' ,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ))),
          ],
        ));
  }
}
