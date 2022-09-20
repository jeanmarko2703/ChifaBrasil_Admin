
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class OrangeButton extends StatelessWidget {
  const OrangeButton({
    Key? key,
    required this.texto,
    required this.ontap
  }) : super(key: key);
  final String texto;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: GestureDetector(
        onTap: () =>ontap() ,
        child: Card(
          color: AppTheme.primary,
          shadowColor: Colors.black.withOpacity(0.5),
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  texto,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
