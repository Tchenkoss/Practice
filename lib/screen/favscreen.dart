import 'package:flutter/material.dart';
import 'package:powereact/screen/foodescription.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<String> imagesPlats = [
    'images/bolo.jpg',
    'images/ndole.jpeg',
    'images/poisson.jpeg',
    'images/steack.jpeg'
  ];
  List<String> platesName = [
    'Spaghetti bolognaise',
    'Ndolé',
    'Poisson braisé',
    'Steak frites',
  ];

  List foodPrices = [19, 24, 17, 15];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All your favourites plates',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.68,
                ),
                itemCount: imagesPlats.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDescription(
                          foodImages: imagesPlats[index],
                          foodPrice: foodPrices[index],
                          foodTitle: platesName[index],
                        ),
                      ),
                    ),
                    child: Ink(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              imagesPlats[index],
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            platesName[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Price: ${foodPrices[index].toString()}€',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text('Add to cart'))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
