import 'package:flutter/material.dart';

class HomenavScreen extends StatefulWidget {
  const HomenavScreen({super.key});

  @override
  State<HomenavScreen> createState() => _HomenavScreenState();
}

class _HomenavScreenState extends State<HomenavScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHOISISSEZ VOTRE MENU'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Salut Fabien !',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('images/pp.png'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Tap to search',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagesPlats.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                imagesPlats[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        platesName[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Menu',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text('View all',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: imagesPlats.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: AssetImage(imagesPlats[index]),
                            fit: BoxFit.cover),
                      ),
                    ),
                  )
                ],
              );
            },
          ))
        ],
      ),
    );
  }
}
