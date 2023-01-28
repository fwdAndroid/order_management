import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderPage extends StatefulWidget {
  final String rate, dimension, pcs, productname, uuid;
  final area;
  const OrderPage(
      {super.key,
      required this.dimension,
      required this.area,
      required this.uuid,
      required this.pcs,
      required this.productname,
      required this.rate});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text("Order Page"),
      ),
      backgroundColor: Colors.white,
    );
  }
}
