import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/tab_pages/distributortab/active_distributor.dart';
import 'package:order_management/tab_pages/distributortab/complete_distributor.dart';
import 'package:order_management/tab_pages/retailertab/active_retailers.dart';
import 'package:order_management/tab_pages/retailertab/completed_retailer.dart';
import 'package:order_management/tab_pages/sales/active_sales_order.dart';
import 'package:order_management/tab_pages/sales/complete_sales_order.dart';

class SalesrOrdersTab extends StatefulWidget {
  const SalesrOrdersTab({super.key});

  @override
  State<SalesrOrdersTab> createState() => _SalesrOrdersTabState();
}

class _SalesrOrdersTabState extends State<SalesrOrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple,
            title: const Text('Order History'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Active",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    "Completed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ActiveSalesOrders(
                Uuid: "",
              ),
              CompletedSalesOrders()
            ],
          ),
        ),
      ),
    );
  }
}
