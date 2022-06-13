import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key,required this.products}) : super(key: key);
  dynamic products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 150,
                child: AspectRatio(
                  aspectRatio: 0.98,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: products["image"] ?? "http://via.placeholder.com/350x150",
                      placeholder: (context,  url) => Container(
                        color: Colors.blueAccent,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(width: MediaQuery.of(context).size.width*0.9,child:  Text(
              products["title"] ?? "",
              style: TextStyle(color: Colors.black, fontSize: 20),
              maxLines: 2,
            ),),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("\$${products["price"]}",style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.green,fontSize: 20),),
            ),
            SizedBox(height: 20,),
            Text("description: "),
            SizedBox(width: MediaQuery.of(context).size.width*0.9,child:  Text(
              products["description"] ?? "",
              style: TextStyle(color: Colors.black, fontSize: 15),
              maxLines: 2,
            ),),

            Spacer(),
      Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Sending Message"),
            ));
          },
          child: const Text('Add to cart', style: TextStyle(fontSize: 20)),
        ),
      ),
          ],
        ),
      ),
    );
  }
}
