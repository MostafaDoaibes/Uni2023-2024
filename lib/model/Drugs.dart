import 'dart:convert';
import 'package:http/http.dart' as http;

class Drug{
  int id;
  String? drug_name;
  String? drug_components;
  int? drug_Price;
  String? imageurl;


  Drug({required this.id,required this.drug_name,required this.drug_Price,required this.drug_components,required this.imageurl});

  static Future<List<Drug>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://mostafadoaibes.000webhostapp.com/getProducts.php'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((Drugs) => Drug(
        id: int.parse(Drugs['DrugID']),
        drug_name: Drugs['DrugName'],
        drug_components: Drugs['DrugComponents'],
        drug_Price: int.parse(Drugs['DrugPrice']),
        imageurl: Drugs['DrugUrl'],
      )).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}