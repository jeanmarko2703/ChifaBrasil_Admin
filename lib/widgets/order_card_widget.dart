
import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key? key,
    required this.order,
    required this.orderService,
  }) : super(key: key);
  final Order order;
  final OrdersService orderService;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'orderDetailsScreen',
          arguments: widget.order),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: widget.order.status.toLowerCase() == 'pendiente'
                            ? AppTheme.secondColor
                            : widget.order.status.toLowerCase() == 'en camino'
                                ? Colors.yellow[700]
                                : Colors.green[400],
                      ),
                      height: 40,
                      child: Center(
                        child: Text(
                          widget.order.status.toLowerCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text('Dirección : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                              widget.order.street +
                                  '-' +
                                  widget.order.houseNumber,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text('Fecha : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.order.date),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Metodo de pago: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.order.paymentMethod)
                          ],
                        )),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
