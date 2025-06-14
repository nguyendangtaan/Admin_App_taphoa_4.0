
import 'package:admin_app/controllers/MyMenuController.dart';
import 'package:admin_app/responsive.dart';
import 'package:admin_app/widgets/grid_products.dart';
import 'package:admin_app/widgets/header.dart';
import 'package:admin_app/widgets/orders_list.dart';
import 'package:admin_app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MyMenuController>().getOrdersScaffoldKey,
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
                controller: ScrollController(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Header(
                        fct: (){
                          context.read<MyMenuController>().controlALLOrder();

                        },
                      title: 'ALL Orders',
                    ),
                   SizedBox(
                     height: 20,
                   ),
                   const Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: const OrdersList(),
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
