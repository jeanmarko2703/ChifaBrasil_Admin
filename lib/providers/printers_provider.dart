import 'package:chifabrasil_admin/providers/providers.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class PrinterListProvider extends ChangeNotifier {
  List<String> printers = [];
 

  PrinterListProvider() {
    loadPrinters();
    
  }

  
 

  newPrinter(String printerAddress) async {
    
    bool search= await searchPrinterById(printerAddress);

    if( !search ){
      DBProvider.db.updatePrinterSelection(printerAddress);
      
        printers.add(printerAddress);
       
      }
       notifyListeners();

    
    
  }
  Future<bool> searchPrinterById(String address) async {
    final printersLoaded = await DBProvider.db.printers();
    bool found=false;
    printersLoaded.forEach((element) {
      if(element.address==address){
        found=true;
       
      }
      
    });

    print('el valor es:');
    print(found);

    return found;
    
    
  }

  loadPrinters() async {
    
    final printersLoaded = await DBProvider.db.printers();
    printers = List.from(printersLoaded);

    notifyListeners();
  }

 

}