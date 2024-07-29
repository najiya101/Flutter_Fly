import 'package:flutter/material.dart';
import 'package:proj1/ProductDetails.dart';

class HomeScreen extends StatefulWidget {
  final Function(Map<String, String>) onFavoriteAdd;

  HomeScreen({required this.onFavoriteAdd});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final List<Map<String, String>> products = [
    {
      'name': '2 Tier Cake',
      'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 10.16.12 AM.jpeg',
      'price': 'Price: 1500/-',
      'Detail': 'There are many different types of chocolate cake, depending on the recipe and different types of chocolate used.\nFlavor: Chocolate Cake\nWeight: 2Kg\nItems include:\tTopper\n\tRoses: 6\n\tGypsum\n\tSugar beads\n'
    },
    {
      'name': 'Half Cake',
      'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 10.12.27 AM.jpeg',
      'price': '250/-',
      'Detail': 'A jungle theme cake is a cake that looks like a jungle. It has small cute animals like lions, elephants, and monkeys. Its perfect for kids parties!'
    },
    {'name': 'Mini Cake', 'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 10.12.54 AM.jpeg', 'price': '200/-',
    'Detail': 'small cakes that are approximately 3 to 4 inches in diameter and weigh around 250 to 300 grams,'
    },
    {'name': 'Book Hamper', 'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 10.13.49 AM.jpeg', 'price': '1590/-',
    'Detail': 'A selection of beautiful books, and some other literary treats, individually wrapped and beautifully presented in a luxury box'},
    {'name': 'Chocolate Bouquet', 'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-19 at 6.06.55 AM.jpeg', 'price': '1400/-',
    'Detail': ' an arrangement of chocolates done in a way to mimic conventional floral bouquets. '
    },
    {'name': 'Canvas Painting', 'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 12.35.06 AM.jpeg', 'price': '150/-',
    'Detail': 'the act of using a canvas, a material typically made of cotton or linen stretched over a wooden frame as the surface for painting'},

    {'name': 'Ring Album', 'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 12.35.07 AM.jpeg', 'price': '130/-',
    'Detail': 'a great way to celebrate special occasions like birthdays, anniversaries, and Valentines Day and can be a good gift for loved ones.'
    },
    {'name': 'Polaroids', 'image': '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 10.11.27 AM.jpeg', 'price': '99/-',
    'Detail': 'Polaroid photos are instant photographs produced by a Polaroid camera. The Polaroid camera was invented by Edwin H. Land and first marketed in 1948'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0, // Adjust the height of the banner
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                BannerWidget(imagePath: '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 11.46.07 AM.jpeg'),
                BannerWidget(imagePath: '/home/najiya/proj1/images/Festive flat lay frame ingredients f.jpeg'),
                BannerWidget(imagePath: '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 11.46.09 AM.jpeg'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Surprise is the greatest gift which life can grant us",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4, // Adjust the childAspectRatio to provide enough space
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, i) => ProductItem(
                name: products[i]['name']!,
                image: products[i]['image']!,
                price: products[i]['price']!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetails(
                        name: products[i]['name']!,
                        image: products[i]['image']!,
                        price: products[i]['price']!,
                        Detail: products[i].containsKey('Detail') ? products[i]['Detail']! : 'No details available',
                      ),
                    ),
                  );
                },
                onFavorite: () => widget.onFavoriteAdd(products[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  final String imagePath;

  BannerWidget({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedBannerClipper(),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class CurvedBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 50);
    var secondControlPoint = Offset(3 * size.width / 4, size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  ProductItem({
    required this.name,
    required this.image,
    required this.price,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GridTile(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        footer: GridTileBar(
          backgroundColor: Color.fromARGB(255, 232, 209, 250),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                price,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: onFavorite,
          ),
        ),
      ),
    );
  }
}
