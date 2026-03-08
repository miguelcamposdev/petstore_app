import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class IncidentListScreen extends StatefulWidget {
  const IncidentListScreen({super.key});

  @override
  State<IncidentListScreen> createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends State<IncidentListScreen> {
  Color get _primaryBlue => const Color(0xFF137FEC);

  String _selectedTab = 'Todos';
  final List<String> _tabs = ['Todos', 'Pendientes', 'En curso', 'Resueltos'];

  final List<Map<String, dynamic>> _incidents = [
    {
      'id': '#INC-8821',
      'title': 'Fuga de agua',
      'location': 'Sector B - Planta 2',
      'date': '05 Nov 2023, 10:20',
      'priority': 'HIGH',
      'status': 'TODO',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBKyc3Ib9CQDjwmjySK01YcMvpA2Z4eVOG32HIc6y6Ksf8OqRkxjvuAHnW-XukS02Wps4FOVS-U2bJEOuWFcSKHUbFhBWgSqe67bYscu5MM2NkXklmyERka3cNTDZFNPkE_hjxfwTgsRQ6gIFhvx6G2Bn9_73od4Luz6PCvBmwa9LyZRrmsb2132QJnh-ZUumNDW_TlVRpDfLSTJiSQlXMsmcpmfzzoVJYtpRlmoZEH5nm_bTzFksCqsoJsDKPGJdB7EXLX1kgx0kAK',
    },
    {
      'id': '#INC-8815',
      'title': 'Fallo eléctrico',
      'location': 'Pasillo 4 - Ala Este',
      'date': '04 Nov 2023, 08:45',
      'priority': 'MEDIUM',
      'status': 'DONE',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAZBOLxYzVJBJxPqNwZTgtE7pbdEhft96mk-bFVgrUPFsvjvT2fvjfOsPW6Q849XoH6MjUIyv4bnHfxbSveLxZ4gDu4-P4GYBnttzrvYxjsI2Ue3L1VbxThJJQQFL7iZoKWATn_CC5ZiJlcb9hrWV34sX_kbfLnaPMYhU-8J5Yl7rViNN1ghdCPXlZXlRJpg8-0EKkDZ3N69eNPYrNjYbTBFWFy6Ni2kl2nqTJNnhW8-NPyXME_zvYyi2SF3niBjSslB7BOyI3WHR_X',
    },
    {
      'id': '#INC-8812',
      'title': 'Grieta en fachada',
      'location': 'Fachada Exterior Norte',
      'date': '03 Nov 2023, 14:30',
      'priority': 'LOW',
      'status': 'IN PROGRESS',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDgYp8UidrGJHfbcexMfLh4u1Mfwf_zHcmcnRH1wz1u1MDSfHB5OWE-WL1VmF2wkXNLxDfPInPxqL5SN6Ppg4Z-pkpDvdMAFGlDElMBP3-yRdBkSH3eQjHt0mwAimV5zAhZtlQFyeIVbKbKJZqjtDDKgDGy53NRLUVu86AJLx4Epv2OeOeSvx1-nXXtoM3tShFjn5_MO3hkbMpAc9F48WtTxPF-zrL349xFhUmdV7lX7Zv_YKf-TQDXqucyrBaFxrdNmc9815gfSGMX',
    },
    {
      'id': '#INC-8809',
      'title': 'Mantenimiento ascensor',
      'location': 'Ascensor Principal',
      'date': '23 Oct 2023, 09:15',
      'priority': 'HIGH',
      'status': 'TODO',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAAsMGoGnLAknXadm6gBkgjmYYka1Z6HbLFtLzVEYY-NJGVnIQZs2QNip4joHAEUehIzHvhQvdXB5dIcCJpo5H2LgQ4KkzDoVE2H4Czj09marV9USnEc1qww4NfJabuWf1h3mVv337MzrPEBwi80Tkoj81j-QhDpA6BcvcQ08DuyEBFdPCRLIzBkNInQy_4wZmQ0lvw1HotiDGby6bnLTtHcdr-3irNub_qOo5OoFYz2Fbu2DlyNi8CoaPgzu77oBHIhHm43usEHHy8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF101922) : const Color(0xFFF6F7F8);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      _buildSearchBar(isDark),
                      _buildTabs(isDark),
                      _buildIncidentList(isDark),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildBottomNavBar(isDark),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: _primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF36E35), Color(0xFFFF8B42)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                // Logo placeholder
                const Text(
                  'drop',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Incidencias',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'GESTIÓN',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar incidencia...',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white54 : Colors.grey[500],
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.search, color: isDark ? Colors.white54 : Colors.grey[400]),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: isDark ? Colors.white70 : Colors.grey[700]),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: _tabs.map((tab) {
          final isSelected = tab == _selectedTab;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryBlue : (isDark ? const Color(0xFF1E293B) : Colors.white),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: _primaryBlue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : null,
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.grey[700]),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIncidentList(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _incidents.length,
      itemBuilder: (context, index) {
        final incident = _incidents[index];
        return _buildIncidentCard(incident, isDark);
      },
    );
  }

  Widget _buildIncidentCard(Map<String, dynamic> incident, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: incident['image'],
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 72,
                height: 72,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
              ),
              errorWidget: (context, url, error) => Container(
                width: 72,
                height: 72,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'ID: ${incident['id']}',
                        style: TextStyle(
                          color: isDark ? Colors.grey[500] : Colors.grey[400],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildBadge(incident['priority']),
                        const SizedBox(width: 4),
                        _buildBadge(incident['status']),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  incident['title'],
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  incident['location'],
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        incident['date'],
                        style: TextStyle(
                          color: isDark ? Colors.grey[500] : Colors.grey[500],
                          fontSize: 12,
                        ),
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
    );
  }

  Widget _buildBadge(String text) {
    Color bgColor;
    Color textColor;

    switch (text) {
      case 'HIGH':
        bgColor = const Color(0xFFFFE4E6); // red-100
        textColor = const Color(0xFFE11D48); // red-600
        break;
      case 'MEDIUM':
        bgColor = const Color(0xFFFEF9C3); // yellow-100
        textColor = const Color(0xFFA16207); // yellow-700
        break;
      case 'LOW':
        bgColor = const Color(0xFFD1FAE5); // emerald-100
        textColor = const Color(0xFF059669); // emerald-600
        break;
      case 'TODO':
        bgColor = const Color(0xFFFFEDD5); // orange-100
        textColor = const Color(0xFFEA580C); // orange-600
        break;
      case 'IN PROGRESS':
        bgColor = const Color(0xFFDBEAFE); // blue-100
        textColor = const Color(0xFF2563EB); // blue-600
        break;
      case 'DONE':
        bgColor = const Color(0xFFD1FAE5); // emerald-100
        textColor = const Color(0xFF059669); // emerald-600
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(bool isDark) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(bottom: 24, top: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A).withOpacity(0.9) : Colors.white.withOpacity(0.95),
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'INICIO', false, isDark),
            _buildNavItem(Icons.format_list_bulleted, 'MIS INCIDENCIAS', true, isDark),
            _buildNavItem(Icons.person, 'PERFIL', false, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, bool isDark) {
    final color = isActive ? _primaryBlue : (isDark ? Colors.grey[500] : Colors.grey[400]);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
