import 'package:flutter/material.dart';
import 'package:tezda/ui/product_details/widgets/product_details_screen.dart';
import 'package:tezda/ui/profile/widgets/profile_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.title});

  final String title;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextTheme.of(context).titleMedium),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => ProfileScreen(title: "Profile"),
                ),
              );
            },
            icon: ClipOval(
              child: Image.asset("lib/assets/images/img_cloth.jpeg"),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return _ProductListGridItem(
            index: index,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (buildContext) => ProductDetailsScreen(title: "$index"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ProductListGridItem extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const _ProductListGridItem({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.purple.withAlpha(25),
          child: Column(
            children: [
              Flexible(
                child: Image.asset(
                  "lib/assets/images/img_cloth.jpeg",
                  fit: BoxFit.cover,
                  scale: 1,
                  width: double.infinity,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(8),
                child: Text(
                  'Item $index',
                  textAlign: TextAlign.left,
                  style: TextTheme.of(context).bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
