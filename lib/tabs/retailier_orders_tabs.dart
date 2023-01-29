import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RetailerOrdersTabs extends StatefulWidget {
  const RetailerOrdersTabs({super.key});

  @override
  State<RetailerOrdersTabs> createState() => _RetailerOrdersTabsState();
}

class _RetailerOrdersTabsState extends State<RetailerOrdersTabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Order Hitory"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
    );
  }
}
