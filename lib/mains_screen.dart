import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/login_screens/area_sales_login.dart';
import 'package:order_management/login_screens/business_manager_login.dart';
import 'package:order_management/login_screens/distributor_login.dart';
import 'package:order_management/login_screens/ratailer_login.dart';
import 'package:order_management/login_screens/sales_office_login.dart';
import 'package:order_management/login_screens/territory_sales_login.dart';
import 'package:order_management/login_screens/zonal_login.dart';

import 'login_screens/regionalLogin.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            'assets/splash.png',
            height: 250,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => BussinessManagerLogin(
                              bussines: "Business Manager",
                            )));
              },
              leading: Icon(Icons.business),
              title: Text("Bussiness Manager "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => RegionalLogin(
                              regional: "Regional",
                            )));
              },
              leading: Icon(Icons.recycling_outlined),
              title: Text("Regional Sales Manager "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => ZonalLogin(
                              zonal: "Zonal",
                            )));
              },
              leading: Icon(Icons.exposure_zero_outlined),
              title: Text("Zonal Sales Manager "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => AreaSales(
                              area: "AreaManager",
                            )));
              },
              leading: Icon(Icons.area_chart),
              title: Text("Area Sales Manager "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => TerritorySalesLogin(
                              r: "Territory",
                            )));
              },
              leading: Icon(Icons.terminal),
              title: Text("Territory Sales Manager "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => SalesOfficeLogin(
                              r: "Sales Officer",
                            )));
              },
              leading: Icon(Icons.local_post_office),
              title: Text("Sales Officer "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => DistributorLogin(
                              r: "Distributor",
                            )));
              },
              leading: Icon(Icons.discount),
              title: Text("Distributer Officer "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => RetailerAppLogin(
                              r: "Retailer",
                            )));
              },
              leading: Icon(Icons.shop),
              title: Text("Retailer App"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
