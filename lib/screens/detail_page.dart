import 'package:fast_food/core/constants.dart';
import 'package:fast_food/models/food.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final int foodId;

  const DetailPage({super.key, required this.foodId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Food> _foodList = Food.foodList;

  bool toggleCard(bool isSelected) {
    return !isSelected;
  }

  void _toggleFavorite() {
    setState(() {
      _foodList[widget.foodId].isFavorite =
          !_foodList[widget.foodId].isFavorite;
    });
  }

  void _addToCart() {
    setState(() {
      _foodList[widget.foodId].isSelected = toggleCard(
        _foodList[widget.foodId].isSelected,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Center(
          child: Text(
            'Added to cart successfully!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;

            // Responsive horizontal padding
            final horizontalPadding = screenWidth < 600
                ? 20.0
                : screenWidth < 900
                ? 30.0
                : 40.0;

            // Responsive image height with a maximum limit
            final imageHeight = (screenWidth * 0.35).clamp(250.0, 480.0);

            // Keep foodId logic exactly as it is
            final food = _foodList[widget.foodId];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildMainImage(food, screenWidth, imageHeight),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFoodInfo(food, screenWidth),

                        const SizedBox(height: 20),

                        _buildSectionTitle('Description'),

                        const SizedBox(height: 8),

                        Text(
                          food.description,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),

                        const SizedBox(height: 25),

                        _buildSectionTitle('Recently Viewed'),

                        const SizedBox(height: 10),

                        _buildRecentlyViewed(screenWidth),

                        const SizedBox(height: 25),

                        _buildBottomActions(screenWidth),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // Main Food Image
  // ==========================================================

  Widget _buildMainImage(Food food, double screenWidth, double imageHeight) {
    final borderRadius = screenWidth >= 900 ? 25.0 : 0.0;

    return SizedBox(
      height: imageHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius),
              bottomRight: Radius.circular(borderRadius),
            ),
            child: Image.asset(food.imageURL, fit: BoxFit.cover),
          ),

          // Back Button
          Positioned(
            left: 15,
            top: 15,
            child: _DetailTopButton(
              icon: Icons.arrow_back_ios_new_outlined,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Cart Button
          Positioned(
            right: 15,
            top: 15,
            child: _DetailTopButton(
              icon: Icons.shopping_bag_outlined,
              onTap: () {
                // رفتن به سبد خرید
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // Section Title
  // ==========================================================

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }

  // ==========================================================
  // Food Information
  // ==========================================================

  Widget _buildFoodInfo(Food food, double screenWidth) {
    final isSmallScreen = screenWidth < 600;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Food Name + Price
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.foodName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 18 : 21,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '${food.price}\$',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 15),

        // Time + Rating
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 5,
            children: [
              _InfoItem(
                icon: Icons.timer_outlined,
                text: '${food.time} min',
                color: primaryColor,
              ),
              _InfoItem(
                icon: Icons.star_outline,
                text: '${food.rating}',
                color: rateColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // Recently Viewed
  // ==========================================================

  Widget _buildRecentlyViewed(double screenWidth) {
    final itemSize = screenWidth < 600
        ? 90.0
        : screenWidth < 900
        ? 105.0
        : 120.0;

    return SizedBox(
      height: itemSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _foodList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              _foodList[index].imageURL,
              width: itemSize,
              height: itemSize,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // Bottom Actions
  // ==========================================================

  Widget _buildBottomActions(double screenWidth) {
    final isFavorite = _foodList[widget.foodId].isFavorite;
    final isSelected = _foodList[widget.foodId].isSelected;

    final buttonSize = screenWidth < 600 ? 50.0 : 55.0;

    return Row(
      children: [
        // Favorite Button
        InkWell(
          onTap: _toggleFavorite,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0.5, 0.5),
                  color: Color.fromARGB(255, 231, 229, 229),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? primaryColor : Colors.black,
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Add To Cart Button
        Expanded(
          child: InkWell(
            onTap: _addToCart,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: buttonSize,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                isSelected ? 'Added to cart' : 'Add to cart',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================================
// Info Item
// ==========================================================

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 17),
        const SizedBox(width: 3),
        Text(text, style: TextStyle(color: color, fontSize: 14)),
      ],
    );
  }
}

// ==========================================================
// Top Button
// ==========================================================

class _DetailTopButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _DetailTopButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
