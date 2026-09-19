import 'package:fast_food/core/constants.dart';
import 'package:fast_food/models/food.dart';
import 'package:fast_food/screens/detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategoryIndex = 0;

  final List<Food> _foodList = Food.foodList;

  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dessert',
    'Dinner',
    'Drink',
  ];

  // ------------------------------------------------------------
  // Responsive column count
  // ------------------------------------------------------------

  int _getCrossAxisCount(double width) {
    if (width < 600) {
      return 2; // Mobile
    } else if (width < 900) {
      return 3; // Tablet
    } else if (width < 1200) {
      return 4; // Small Laptop
    } else if (width < 1600) {
      return 5; // Desktop
    } else {
      return 6; // Large Monitor
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;

            final int crossAxisCount = _getCrossAxisCount(screenWidth);

            // Limit content width on very large monitors
            final double contentWidth = screenWidth > 1600 ? 1600 : screenWidth;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  children: [
                    // ==================================================
                    // Header
                    // ==================================================
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        left: screenWidth < 600 ? 15 : 25,
                        right: screenWidth < 600 ? 15 : 25,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Menu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),

                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(
                              Icons.shop_outlined,
                              color: cardColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ==================================================
                    // Search
                    // ==================================================
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth < 600 ? 15 : 25,
                        right: screenWidth < 600 ? 15 : 25,
                        bottom: 20,
                      ),
                      child: TextField(
                        cursorColor: Colors.black87,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 184, 182, 182),
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 184, 182, 182),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 219, 218, 218),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),

                    // ==================================================
                    // Main Content
                    // ==================================================
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            // ==========================================
                            // Categories
                            // ==========================================
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                  left: screenWidth < 600 ? 10 : 20,
                                  right: 10,
                                ),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: _categories.length,
                                itemBuilder: (context, index) {
                                  final bool isSelected =
                                      selectedCategoryIndex == index;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategoryIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Center(
                                        child: Text(
                                          _categories[index],
                                          style: TextStyle(
                                            color: isSelected
                                                ? primaryColor
                                                : const Color.fromARGB(
                                                    255,
                                                    119,
                                                    119,
                                                    119,
                                                  ),
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: screenWidth < 600
                                                ? 15
                                                : 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // ==========================================
                            // Food Grid
                            // ==========================================
                            Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.only(
                                  left: screenWidth < 600 ? 5 : 15,
                                  right: screenWidth < 600 ? 5 : 15,
                                  bottom: 15,
                                  top: 5,
                                ),
                                physics: const BouncingScrollPhysics(),
                                itemCount: _foodList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,

                                      crossAxisSpacing: screenWidth < 600
                                          ? 4
                                          : 10,

                                      mainAxisSpacing: screenWidth < 600
                                          ? 4
                                          : 10,

                                      // Keep cards from becoming too tall
                                      childAspectRatio: screenWidth < 600
                                          ? 0.68
                                          : 0.72,
                                    ),
                                itemBuilder: (context, index) {
                                  final Food food = _foodList[index];

                                  return FoodCard(
                                    food: food,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(foodId: food.foodId),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

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
