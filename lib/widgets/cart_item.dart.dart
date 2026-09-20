import 'package:fast_food/core/constants.dart';
import 'package:fast_food/models/food.dart';
import 'package:fast_food/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Food food;
  final double screenWidth;

  const CartItem({super.key, required this.food, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final imageSize = screenWidth < 600
        ? 90.0
        : screenWidth < 900
        ? 105.0
        : 120.0;

    return Container(
      constraints: BoxConstraints(minHeight: imageSize + 12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              food.imageURL,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          // Food Information
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    food.foodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth < 600 ? 16 : 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    food.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: screenWidth < 600 ? 13 : 14,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    '\$${food.price}',
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 17 : 19,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Remove + Quantity
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // حذف این آیتم
                },
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 21, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 12),

              QuantitySelector(
                quantity: 1,
                onIncrease: () {
                  // زیاد کردن تعداد
                },
                onDecrease: () {
                  // کم کردن تعداد
                },
              ),
            ],
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
