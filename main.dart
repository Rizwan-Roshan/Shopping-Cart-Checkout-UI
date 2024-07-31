import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DatafromAPI(),
    );
  }
}

class DatafromAPI extends StatefulWidget {
  const DatafromAPI({Key? key}) : super(key: key);

  @override
  State<DatafromAPI> createState() => _DatafromAPIState();
}

class _DatafromAPIState extends State<DatafromAPI> {

  Future<List<Product>> getProductData() async {
    print("function called");
    var response = await http.get(
        Uri.parse('https://www.jsonkeeper.com/b/YIDG'));
    var jsonData = jsonDecode(response.body);
    print(response);
    List<Product> list = List<Product>.from(
        (jsonData['data']['products']).map((x) => Product.fromJson(x)))
        .toList();
    print('list.length');
    print(list.length);
    return Future.value(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () {}
        ),
        title: Text('Your Cart', style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 21.0),
        ),
        centerTitle: true,
      ),

      body:Container(
    child: Card(
      child: FutureBuilder(
        future: getProductData(),
    builder:(context,snapshot){
    if(snapshot.data==null){
    return Container(
    child: Center(
    child:Text('Loading...'),
    ),
    );
    } else
      return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder:(context,i){
      return ListTile(
        title:Text(snapshot.data![i].prodName,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
        ),
        subtitle: Text("INR: ${snapshot.data![i].prodPrice}",
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 13.0),
        ),
        leading:
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: NetworkImage(
                    snapshot.data![i].prodImage),
                ),
              ),
            ),
trailing:
        Container( margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          color: Colors.grey[300]),
          child: Text("01", style: TextStyle(
              color:Colors.black, fontSize: 15.0),
          ),
        ),
      );
    });
    },
    ),),
        ),
      persistentFooterButtons: [Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text("Subtotal Items(5)", style: TextStyle(color: Colors.grey)),
    Text("INR 95500", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Delivery Fee", style: TextStyle(color: Colors.grey)),
                Text("INR 500 ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ]),
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Total", style: TextStyle(color: Colors.grey)),
                Text("INR 100000", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ]),
          Padding(
            padding: EdgeInsets.all(13.0),
             child:Container(
              decoration: BoxDecoration(color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              width: 200.0,
              height: 20.0,
              child: Center(child: Text("Go to Payment", style: TextStyle(color: Colors.white))),
            ),
          )
        ],
      )
      ],
      );
  }
}


    class Product {
  Product({
    required this.prodImage,
    required this.prodId,
    required this.prodCode,
    required this.barCode,
    required this.prodName,
    required this.uom,
    required this.unitId,
    required this.prodCombo,
    required this.isFocused,
    required this.groupIds,
    required this.categoryIds,
    required this.unitFromValue,
    required this.unitToValue,
    required this.uomAlternateName,
    required this.uomAlternateId,
    required this.underWarranty,
    required this.groupId,
    required this.catId,
    required this.prodHsnId,
    required this.prodHsnCode,
    required this.prodShortName,
    required this.prodPrice,
    required this.prodMrp,
    required this.prodBuy,
    required this.prodSell,
    required this.prodFreeItem,
    required this.prodRkPrice,
  });

  String prodImage;
  String prodId;
  String prodCode;
  String barCode;
  String prodName;
  String uom;
  String unitId;
  String prodCombo;
  String isFocused;
  String groupIds;
  String categoryIds;
  String unitFromValue;
  String unitToValue;
  String uomAlternateName;
  String uomAlternateId;
  String underWarranty;
  String groupId;
  String catId;
  String prodHsnId;
  String prodHsnCode;
  String prodShortName;
  String prodPrice;
  String prodMrp;
  String prodBuy;
  String prodSell;
  String prodFreeItem;
  String prodRkPrice;

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
        prodImage: json["prodImage"],
        prodId: json["prodId"],
        prodCode: json["prodCode"],
        barCode: json["barCode"],
        prodName: json["prodName"],
        uom: json["UOM"],
        unitId: json["unit_id"],
        prodCombo: json["prod_combo"],
        isFocused: json["is_focused"],
        groupIds: json["group_ids"],
        categoryIds: json["category_ids"],
        unitFromValue: json["unit_from_value"],
        unitToValue: json["unit_to_value"],
        uomAlternateName: json["uom_alternate_name"],
        uomAlternateId: json["uom_alternate_id"],
        underWarranty: json["under_warranty"],
        groupId: json["groupId"],
        catId: json["catId"],
        prodHsnId: json["prodHsnId"],
        prodHsnCode: json["prodHsnCode"],
        prodShortName: json["prodShortName"],
        prodPrice: json["prodPrice"],
        prodMrp: json["prodMrp"],
        prodBuy: json["prodBuy"],
        prodSell: json["prodSell"],
        prodFreeItem: json["prodFreeItem"],
        prodRkPrice: json["prodRkPrice"],
      );

  Map<String, dynamic> toJson() => {
    "prodImage": prodImage,
    "prodId": prodId,
    "prodCode": prodCode,
    "barCode": barCode,
    "prodName": prodName,
    "UOM": uom,
    "unit_id": unitId,
    "prod_combo": prodCombo,
    "is_focused": isFocused,
    "group_ids": groupIds,
    "category_ids": categoryIds,
    "unit_from_value": unitFromValue,
    "unit_to_value": unitToValue,
    "uom_alternate_name": uomAlternateName,
    "uom_alternate_id": uomAlternateId,
    "under_warranty": underWarranty,
    "groupId": groupId,
    "catId": catId,
    "prodHsnId": prodHsnId,
    "prodHsnCode": prodHsnCode,
    "prodShortName": prodShortName,
    "prodPrice": prodPrice,
    "prodMrp": prodMrp,
    "prodBuy": prodBuy,
    "prodSell": prodSell,
    "prodFreeItem": prodFreeItem,
    "prodRkPrice": prodRkPrice,
  };
}

