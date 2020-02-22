import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thunderlanchonete/colors.dart';
import 'package:thunderlanchonete/model/product.dart';
import 'package:thunderlanchonete/ui/product_card.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // height: 2000,
      child: _buildProducts(),
    );
  }

  Column _buildProducts() {
    CollectionReference collectionReference =
        Firestore.instance.collection('products');
    Stream<QuerySnapshot> stream = collectionReference.snapshots();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: new StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: AppColors.AzulTR,
                  ),
                );
              }

              return new GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: snapshot.data.documents.map((doc) {
                  return new ProductCard(
                    product: Product.fromMap(doc.data, doc.documentID),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
