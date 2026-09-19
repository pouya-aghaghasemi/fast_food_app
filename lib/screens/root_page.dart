import 'package:fast_food/core/constants.dart';
import 'package:fast_food/models/food.dart';
import 'package:fast_food/screens/cart_page.dart';
import 'package:fast_food/screens/favorite_page.dart';
import 'package:fast_food/screens/home_page.dart';
import 'package:fast_food/screens/profile_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;

  List<Food> favorites = [];
  List<Food> foodcard = [];
  final items = [
    Icons.home_outlined,
    Icons.favorite_border,
    Icons.shopping_cart_outlined,
    Icons.person_outline,
  ];

  final labels = ['Menu', 'Favorite', 'Cart', 'Profile'];

  void onTap(int index) {
    setState(() {
      currentIndex = index;

      // وقتی وارد Favorite می‌شیم
      if (index == 1) {
        favorites = Food.getFavoritedFood().toSet().toList();
      }
      if (index == 2) {
        foodcard = Food.addedToCartFood().toSet().toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // اینجا ساخته میشه تا همیشه favorites جدید رو بگیره
    final pages = [
      const HomePage(),
      FavoritePage(
        favoriteFood: favorites,
        onBack: () {
          setState(() {
            currentIndex = 0;
          });
        },
      ),
      CartPage(
        cartfood: foodcard,
        onBack: () {
          setState(() {
            currentIndex = 0;
          });
        },
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      extendBody: true,

      body: pages[currentIndex],

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),

        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            ...List.generate(
              items.length,

              (index) => InkWell(
                onTap: () => onTap(index),

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  child: currentIndex == index
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, size: 10, color: primaryColor),

                            const SizedBox(width: 5),

                            Text(
                              labels[index],
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        )
                      : Icon(items[index], color: iconColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
