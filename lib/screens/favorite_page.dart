import 'package:fast_food/core/constants.dart';
import 'package:fast_food/models/food.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final List<Food> favoriteFood;
  final VoidCallback onBack;
  const FavoritePage({
    super.key,
    required this.favoriteFood,
    required this.onBack,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // =========================
            // Header
            // =========================
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Positioned(
                    left: 15,
                    top: 20,
                    child: GestureDetector(
                      onTap: widget.onBack,
                      child: BackPage(),
                    ),
                  ),

                  Positioned(
                    left: 80,
                    top: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Favorites',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF12304D),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Your saved restaurants and meals',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // Restaurants / Meals
            // =========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 56,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F6F6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    // Restaurants
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            gradient: selectedIndex == 0
                                ? const LinearGradient(
                                    colors: [Color(0xFF1CB5A3), primaryColor],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Restaurants',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : const Color(0xFF8295A8),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Meals
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            gradient: selectedIndex == 1
                                ? const LinearGradient(
                                    colors: [Color(0xFF1CB5A3), primaryColor],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Meals',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedIndex == 1
                                  ? Colors.white
                                  : const Color(0xFF8295A8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // Favorite Foods
            // =========================
            Expanded(
              child: selectedIndex == 1
                  ? _buildFavoriteFoods()
                  : _buildRestaurants(),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // Favorite Foods List
  // =========================
  Widget _buildFavoriteFoods() {
    if (widget.favoriteFood.isEmpty) {
      return const Center(
        child: Text(
          'No favorite meals yet',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: widget.favoriteFood.length,
      itemBuilder: (context, index) {
        final food = widget.favoriteFood[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: 120,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Food Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.asset(
                  food.imageURL,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 15),

              // Food Information
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        food.foodName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(Icons.star, size: 15, color: primaryColor),
                          Text(
                            ' ${food.rating}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: 7),
                          Icon(
                            Icons.timelapse_rounded,
                            size: 15,
                            color: Colors.grey,
                          ),
                          Text(
                            ' ${food.time}min',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Favorite Icon
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.favorite, color: primaryColor),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================
  // Restaurants
  // =========================
  Widget _buildRestaurants() {
    return const Center(
      child: Text(
        'Favorite Restaurants',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class BackPage extends StatelessWidget {
  const BackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: cardColor),
      child: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: primaryColor,
        size: 23,
      ),
    );
  }
}
