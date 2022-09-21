import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ui_provider.dart';
import '../routes/app_route.dart';
import '../widgets/custom_navigationbar.dart';



class NavigationScreen extends StatelessWidget {
   
  const NavigationScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    

    
    return Scaffold(
      body: Center(
         child: 
         
         AppRoute.menuOption[currentIndex].screen
         ,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CustomNavigationBar(),
      ),
    );
  }
}