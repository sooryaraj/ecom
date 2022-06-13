import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/product_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyGridView(),
    );
  }
}


class MyGridView extends StatefulWidget {
  const MyGridView({Key? key}) : super(key: key);

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: getProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            var _data = snapshot.data;
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ProductCard(products: _data[index]);
                });
          }
        }
    );
  }

  Future<List<dynamic>> getProducts() async {
    var response = await http
        .get(Uri.parse("https://api.storerestapi.com/products"), headers: {"Accept": "application/json"});
    // Map<String, dynamic> prod = json.decode(response.body)['data'];
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load album');
    }
  }
}



class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.products,
  }) : super(key: key);

  final dynamic products;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(products: products,),
            ));
      },
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: products["image"] ?? "http://via.placeholder.com/350x150",
                  placeholder: (context,  url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.7,
                child: Text(
                  products["title"] ?? "",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 10),
              Text("\$${products["price"]}",style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.green,fontSize: 20),),

            ],
          )
        ],
      ),
    );
  }
}