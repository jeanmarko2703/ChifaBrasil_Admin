import 'package:chifabrasil_admin/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categoriesList = [];
  List<Category> allCategories = [];
 @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
      final categoriesService =
          Provider.of<CategoriesService>(context, listen: false);

      setState(() {
        allCategories = _categoriesList = categoriesService.categories;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final categoriesService = Provider.of<CategoriesService>(context);
    
    final size = MediaQuery.of(context).size;
    
    void search(value) {
      setState(() {
        value = value.toUpperCase();

        _categoriesList = allCategories.where((category) {
          var categoryName = category.name.toUpperCase();

          return categoryName.contains(value);
        }).toList();
      });
      print(_categoriesList.length);
    }
    
    void noSearch() {
      setState(() {
        _categoriesList = allCategories;
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Categorías')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: CupertinoSearchTextField(
                onChanged: (value) => {
                  if (value.isNotEmpty) {search(value)} else {noSearch()}
                },
                onSubmitted: null,
                borderRadius: BorderRadius.circular(30),
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10),
              ),
            ),
            Expanded(
                child: categoriesService.isLoading
                    ? Center(child: CircularProgressIndicator(color: AppTheme.primary,))
                    : SizedBox(
                        
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: _categoriesList.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: size.width * 0.5,
                                        childAspectRatio: size.height * 0.0011,
                                        crossAxisSpacing: size.width * 0.025,
                                        mainAxisSpacing: 0),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return CategoriesBuilder(
                                    category: _categoriesList[index],
                                  );
                                },
                              )
                            
                      ))
          ]),
        ),
      ),
    );
  }
}
