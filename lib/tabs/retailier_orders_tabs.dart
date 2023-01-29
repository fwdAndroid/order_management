import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/tab_pages/retailertab/active_retailers.dart';
import 'package:order_management/tab_pages/retailertab/completed_retailer.dart';

class RetailerOrdersTabs extends StatefulWidget {
  const RetailerOrdersTabs({super.key});

  @override
  State<RetailerOrdersTabs> createState() => _RetailerOrdersTabsState();
}

class _RetailerOrdersTabsState extends State<RetailerOrdersTabs> {
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
            children: <Widget>[
              ActiveRetailerOrders(),
              CompletedRetailersOrders()
            ],
          ),
        ),
      ),
    );
  }
}
