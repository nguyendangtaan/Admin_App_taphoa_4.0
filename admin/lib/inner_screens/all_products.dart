

import 'package:admin_app/controllers/MyMenuController.dart';
import 'package:admin_app/responsive.dart';
import 'package:admin_app/screens/dashboard_screen.dart';
import 'package:admin_app/widgets/grid_products.dart';
import 'package:admin_app/widgets/header.dart';
import 'package:admin_app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MyMenuController>().getgridscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Header(
                        fct: (){
                      context.read<MyMenuController>().controlProductsMenu();
                    },
                      title: 'All Products',
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Responsive(
                      mobile: ProductGrid(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        isMain: false,
                      ),
                      desktop: ProductGrid(
                        childAspectRatio: 0.75,
                        isMain: false,

                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
