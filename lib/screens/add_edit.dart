import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:product_listing/constants/style.dart';
import 'package:product_listing/models/products.dart';

// ignore: must_be_immutable
class AddEditScreen extends StatelessWidget {
  AddEditScreen({
    super.key,
    required this.addPressed,
    required this.action, //isang function na lang yung pinagpapasahan nung add/edit from the home
    this.productItem, //hindi ginawang required kasi di siya need sa pag-add
    this.index//same with this
  });

  final bool addPressed; //if true mag-aadd, else edit

  Function? action;

  int? index; //for edit
  Products? productItem; //for edit

  //text editing controllers for the text fields
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!addPressed) { //if edit, populate the text fields from the passed productItem
      codeController.text = productItem!.productCode;
      nameController.text = productItem!.name;
      priceController.text = productItem!.price.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: addPressed ? const Text("Add a Product") : const Text("Edit Product"), //ternary operator. gets nito na yan siguro
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Code"),
            TextField(
              decoration: tfStyle,
              enabled: addPressed, // enabled siya if add, kapag edit, naka-disable
              controller: codeController,
            ),
            const Gap(10),

            const Text("Name/Description"),
            TextField(
              decoration: tfStyle,
              controller: nameController,
            ),
            const Gap(10),

            const Text("Price"),
            TextField(
              decoration: tfStyle,
              controller: priceController
            ),
            const Gap(20),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
                ),
                onPressed: addPressed
                  ? (){ //if true, add
                    action!(
                      Products(
                        productCode: codeController.text,
                        name: nameController.text,
                        price: double.parse(priceController.text)
                      )
                    );
                    Navigator.pop(context);
                  }
                  : () { //if false, edit
                    action!(
                      index,
                      Products(
                        productCode: codeController.text,
                        name: nameController.text,
                        price: double.parse(priceController.text)
                      )
                    );
                    Navigator.pop(context);
                  }
                  ,
                child: addPressed //ternary operator ulit
                  ? const Text("Add Product")
                  : const Text("Save")
              ),
            )
          ],
        ),
      ),
    );
  }
}