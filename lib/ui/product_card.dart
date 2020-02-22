import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thunderlanchonete/colors.dart';

import 'package:thunderlanchonete/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    Padding _buildTitleSection() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              product.name,
              style: const TextStyle(
                color: AppColors.AzulTR,
                fontFamily: 'BrandonText',
                fontSize: 20,
              ),
            ),
            // Empty space:
            SizedBox(height: 10.0),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/TB.svg",
                  color: AppColors.AzulTR,
                  height: 15,
                ),
                SizedBox(width: 5.0),
                Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    product.price.toString(),
                    style: const TextStyle(
                      color: AppColors.AzulTR,
                      fontFamily: 'BrandonText',
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Future<Widget> _getImage(BuildContext context, String img) async {
      String url = await FirebaseStorage.instance
          .ref()
          .child("products/$img.jpg")
          .getDownloadURL();

      return Image.network(
        url,
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onTap: () => print("Tapped!"),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 4.0 / 3.0,
                child: FutureBuilder(
                    future: _getImage(context, product.imageKey),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return snapshot.data;
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Container();
                    }),
              ),
              _buildTitleSection(),
            ],
          ),
        ),
      ),
    );
  }
}
