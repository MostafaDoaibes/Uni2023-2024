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

  //Drugslist
static List<Drug> main_drugs_list=[
  Drug("Augmentin",6,"amoxicillin and clavulanic acid"),
  Drug("Panadol Advance",4,"paracetamol"),
  Drug("Panadol Extra",4.5,"paracetamol"),
  Drug("Daflon",5.2,"Hesperidin - 50mg, Diosmin - 450mg"),
  Drug("MABIXEN 100",122,"Rituximab - 100mg/10ml"),
  Drug("ULCAZAL",6.5,"Omeprazole (sodium) - 40mg"),
  Drug("ULTRA LEVURE",4.2,"Saccharomyces boulardii - 50mg"),
  Drug("ZARZIO",116,"Filgrastim - 300mcg/0.5ml"),
  Drug("ZECLAR",16,"paracetamol"),
  Drug("FAMODAR 40",6,"Famotidine - 40mg"),
  Drug("FEBRADOL",3,"paracetamol 500mg"),

];
List<Drug>display_list=List.from(main_drugs_list);

  void updateList(String value){
    //this function that will filter list
    setState(() {
      display_list=main_drugs_list.where((element) => element.drug_name!.toLowerCase().contains(value.toLowerCase())).toList();

    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
        backgroundColor: Color (0xffe1ddef),
        appBar: AppBar (
          title:  Text('Medicine Price',),
            centerTitle: true,
            backgroundColor: Color (0xff0ef8ef),
            elevation: 0.0,
            ),
        body: Padding(
        padding: EdgeInsets.all(16),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Drug Name",
                style:TextStyle(
                  color:Colors.black,
                  fontSize:22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value)=>updateList(value),
                decoration:InputDecoration(
                filled:true,
                fillColor:Color(0xffe1d9dd),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
              ),
                hintText: "Ex:Panadol",
                  prefixIcon: Icon(Icons.search),
                ),),
              SizedBox(height:20.0,),
              Expanded(
                child:display_list.length==0 ?Center(child: Text("No Result Found",),): ListView.builder(
                  itemCount:display_list.length,
                  itemBuilder:(context,index) =>ListTile(
                    title:Text(display_list[index].drug_name!),
                    subtitle: Text('${display_list[index].drug_components!}'),
                    trailing: Text("${display_list[index].drug_Price!}\$", style: TextStyle(
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


