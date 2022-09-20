import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../routes/app_route.dart';
import '../theme/app_theme.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;
    final menuOption = AppRoute.menuOption;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child:  ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: BottomNavigationBar(
            
            onTap: (int i) {
              if (currentIndex != i) {
                uiProvider.selectedMenuOpt = i;
                // Navigator.pushNamed(context, menuOption[i].route);
              }
              return null;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            elevation: 0,
            selectedItemColor: AppTheme.primary.withOpacity(0.8),
            unselectedItemColor: AppTheme.secondColor,
            items: const <BottomNavigationBarItem>[
              
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: 'Inicio',
                  backgroundColor: Colors.red),
              // BottomNavigationBarItem(
              //     icon: Icon(
              //       Icons.receipt_long_rounded,
              //       size: 30,
              //     ),
              //     label: 'Pedidos',
              //     backgroundColor: AppTheme.backgroundColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.schedule_rounded,
                    size: 30,
                  ),
                  label: 'Horarios',
                  backgroundColor: AppTheme.backgroundColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dining_sharp,
                    size: 30,
                  ),
                  label: 'Carta',
                  backgroundColor: AppTheme.backgroundColor),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.attach_money_rounded,
                //     size: 30,
                //   ),
                //   label: 'Ventas',
                //   backgroundColor: AppTheme.backgroundColor),
            ],
          ),
        ),)
      
    );
  }
}
