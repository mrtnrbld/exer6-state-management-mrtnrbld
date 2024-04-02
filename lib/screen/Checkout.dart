import "package:flutter/material.dart";
import "../model/Item.dart";
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key});
  @override
  Widget build(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Item Details"),
          const Divider(height: 4, color: Colors.black),
          getItems(context),
          const Divider(height: 4, color: Colors.black),
          computeCost(),
          Flexible(
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                if (products.isNotEmpty)
                  ElevatedButton(
                      onPressed: () {
                        context.read<ShoppingCart>().removeAll();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Payment Successful!"),
                          duration: Duration(seconds: 2, milliseconds: 100),
                        ));
                      },
                      child: const Text("Pay now")),
              ]))),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
        ? const Text("No Items to checkout")
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index].name),
                    trailing: Text("${products[index].price}"),
                  );
                },
              )),
            ],
          ));
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total cost to pay: ${cart.cartTotal}");
    });
  }
}
