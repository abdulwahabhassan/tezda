import 'package:flutter/material.dart';
import 'package:tezda/data/models/product.dart';
import 'package:tezda/utils/helpers.dart';

import '../../product_list/widgets/star_rating.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.product.title ?? "Product",
          style: TextTheme.of(context).titleMedium,
        ),
      ),
      body: Column(
        children: [
          if (widget.product.images != null &&
              widget.product.images!.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                children: List.generate(widget.product.images?.length ?? 0, (
                  index,
                ) {
                  return _ProductDetailsImagesListItem(
                    imageUrl: widget.product.images![index],
                  );
                }),
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formatCurrency(widget.product.price ?? 0.00),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          if (widget.product.discountPercentage != null &&
                              widget.product.discountPercentage != 0)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(2),
                                  bottomRight: Radius.circular(2),
                                  topLeft: Radius.circular(8),
                                ),
                                border: Border.all(width: 0.5),
                              ),
                              child: Text(
                                "${widget.product.discountPercentage?.round()}% ↓",
                                style: TextTheme.of(
                                  context,
                                ).labelSmall?.copyWith(color: Colors.black),
                              ),
                            ),
                        ],
                      ),
                      if (widget.product.rating != null)
                        StarRating(rating: widget.product.rating!),
                    ],
                  ),
                ),
                Icon(Icons.favorite, color: Colors.purpleAccent, size: 20),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title ?? "No title",
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  widget.product.description ?? "No description",
                  style: TextTheme.of(context).bodySmall,
                ),
                SizedBox(height: 12),
                Text(
                  "✅ ${widget.product.warrantyInformation ?? "No description"}",
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2),
                Text(
                  "📈 ${widget.product.availabilityStatus ?? "No description"}",
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2),
                Text(
                  "🚀 ${widget.product.shippingInformation ?? "No description"}",
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2),
                Text(
                  "💰 ${widget.product.returnPolicy ?? "No description"}",
                  style: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          if (widget.product.reviews != null &&
              widget.product.reviews!.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                children: List.generate(widget.product.reviews?.length ?? 0, (
                  index,
                ) {
                  Review review = widget.product.reviews![index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              review.reviewerName ?? "No name",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextTheme.of(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              review.reviewerEmail ?? "No name",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextTheme.of(context).bodySmall,
                            ),
                            SizedBox(height: 2),
                            Text(
                              review.date ?? "No name",
                              style: TextTheme.of(context).bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: 4),
                            Text(
                              review.comment ?? "No name",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextTheme.of(context).bodySmall?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 2),
                            if (review.rating != null)
                              StarRating(
                                rating: review.rating!.roundToDouble(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // Flexible(
                  // child: ListTile(
                  //   title: Text(review.reviewerName ?? "No name"),
                  //   subtitle: Text(review.reviewerEmail ?? "No name"),
                  // ),
                  // );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductDetailsImagesListItem extends StatelessWidget {
  final String imageUrl;

  const _ProductDetailsImagesListItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
