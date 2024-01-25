import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_listing/models/products.dart';
import 'package:product_listing/screens/add_edit.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Products> productList = [
    Products( //initial value nung list
      productCode: "AB154",
      name: "AsusVivoBook15 Laptop",
      price: 15000
    )
  ];

  void addProduct(Products productItem) {
    setState(() {
      productList.add(productItem); // add lang sa dulo nung list
    });
  }

  void editProduct(int index, Products productItem) {
    productList.removeAt(index); //remove first
    setState(() {
      productList.insert(index, productItem); //then add the updated product item
    });
  }

  NumberFormat priceFormatter = NumberFormat.currency(symbol: "₱"); //hindi required, dinagdag q lang

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddEditScreen(
                  addPressed: true, //gawin nating true kasi mag-aadd nga tayo
                  action: addProduct, //pass the addProduct function dahil yun nga yung gagawin natin
                ),
              )
            ),
            icon: const Icon(Icons.add_circle)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditScreen(
                addPressed: false, //since edit naman na to, gawin nating false
                productItem: productList[index], //pass the product item
                action: editProduct, //pass the editProduct function
                index: index, //pass the index
              ),
            )
          ),
          child: ListTile(
            leading: const Icon(Icons.star),
            title: Text(
              productList[index].name,
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            trailing: Text( //not required. dinagdag ko lang
              priceFormatter.format(productList[index].price)
            ),
          ),
        ),
      ),
    );
  }
}