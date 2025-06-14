

import 'package:admin_app/widgets/products_widget.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart' show defaultPadding;

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key,
     this.crossAxisCount=4,
    this.childAspectRatio=1,
    this.isMain=true
    });


  final int crossAxisCount;
  final double childAspectRatio;
   final bool isMain;



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics:const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: isMain? 4:20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: defaultPadding,
          crossAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
           ),
      itemBuilder: (context, index) => ProductWidget(),
    );
  }
}
