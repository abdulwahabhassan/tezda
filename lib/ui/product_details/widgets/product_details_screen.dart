import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.title});

  final String title;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextTheme.of(context).titleMedium),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              children: List.generate(3, (index) {
                return _ProductDetailsImagesListItem(index: index);
              }),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text("\$99.00", style: TextTheme.of(context).titleMedium),
                      Text(
                        "Beautiful branded shirts",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Text(
                        "These polo shirts are designed to keep you looking fabulous",
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.favorite, size: 24, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetailsImagesListItem extends StatelessWidget {
  final int index;

  const _ProductDetailsImagesListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          "lib/assets/images/img_cloth.jpeg",
          fit: BoxFit.cover,
          // width: 200,
          // height: 200,
        ),
      ),
    );
  }
}
