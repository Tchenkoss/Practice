import 'package:flutter/material.dart';

class FoodDescription extends StatelessWidget {
  final String foodImages;
  final String foodTitle;
  final int foodPrice;
  FoodDescription(
      {super.key,
      required this.foodImages,
      required this.foodTitle,
      required this.foodPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(foodImages),
          Text(foodTitle),
          Text(foodPrice.toString())
        ],
      ),
    );
  }
}
