import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda/ui/product_details/widgets/product_details_screen.dart';
import 'package:tezda/ui/product_list/widgets/star_rating.dart';
import 'package:tezda/ui/profile/widgets/profile_screen.dart';
import '../../../data/models/product.dart';
import '../../../domain/models/status.dart';
import '../../../network/service.dart';

part 'product_list_screen.g.dart';

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  @override
  Status build() => Idle();

  Future<void> getProducts() async {
    state = Loading();
    try {
      final apiService = FakeStoreApiService();
      final res = await apiService.fetchProducts();
      state = Success(res);
    } catch (e) {
      state = Error(e.toString());
    }
  }
}

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(productsNotifierProvider.notifier).getProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsNotifier = ref.read(productsNotifierProvider.notifier);
    final productsStatus = ref.watch(productsNotifierProvider);

    final List<Product> categories = switch (productsStatus) {
      Idle() => [],
      Success(:List<Product> data) => data,
      Loading() => [],
      Error() => [],
      _ => [],
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => const ProfileScreen(title: "Profile"),
                ),
              );
            },
            icon: ClipOval(
              child: Image.asset("lib/assets/images/img_cloth.jpeg"),
            ),
          ),
        ],
      ),
      body: switch (productsStatus) {
        Idle() => const Center(child: Text("No categories available")),
        Loading() => const Center(child: CircularProgressIndicator()),
        Success() => GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.65,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _ProductListGridItem(
              product: category,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (buildContext) =>
                            ProductDetailsScreen(title: "${category.id}"),
                  ),
                );
              },
            );
          },
        ),
        Error(:var message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  message,
                  style: TextTheme.of(context).bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: productsNotifier.getProducts,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Try Again 🥺",
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      },
    );
  }
}

class _ProductListGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _ProductListGridItem({
    super.key,
    required this.product,
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
          child: SizedBox(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Stack(
                    children: [
                      Image.network(
                        product.thumbnail ?? "",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      if (product.discountPercentage != null &&
                          product.discountPercentage != 0)
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
                            "${product.discountPercentage?.round()}% ↓",
                            style: TextTheme.of(
                              context,
                            ).labelSmall?.copyWith(color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.deepPurple.withAlpha(50),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 8,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "\$${product.price}",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (product.rating != null)
                            StarRating(rating: product.rating!),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 8,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              product.title ?? "No title",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Flexible(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.purpleAccent,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
