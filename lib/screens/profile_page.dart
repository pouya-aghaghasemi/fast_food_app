import 'package:fast_food/core/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double avatarSize = size.width * 0.2;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Container(
                height: size.height * 0.2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),

                    // Profile Image
                    Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: cardColor),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // User Information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pouya Aghaghasemi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: cardColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: cardColor,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'New York, USA',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Settings
                    const Icon(
                      Icons.settings_outlined,
                      color: cardColor,
                      size: 22,
                    ),

                    const SizedBox(width: 15),
                  ],
                ),
              ),

              // Premium Card
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.1,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.king_bed_outlined, color: primaryColor),

                      const SizedBox(width: 15),

                      // Premium Text
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Premium Member',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Enjoy exclusive offers',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Benefits Button
                      Container(
                        width: 100,
                        height: 33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: primaryColor,
                        ),
                        child: const Center(
                          child: Text(
                            'View Benefits',
                            style: TextStyle(fontSize: 12, color: cardColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // My Orders Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My Orders',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              // Orders
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: OrderWidget(
                        icon: Icons.backpack_outlined,
                        title: 'All Orders',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OrderWidget(
                        icon: Icons.delivery_dining,
                        title: 'In Progress',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OrderWidget(
                        icon: Icons.check_circle_outline,
                        title: 'Delivered',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Profile Menu
              BodyList(
                icon: Icons.favorite_border_outlined,
                title: 'Favorites',
                subtitle: 'Your saved restaurants and meals',
              ),

              BodyList(
                icon: Icons.payment,
                title: 'Payment Methods',
                subtitle: 'Manage your cards and payments',
              ),

              BodyList(
                icon: Icons.notifications_none,
                title: 'Notifications',
                subtitle: 'Order updates and special offers',
              ),

              BodyList(
                icon: Icons.logout_outlined,
                title: 'Log Out',
                subtitle: 'Sign out from your account',
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// Profile Menu Item
// ------------------------------------------------------------

class BodyList extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const BodyList({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Container(
        width: double.infinity,
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor,
              ),
              child: Icon(icon, color: primaryColor),
            ),

            const SizedBox(width: 10),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Arrow
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// Order Widget
// ------------------------------------------------------------

class OrderWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const OrderWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
            ),
            child: Icon(icon, color: primaryColor),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
