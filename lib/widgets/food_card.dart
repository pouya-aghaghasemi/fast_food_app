import 'package:fast_food/core/constants.dart';
import 'package:fast_food/models/food.dart';
import 'package:flutter/material.dart';

// ================================================================
// Food Card
// ================================================================

class FoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================================
            // Image
            // ========================================================
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.asset(
                  food.imageURL,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // ========================================================
            // Food Name
            // ========================================================
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                food.foodName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            // ========================================================
            // Time & Rating
            // ========================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.timer, size: 18, color: primaryColor),

                  const SizedBox(width: 3),

                  Flexible(
                    child: Text(
                      '${food.time} min',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: primaryColor, fontSize: 12),
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.star_border_outlined,
                    size: 18,
                    color: rateColor,
                  ),

                  const SizedBox(width: 3),

                  Text(
                    '${food.rating}',
                    style: const TextStyle(color: rateColor, fontSize: 12),
                  ),
                ],
              ),
            ),

            // ========================================================
            // Price
            // ========================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              child: Text(
                '\$${food.price}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
