import 'package:flutter/material.dart';
import 'model/Drugs.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super (key: key);
  @override
  Widget build (BuildContext context) {
    return const MaterialApp(
      title: 'Medicine Price',
      home: SearchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) :super (key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  List<Drug> _Drugs=[];
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
  Future<void> fetchProducts() async {
    try {
      List<Drug> Drugs = await Drug.fetchProducts();
      setState(() {
        _Drugs = Drugs;
      });
    } catch (e) {
      print(e);
    }
  }
  void openImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(imageUrl, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error)),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }


  //Drugslist
//static List<Drug> mainDrugsList=[
 // Drug("Augmentin",6,"amoxicillin and clavulanic acid","https://www.aversi.ge/uploads/matimg/777276d174fa3df8635b6305a63bcb0b.png"),
 // Drug("Panadol Advance",4,"paracetamol","https://i.ytimg.com/vi/jEoj8NXgE_Y/mqdefault.jpg"),
 // Drug("Panadol Extra",4.5,"paracetamol","https://i-cf65.ch-static.com/content/dam/global/panadol/en_my/Products/300-300/5.1.A.2_300x300_ACTIFAST.png?auto=format"),
  //Drug("Daflon",5.2,"Hesperidin - 50mg, Diosmin - 450mg","https://cdn-pharmacy.nhg.com.sg/aspa01as01prod/0004375_daflon-tab-30s_510.jpeg"),
 // Drug("MABIXEN 100",122,"Rituximab - 100mg/10ml","https://bpilebanon.com/wp-content/uploads/2022/11/new-boxes-low-dosage_Page_20.jpg"),
 // Drug("ULCAZAL",6.5,"Omeprazole (sodium) - 40mg","https://loubnany.com/wp-content/uploads/2021/12/Ulcazal.png"),
//  Drug("ULTRA LEVURE",4.2,"Saccharomyces boulardii - 50mg","https://medecinepratique.ma/wp-content/uploads/2022/11/Mailing-UL-30-G-3.png"),
//  Drug("ZARZIO",116,"Filgrastim - 300mcg/0.5ml","https://www.sunstore.ch/media/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/4/4/4463760-87-4463760-PICFRONT3D.jpg"),
//  Drug("ZECLAR",16,"paracetamol","https://www.saiph-labo.com/upload/produit/5bd9c6db30547.png"),
 // Drug("FAMODAR 40",6,"Famotidine - 40mg","data:image/jpeg;base64,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"),
 // Drug("FEBRADOL",3,"paracetamol 500mg","https://png.pngtree.com/png-vector/20221125/ourmid/pngtree-no-image-available-icon-flatvector-illustration-thumbnail-graphic-illustration-vector-png-image_40966590.jpg"),

//];
//List<Drug>displayList=List.from(Drugs);

  void updateList(String value){
    //this function that will filter list
    setState(() {
     _Drugs=_Drugs.where((element) => element.drug_name!.toLowerCase().contains(value.toLowerCase())).toList();

    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
        backgroundColor: const Color (0xffe1ddef),
        appBar: AppBar (
          title:  const Text('Medicine Price',),
            centerTitle: true,
            backgroundColor: const Color (0xff0ef8ef),
            elevation: 0.0,
            ),
        body: Padding(
        padding: const EdgeInsets.all(16),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter Drug Name",
                style:TextStyle(
                  color:Colors.black,
                  fontSize:22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                onChanged: (value)=>updateList(value),
                decoration:InputDecoration(
                filled:true,
                fillColor:const Color(0xffe1d9dd),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
              ),
                hintText: "Ex:Panadol",
                  prefixIcon: const Icon(Icons.search),
                ),),
              const SizedBox(height:20.0,),
              Expanded(
                child:_Drugs.isEmpty ?const Center(child: Text("No Result Found",),):
                ListView.builder(
                  itemCount:_Drugs.length,
                  itemBuilder:(context,index) =>ListTile(

                        title: Text(_Drugs[index].drug_name!),
                    onTap: () => openImage(context, _Drugs[index].imageurl!),
                    subtitle: Text(_Drugs[index].drug_components!),
                    trailing: Text("${_Drugs[index].drug_Price!}\$", style: const
                    TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    )),),
                  ),
                ),

            ],
          ),
    ), // Padding
    ); // Scaffold
  }}


