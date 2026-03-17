import 'package:flutter/material.dart';

class NeedsScreen extends StatefulWidget {
  const NeedsScreen({super.key});

  @override
  State<NeedsScreen> createState() => _NeedsScreenState();
}

class _NeedsScreenState extends State<NeedsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _needs = [
    {
      'location': 'Málaga',
      'status': 'Expired (27 Mar 2026)',
      'statusColor': Colors.orange,
      'statusBgColor': Colors.orange.shade100,
      'title': 'General welding tasks',
      'progressLabel': '0 of 6 pax found',
      'progress': 0.0,
    },
    {
      'location': 'Barcelona',
      'status': 'Due 3 Abr 2026',
      'statusColor': Colors.green,
      'statusBgColor': Colors.green.shade100,
      'title': 'Install, maintain, repair Renewable Energy systems',
      'progressLabel': '4 of 10 pax found',
      'progress': 0.4,
    },
    {
      'location': 'Madrid',
      'status': 'In Review',
      'statusColor': const Color(0xFFFF8B42), // Primary Color
      'statusBgColor': const Color(0xFFFF8B42).withValues(alpha: 0.1),
      'title': 'Quality Control Audit - Site B',
      'progressLabel': '2 of 2 pax found',
      'progress': 1.0,
    },
    {
      'location': 'Valencia',
      'status': 'Due 12 Abr 2026',
      'statusColor': Colors.green,
      'statusBgColor': Colors.green.shade100,
      'title': 'Logistics Coordinator',
      'progressLabel': '1 of 5 pax found',
      'progress': 0.2,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCs5HpANiAPwzI1NCUqj_u0rAE7XbgiUGfbUD3E4d2QaclwSkxMSOfjUsg5ud13WusqIwbCikLhV1wLd6JpD7RZKJ2T69L0v41DVdZjVZ49iPigRmoN5dJnbraEQaiKL57K0BndaCmKLLXbxF1fI1bAyorKKTnF5zdeH0JuRbS8XHElIif0hprfTB3UFteUlwMkxQ4GmvN2l0hfXWoJPZMs_xRUSzvY6ZwLWVTE8t2C0SfRXO2KklGEApKFRv1ReCg6YjBaaoKALaQ',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: const Text(
          'Needs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: theme.primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: theme.primaryColor,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Needs'),
                Tab(text: 'Routes'),
                Tab(text: 'Visits'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNeedsList(theme),
          const Center(child: Text('Routes Tab')),
          const Center(child: Text('Visits Tab')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: theme.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.search, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Hosts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.handyman),
              label: 'FixIt!',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: 'Chatter',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeedsList(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _needs.length,
      itemBuilder: (context, index) {
        final need = _needs[index];
        return _buildNeedCard(need, theme);
      },
    );
  }

  Widget _buildNeedCard(Map<String, dynamic> need, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    need['location'].toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: need['statusBgColor'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  need['status'],
                  style: TextStyle(
                    color: need['statusColor'],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            need['title'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                need['progressLabel'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: need['progress'],
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
