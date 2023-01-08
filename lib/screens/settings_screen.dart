import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
   
  const SettingsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Configuración')),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: SingleChildScrollView(

            child: 

              ListTile(
                tileColor: Colors.white,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onTap: (() {
                  Navigator.pushNamed(context, 'printDetectionScreen');
                }),
                title: Text('Seleccionar impresora'),
                trailing: Icon(Icons.print),
              ),
            ),
        ),
        ),
      
    );
  }
}