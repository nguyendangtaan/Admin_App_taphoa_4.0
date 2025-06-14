import 'package:admin_app/inner_screens/add_prod.dart';
import 'package:admin_app/responsive.dart';
import 'package:admin_app/services/global_method.dart';
import 'package:admin_app/services/utils.dart';
import 'package:admin_app/widgets/buttons.dart';
import 'package:admin_app/widgets/grid_products.dart' show ProductGrid;
import 'package:admin_app/widgets/header.dart';
import 'package:admin_app/widgets/orders_list.dart';
import 'package:admin_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_app/controllers/MyMenuController.dart';

import '../consts/constants.dart' show defaultPadding;


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Utils(context).color;
    return SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<MyMenuController>().controlDashboarkMenu();
              },
              title: 'Dashboard',
            ),
            TextWidget(text: 'Lastest Products', color: color),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ButtonsWidget(
                    onPressed: () {},
                    text: 'View All',
                    icon: Icons.store,
                    backgroundColor: Colors.white,


                  ),
                  Spacer(),
                  ButtonsWidget(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const UploadProductForm(),
                          )
                      );
                    },
                    text: ' Add Product',
                    icon: Icons.add,
                    backgroundColor: Colors.white,


                  )
                  ]
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children:  [
                      Responsive(
                        mobile: ProductGrid(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                        ),
                        desktop: ProductGrid(
                          childAspectRatio: 0.75,

                        ),
                        ),
                      const OrdersList(),


                      // MyProductsHome(),
                      // SizedBox(height: defaultPadding),
                      // OrdersScreen(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
