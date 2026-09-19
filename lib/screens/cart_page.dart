import 'package:fast_food/core/constants.dart';
import 'package:fast_food/models/food.dart';
import 'package:fast_food/screens/favorite_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Food> cartfood;
  final VoidCallback onBack;

  const CartPage({super.key, required this.cartfood, required this.onBack});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;

            final horizontalPadding = screenWidth < 600
                ? 15.0
                : screenWidth < 900
                ? 25.0
                : 40.0;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),

                    const SizedBox(height: 20),

                    _buildCartList(screenWidth),

                    const SizedBox(height: 15),

                    _buildPromoCode(screenWidth),

                    const SizedBox(height: 15),

                    _buildOrderSummary(),

                    const SizedBox(height: 15),

                    _buildCheckoutButton(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================
  // Header
  // =========================

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: widget.onBack,
          borderRadius: BorderRadius.circular(30),
          child: const BackPage(),
        ),

        const SizedBox(width: 15),

        const Expanded(
          child: Text(
            'My Cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF12304D),
            ),
          ),
        ),

        InkWell(
          onTap: () {
            // حذف همه آیتم‌ها
          },
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: cardColor),
            child: const Icon(
              Icons.delete_forever_outlined,
              color: primaryColor,
              size: 21,
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // Cart List
  // =========================

  Widget _buildCartList(double screenWidth) {
    if (widget.cartfood.isEmpty) {
      return SizedBox(
        height: screenWidth < 600 ? 280 : 350,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: screenWidth < 600 ? 55 : 70,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 15),
              Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: screenWidth < 600 ? 24 : 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Add some delicious meals to your cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: screenWidth < 600 ? 13 : 15,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.cartfood.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final food = widget.cartfood[index];

        return _buildCartItem(food, screenWidth);
      },
    );
  }

  // =========================
  // Cart Item
  // =========================

  Widget _buildCartItem(Food food, double screenWidth) {
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

              _buildQuantitySelector(),
            ],
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }

  // =========================
  // Quantity Selector
  // =========================

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            icon: Icons.remove,
            onTap: () {
              // کم کردن تعداد
            },
          ),

          const SizedBox(width: 8),

          const Text(
            '1',
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 8),

          _buildQuantityButton(
            icon: Icons.add,
            onTap: () {
              // زیاد کردن تعداد
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 15),
      ),
    );
  }

  // =========================
  // Promo Code
  // =========================

  Widget _buildPromoCode(double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth < 600 ? 40 : 45,
            height: screenWidth < 600 ? 40 : 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF8BBEBE),
            ),
            child: const Icon(
              Icons.discount_outlined,
              color: primaryColor,
              size: 19,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Have a promo code?',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Apply here to get discount',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 12 : 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          InkWell(
            onTap: () {
              // اعمال کد تخفیف
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: screenWidth < 600 ? 65 : 75,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // Order Summary
  // =========================

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Summary',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 15),

          _buildSummaryRow(title: 'Subtotal', value: '\$0.00'),

          const SizedBox(height: 8),

          _buildSummaryRow(title: 'Tax (10%)', value: '\$0.00'),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Colors.grey, height: 1),
          ),

          _buildSummaryRow(title: 'Total', value: '\$0.00', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String title,
    required String value,
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isTotal ? primaryColor : Colors.grey.shade600,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            color: isTotal ? primaryColor : Colors.grey.shade700,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            fontSize: isTotal ? 17 : 14,
          ),
        ),
      ],
    );
  }

  // =========================
  // Checkout Button
  // =========================

  Widget _buildCheckoutButton() {
    return InkWell(
      onTap: () {
        // رفتن به Checkout
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wallet_outlined, color: Colors.white),

            SizedBox(width: 10),

            Text(
              'Proceed to Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(width: 10),

            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
