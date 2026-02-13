import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PetDetailScreen extends StatelessWidget {
  const PetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Hero Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 400,
            child: CachedNetworkImage(
              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC5mjAgHsagXehKahsUOgNyAfDz7hqoxpFhDdT3rrH6JbT8-fh-Wn6H_bCG9DrHb5FLRmkzltgZPSQkFR1BxL9NqLv-G_9-mYIzIgfSTPMRJNF9eqc7bo4C6LmQWRC3LG1tmng3-c_Rl4R0fwfo3qm7fbRQjA1m0BX9ayNlt2hq-OSau3fx9kMQvOAsoIu6M0HbanqcSWysiAEIIeDwgI1X9p-R2g5gwnl_P9aZyVjNj3iA0mOwEfKI9hsyJhk8FAOqUxCkmn0bAzGE',
              fit: BoxFit.cover,
            ),
          ),

          // Gradient Overlay
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            height: 130,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    theme.scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
          ),

          // Content Body
          Positioned.fill(
            top: 360, // Adjust overlap
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
                children: [
                  // Header Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Buddy', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: theme.primaryColor),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'San Francisco, CA',
                                    style: TextStyle(fontWeight: FontWeight.w500, color: theme.colorScheme.secondary),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'AVAILABLE',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Dogs > Retriever', style: TextStyle(fontSize: 12, color: theme.colorScheme.secondary)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Tags Cloud
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTag(context, Icons.sentiment_very_satisfied, 'Friendly'),
                      _buildTag(context, Icons.vaccines, 'Vaccinated'),
                      _buildTag(context, Icons.home, 'House-trained'),
                      _buildTag(context, Icons.child_care, 'Good with kids'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Stats Bar
                  Row(
                    children: [
                      Expanded(child: _buildStatItem(context, 'Gender', 'Male')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatItem(context, 'Age', '2 Years')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatItem(context, 'Weight', '24 kg')),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text('About Buddy', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: theme.colorScheme.secondary, height: 1.5, fontSize: 14),
                      children: [
                        const TextSpan(text: 'Buddy is a high-energy Golden Retriever who loves long walks and playing fetch. He is extremely affectionate and gets along wonderfully with other dogs and children. '),
                        TextSpan(
                          text: 'Read More...',
                          style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Owner Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: theme.primaryColor.withOpacity(0.2), width: 2),
                            image: const DecorationImage(
                              image: CachedNetworkImageProvider('https://lh3.googleusercontent.com/aida-public/AB6AXuAUyLOGbTbz3EKCWfoPnqPPY2oOMpq1bNzN9YIZkGUVz13nbpVxe5WdYe1VkAsiTjY1Vqv3yZ1oLTG3aUzWAGPIHfFsTZ8ZXUbZdaIrxaKmeGLhBxn5sw7x8mItTyzym8lzp3wWcCGuy5mIV1KY1JOTXDcw20uB1uobR-n8-6zD6g77FkiM88sawhhnGvqL4_WGh2WJPmgKl9ZGwu7d_iIOHv-rYrPzTvQ47pUOK0Qff4QbUBjJuIznOWtj-iP6jrN51yMPK8_GiGYf'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pet Owner', style: TextStyle(fontSize: 10, color: theme.colorScheme.secondary)),
                            const Text('Alex Johnson', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        const Spacer(),
                        _buildOwnerActionButton(context, Icons.chat, true),
                        const SizedBox(width: 8),
                        _buildOwnerActionButton(context, Icons.call, false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopButton(context, Icons.arrow_back, () {
                    if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                    }
                }),
                _buildTopButton(context, Icons.share, () {}),
              ],
            ),
          ),

          // Sticky Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.9),
                border: Border(top: BorderSide(color: theme.dividerColor)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.favorite_border, color: theme.primaryColor),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                          shadowColor: theme.primaryColor.withOpacity(0.4),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Adopt Buddy'),
                            SizedBox(width: 8),
                            Icon(Icons.pets, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton(BuildContext context, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTag(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: theme.primaryColor),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: theme.colorScheme.secondary)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildOwnerActionButton(BuildContext context, IconData icon, bool filled) {
    final theme = Theme.of(context);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: filled ? theme.primaryColor : theme.primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: filled ? Colors.white : theme.primaryColor,
        size: 20,
      ),
    );
  }
}
