
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

class CategoriesBuilder extends StatelessWidget {
  const CategoriesBuilder({
    Key? key,
    required this.category,
    // required this.name,
    // required this.url,
  }) : super(key: key);
  final Category category;
  // final String name;
  // final String? url;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return 
      Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, 'categoriesContentScreen',
                  arguments: category),
              child: Card(
                shadowColor: AppTheme.backgroundColor.withOpacity(0.5),
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  height: size.height * 0.17,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
      
    
  }
}
