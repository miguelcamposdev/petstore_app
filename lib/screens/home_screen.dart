import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedFilter = 'Available';

  final List<Map<String, dynamic>> _pets = [
    {
      'name': 'Cooper',
      'category': 'Dogs',
      'location': 'San Francisco, CA',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBj82tJZkvT3mfp9FSZdAhZCVxKNefPRg8AnpoxOaoJRGdkpE00n57OXyfHgG2lEFlDsRDeatrkmtASjM-SSa548Wd2tIgcyBzP4bkQq3MxioZCIRurfoBWyTFMecX_XBXjyQczsuXO9kUaRe9pG1beNWrwy9Zi91nTGQBisJgx_M96kECkYntHGT1RFnQSM9UahyYoUpE8nNhZ3TINkWmJsJO0-Ea2QFRsFPWM_EpejS_a0S6oIjENXmjN8fHjS57YFery0Z_U2ycQ',
    },
    {
      'name': 'Luna',
      'category': 'Cats',
      'location': 'Oakland, CA',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBL4xjIGWjIrTqJqJ25-A_FXYyNOTjiYyGm38Q5yztdnaNTlj_YS76qIl_tAiTZU5azdNzs_Xgl1OpT2qiHwRZiIdVXiYrmUCjXyW-8wBPEmQ13lG1NnHk5vHJHvWIto0m8Y8M-qW-y6muevWJu7I5o6B0R6Aya4dLxu1njEjzRc4_hzaXc57IHyV-VXZJFWRSiFvRMsh18L_qlYp7pvlhuX0ItgrS-GDi1JvtzDsdqhIkZdQQbLMqgSW8LI1F-MwVkmXpAz9VQLh8a',
    },
    {
      'name': 'Mochi',
      'category': 'Rabbits',
      'location': 'Berkeley, CA',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBIpO0fCyKiLw4h-YYUWzi7_3E8KyaOfoeF37A6LC3aJG51tYjbCcxcDFwG6GwwHtUeHYeoJuuvmg79W3hgh2ZFQAEo2opFvngYg5SFAM43bWyr5u1Zr1juDv8TWi3QFIpK6WIeT7bjtND7AsT0GOr8Ie0fyePmQgl0BbrYvImvfoeP95lhQIp35PxIt18fv6nR67LHAZcZw7u-8qivqy-9Ulim5f1JnQ2dxUsfdM69d0H5a8oRtowyvbnD-BGJI37aC9-Y_TfIapUU',
    },
    {
      'name': 'Sky',
      'category': 'Birds',
      'location': 'San Mateo, CA',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD72sf3D-YgH8ZxYuR5izfShSDABNV5zsPoF8d7We-a3sYFZFnSg-orsfVU_O1_exk_BN9B1Squ_0BAd2bxU_mIRZp6QrW2Hqo76P987px3TH8afUC5q-Ui76ZgBz5zfv_y-TSAbiYykGoN94Yvmmta8Xb86xNyEYqdPpdBA5iMpn-VfAvjrdJP7Xwj4C1p1nPY4R0pRvZTAJDb-ZUopwAeZzaG8n4NXbOCdtyqFkXlEY9dXTVR3MeC43XNsx12BZnhwPTN2DG9uK0I',
    },
    {
      'name': 'Waffles',
      'category': 'Dogs',
      'location': 'Palo Alto, CA',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRGs5H3If2EPyNTX27UL2m9lJZ23L91MGiZBP3hhXqCoME-Rxrd7YeDCKihX-wrvIeC3S2SnB37RprHhxdMx8z8g0gGPv2kmR8emZN09vItS76Zp42IsX2AFrw0sxwdwgAgEZV4D7Y10P1xgCXaIDsgSfTsU__wHxAMnoRYzgQpJBf5sfuoNtRJXywn_mYadPrzkn4K4AFb68mKlkev9S9L_gnSp_yAHRfyaPdZUERSU6WkpJ10ZCW5bys1-CRkBHrikf-B5rqck0L',
    },
    {
      'name': 'Olive',
      'category': 'Cats',
      'location': 'Fremont, CA',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBeNPolcMp3mDyqq9TsEgErcRiOeCCjrgm6oNvg5pEcNbOSNnuQNyTZ48QjrXMq7MtZTtyULFhlWWPeF6fQRuqkHQh_YUgKRdnA9tH7GdnbnVMO9bgST2m_jNZdjS1piUt7OtNywZH3aqVIkL8R02GN3B416CI_oE4Rk05XXwl5zFWeF-Qs_B53R6j3AZ6pFTxfYlNNWHcRFaPHwJE5wEVeK3Kbw3v3YH_zEeFcSClpkUxaLvbah9gaKnFJBC_ztk8cYpcoQRePcGE2',
      'status': 'PENDING ADOPTION',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.cardColor.withOpacity(0.8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Find Your Friend', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                            Text('Adopt a pet today!', style: TextStyle(color: theme.colorScheme.secondary, fontSize: 14)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.notifications_outlined, color: theme.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for pets...',
                      prefixIcon: Icon(Icons.search, color: theme.colorScheme.secondary),
                      filled: true,
                      fillColor: theme.scaffoldBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Status Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Available', Icons.pets),
                        const SizedBox(width: 12),
                        _buildFilterChip('Pending', Icons.schedule),
                        const SizedBox(width: 12),
                        _buildFilterChip('Sold', Icons.check_circle_outline),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main Content: Pet Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text('Recommended for you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('See All', style: TextStyle(color: theme.primaryColor)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _pets.length,
                        itemBuilder: (context, index) {
                          final pet = _pets[index];
                          return _buildPetCard(pet);
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.colorScheme.secondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    final isSelected = _selectedFilter == label;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : theme.colorScheme.secondary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetCard(Map<String, dynamic> pet) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail');
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: pet['image'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite_border, size: 16, color: theme.primaryColor),
                    ),
                  ),
                  if (pet.containsKey('status'))
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Text(
                          pet['status'],
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet['category'].toUpperCase(),
                    style: TextStyle(fontSize: 10, color: theme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pet['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12, color: theme.colorScheme.secondary),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          pet['location'],
                          style: TextStyle(fontSize: 10, color: theme.colorScheme.secondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}
