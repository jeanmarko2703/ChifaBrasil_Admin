import 'package:chifabrasil_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/direction.dart';
import '../models/models.dart';
import '../providers/location_provider.dart';
import '../services/orders_service.dart';
import '../theme/app_theme.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initialization();
    _origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Restaurante chifa brasil'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: LatLng(-12.089701945194658, -77.06618884596112),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context)!.settings.arguments as Order;

    final _initialCameraPosition = CameraPosition(
      target: LatLng(order.lat, order.lng),
      zoom: 16,
    );

    final ordersService = Provider.of<OrdersService>(context, listen: false);
    _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Ubicación de envío'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: LatLng(order.lat, order.lng));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 300,
            child: GoogleMap(
              markers: {_origin!, _destination!},
              polylines: {
                if (_info?.totalDistance != null)
                  Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.blue,
                      width: 5,
                      points: _info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList())
              },
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Pedido realizado el: ' + order.date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Estado del pedido: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(order.status.toLowerCase())
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Dirección: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(order.street)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Número de dpto o casa: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(order.houseNumber)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Metodo de pago: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(order.paymentMethod)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Nota: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(order.note)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OrangeButton(
                texto: 'Cambiar estado de pedido',
                ontap: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return StatusDialog(idOrder:order.id.toString());
                      });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Lista de pedidos: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          FutureBuilder(
            future: ordersService.loadDishOrders(order.id.toString()),
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
                double total = 0;
                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dishes.length,
                  itemBuilder: (BuildContext context, int index) {
                    total =
                        total + (dishes[index].price * dishes[index].quantity!);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(' - ' + dishes[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('    S/.' +
                              dishes[index].price.toString() +
                              ' x ' +
                              dishes[index].quantity.toString()),
                          dishes.length - 1 == index
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Total: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text('S/.' + total.toString())
                                    ],
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('No se encontraron pedidos'));
              }
              ;
            },
          ),
        ]),
      ),
    );
  }
}

class StatusDialog extends StatefulWidget {
  const StatusDialog({
    Key? key,
    required this.idOrder,
  }) : super(key: key);
  final String idOrder;

  @override
  State<StatusDialog> createState() => _StatusDialogState();
}

class _StatusDialogState extends State<StatusDialog> {
  final List<String> _status = [
    'PENDIENTE',
    'EN CAMINO',
    'ENTREGADO',
    'CANCELADO'
  ];
  String selectedItem = 'PENDIENTE';
  void select(String item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrdersService>(context);
    return AlertDialog(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        // insetPadding: EdgeInsets.symmetric(vertical: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 5,
        title: Text(
          'Cambiar estado:',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Selecciona un estado para el pedido'),
            DropdownButton<String>(
                value: selectedItem,
                items: _status
                    .map((status) => DropdownMenuItem<String>(
                        value: status, child: Text(status)))
                    .toList(),
                onChanged: (item) => select(item ?? 'PENDIENTE')),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  onPressed: () {
                    ordersService.changeStatusOrder(selectedItem, widget.idOrder);
                    Navigator.pushReplacementNamed(context, 'navigationScreen');
                  }
                      ,
                  child: Text('Enviar')),
            )
          ],
        ));
  }
}
