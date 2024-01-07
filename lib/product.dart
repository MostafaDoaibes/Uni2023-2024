import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
// main URL for REST pages
const String _baseURL = 'mostafadoaibes.000webhostapp.com';


class Product {
  int _DrugID;
  String _DrugName;
  int _DrugPrice;
  double _DrugComponents;
  String _DrugUrl;

  Product(this._DrugID, this._DrugName, this._DrugPrice, this._DrugComponents, this._DrugUrl);

  @override
  String toString() {
    return 'PID: $_DrugID Name: $_DrugName\nQuantity: $_DrugPrice Price: \$$_DrugComponents\nCategory: $_DrugUrl';
  }
}
// list to hold products retrieved from getProducts
List<Product> _products = [];
// asynchronously update _products list
void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    _products.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) { // iterate over all rows in the json array
        Product p = Product( // create a product object from JSON row object
            int.parse(row['DrugID']),
            row['DrugName'],
            int.parse(row['DrugPrice']),
            double.parse(row['DrugComponents']),
            row['DrugUrl']);
        _products.add(p); // add the product object to the _products list
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch(e) {
    update(false); // inform through callback that we failed to get data
  }
}

// searches for a single product using product pid
void searchProduct(Function(String text) update, int pid) async {
  try {
    final url = Uri.https(_baseURL, 'searchProduct.php', {'DrugID':'$pid'});
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Product p = Product(
          int.parse(row['DrugID']),
          row['DrugName'],
          int.parse(row['DrugPrice']),
          double.parse(row['DrugComponents']),
          row['DrugUrl']);
      _products.add(p);
      update(p.toString());
    }
  }
  catch(e) {
    update("can't load data");
  }
}

// shows products stored in the _products list as a ListView
class ShowProducts extends StatelessWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              color: index % 2 == 0 ? Colors.amber: Colors.cyan,
              padding: const EdgeInsets.all(5),
              width: width * 0.9, child: Row(children: [
            SizedBox(width: width * 0.15),
            Flexible(child: Text(_products[index].toString(), style: TextStyle(fontSize: width * 0.045)))
          ]))
        ])
    );
  }
}