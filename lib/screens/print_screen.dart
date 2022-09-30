import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:chifabrasil_admin/models/arguments_print.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';



import 'package:esc_pos_utils/esc_pos_utils.dart';

import '../models/models.dart';
class PrintScreen extends StatefulWidget {
   
  const PrintScreen({Key? key}) : super(key: key);

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  
  
  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices=[];
  String _devicesMsg='';
  BluetoothManager bluetoothManager= BluetoothManager.instance;
  
   void initState() {
    if (Platform.isAndroid) {
      bluetoothManager.state.listen((val) {
        print('state = $val');
        if (!mounted) return;
        if (val == 12) {
          print('on');
          initPrinter();
        } else if (val == 10) {
          print('off');
          setState(() => _devicesMsg = 'Bluetooth Disconnect!');
        }
      });
    } else {
      initPrinter();
    }

    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    final ArgumentsPrint orderFinal = ModalRoute.of(context)!.settings.arguments as ArgumentsPrint;
    return  Scaffold(
      body: _devices.isEmpty?Center(child: Text(_devicesMsg),) :ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, i){
          return ListTile( onTap: () => _startPrint(_devices[i], orderFinal), title: Text(_devices[i].name.toString()), );
        })
      
    );
  }
















  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }
  Future<void> _startPrint(PrinterBluetooth printer, ArgumentsPrint orderFinal) async {
    _printerManager.selectPrinter(printer);
    final result = await _printerManager.printTicket(await _ticket(PaperSize.mm80, orderFinal));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(result.msg),
      ),
    );
  }
  

  Future<Ticket> _ticket(PaperSize paper, ArgumentsPrint orderFinal) async {

    
    final ticket = Ticket(paper);
    double total=0;
    ticket.text('Chifa Brasil', styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2 , width: PosTextSize.size2  ));
    ticket.text('');
    ticket.text('');
    ticket.text('Fecha del pedido: '+orderFinal.order.date);
    ticket.text('Cliente: '+ orderFinal.order.userName);
    ticket.text('Numero de telefono: '+orderFinal.order.phone.toString());
    ticket.text('Metodo: '+orderFinal.order.paymentMethod);
    ticket.text('Direccion:'+orderFinal.order.street);
    ticket.text('Numero de casa o dpt:'+orderFinal.order.houseNumber);
    ticket.text('');
    ticket.text('');
    ticket.text('Lista de pedidos:');
    for(int i=0; i<orderFinal.dishes.length;i++){
      
      total=total+ (orderFinal.dishes[i].price*orderFinal.dishes[i].quantity!);
      ticket.text('- '+orderFinal.dishes[i].name);
      ticket.text('S/.'+orderFinal.dishes[i].price.toString() +' x '+orderFinal.dishes[i].quantity.toString());
      if(orderFinal.dishes.length-1==i)
      {ticket.text('Total: '+ total.toString());}
      

    }
    ticket.text('');
    ticket.text('');
    // int total = 0;

    

    return ticket;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }



}