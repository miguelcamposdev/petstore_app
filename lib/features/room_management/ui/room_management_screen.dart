import 'package:flutter/material.dart';

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  // Custom Colors from the design
  static const Color primaryColor = Color(0xFF137fec);
  static const Color backgroundLight = Color(0xFFf6f7f8);
  static const Color backgroundDark = Color(0xFF101922);

  // Status Colors
  static const Color statusGreenText = Color(0xFF16a34a); // text-green-600
  static const Color statusGreenBg = Color(0xFFdcfce7);   // bg-green-100
  static const Color statusAmberText = Color(0xFFd97706); // text-amber-600
  static const Color statusAmberBg = Color(0xFFfef3c7);   // bg-amber-100
  static const Color statusRoseText = Color(0xFFe11d48);  // text-rose-600
  static const Color statusRoseBg = Color(0xFFffe4e6);    // bg-rose-100

  // Icon Colors
  static const Color iconColor = Color(0xFF94a3b8);       // text-slate-400
  static const Color textDarkColor = Color(0xFF0f172a);   // text-slate-900

  // Inputs
  static const Color inputBgColor = Color(0xFFf1f5f9);    // bg-slate-100

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? backgroundDark : backgroundLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64.0),
        child: _buildAppBar(isDark),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilters(isDark),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Habitaciones',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildPicnicsCard(isDark),
              const SizedBox(height: 12),
              _buildRoomList(isDark),
              const SizedBox(height: 80), // Padding for bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildAppBar(bool isDark) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDN-OHAFZjCEqRWOZOGW5zSU7AJUykQvpQtdCoRLoQTa5VmiZeyPQQ2WsAu2CVh6pQSqVd3v7irlJYkKfZYbEFl4_HAq86fcNiCoTlTBmZ9tC0qSn_jyeCFyb0AWhr99qWVZVP1Llzl-a5sTpM8GnDvCI38HfTi2kVVD9RgImyNWGC4lY6OUKV_GG-SW2EOfcgxCo20mWJBpBRrkKYFo7gtAiZBaCAlQsY_blmgRcbzC8WnNy8VoFc9P1j_CMK_J3tWmKlSRdgs_Zo',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.water_drop, color: primaryColor, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Drop Rooms',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters(bool isDark) {
    final cardColor = isDark ? backgroundDark : Colors.white;
    final borderColor = isDark ? const Color(0xFF1e293b) : const Color(0xFFf1f5f9); // slate-800 / slate-100

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border(
          bottom: BorderSide(color: borderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterLabel('Fecha'),
          const SizedBox(height: 4),
          _buildDropdown(isDark),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterLabel('Ciudad'),
                    const SizedBox(height: 4),
                    _buildTextInput('Madrid', isDark),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterLabel('Alojamiento'),
                    const SizedBox(height: 4),
                    _buildTextInput('Residencia Sol', isDark),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: iconColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDropdown(bool isDark) {
    final bgColor = isDark ? const Color(0xFF1e293b) : inputBgColor; // slate-800 : slate-100
    final textColor = isDark ? Colors.white : textDarkColor;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Seleccionar fecha',
              style: TextStyle(color: textColor, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.expand_more, color: iconColor),
        ],
      ),
    );
  }

  Widget _buildTextInput(String hint, bool isDark) {
    final bgColor = isDark ? const Color(0xFF1e293b) : inputBgColor; // slate-800 : slate-100
    final textColor = isDark ? Colors.white : textDarkColor;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(hint, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }

  Widget _buildPicnicsCard(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primaryColor.withValues(alpha: 0.1),
          border: Border.all(color: primaryColor.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.restaurant, color: Colors.white, size: 24), // Using restaurant icon as substitute for nutrition
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PICNICS',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '0 picnics solicitados',
                          style: TextStyle(
                            color: primaryColor.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomList(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildRoomCard(
            roomNumber: '101',
            roomType: 'HAB',
            bedIcon: Icons.king_bed,
            bedType: 'Doble',
            occupancyIcon: Icons.person,
            occupancyStatus: 'Ocupada',
            occupancyColor: statusGreenText,
            actionIcon: Icons.check_circle,
            actionText: 'Limpia',
            actionTextColor: statusGreenText,
            actionBgColor: isDark ? statusGreenText.withValues(alpha: 0.3) : statusGreenBg,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildRoomCard(
            roomNumber: '102',
            roomType: 'TEACHER',
            roomTypeColor: primaryColor,
            bedIcon: Icons.single_bed,
            bedType: 'Indiv',
            occupancyIcon: Icons.person_off,
            occupancyStatus: 'Vacía',
            occupancyColor: iconColor,
            actionIcon: Icons.schedule,
            actionText: 'Proceso',
            actionTextColor: statusAmberText,
            actionBgColor: isDark ? statusAmberText.withValues(alpha: 0.3) : statusAmberBg,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildRoomCard(
            roomNumber: '103',
            roomType: 'HAB',
            bedIcon: Icons.king_bed,
            bedType: 'Suite',
            occupancyIcon: Icons.person,
            occupancyStatus: 'Ocupada',
            occupancyColor: statusGreenText,
            actionIcon: Icons.cleaning_services,
            actionText: 'Sucia',
            actionTextColor: statusRoseText,
            actionBgColor: isDark ? statusRoseText.withValues(alpha: 0.3) : statusRoseBg,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildRoomCard(
            roomNumber: '104',
            roomType: 'HAB',
            bedIcon: Icons.king_bed,
            bedType: 'Doble',
            occupancyIcon: Icons.person,
            occupancyStatus: 'Ocupada',
            occupancyColor: statusGreenText,
            actionIcon: Icons.check_circle,
            actionText: 'Limpia',
            actionTextColor: statusGreenText,
            actionBgColor: isDark ? statusGreenText.withValues(alpha: 0.3) : statusGreenBg,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard({
    required String roomNumber,
    required String roomType,
    Color roomTypeColor = iconColor,
    required IconData bedIcon,
    required String bedType,
    required IconData occupancyIcon,
    required String occupancyStatus,
    required Color occupancyColor,
    required IconData actionIcon,
    required String actionText,
    required Color actionTextColor,
    required Color actionBgColor,
    required bool isDark,
  }) {
    final cardBgColor = isDark ? const Color(0xFF1e293b) : Colors.white; // slate-800
    final borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFe2e8f0); // slate-700 : slate-200
    final textColor = isDark ? Colors.white : textDarkColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  child: Column(
                    children: [
                      Text(
                        roomNumber,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        roomType,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: roomTypeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: borderColor,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Icon(bedIcon, color: iconColor, size: 20),
                            Text(
                              bedType,
                              style: const TextStyle(color: iconColor, fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            Icon(occupancyIcon, color: occupancyColor, size: 20),
                            Text(
                              occupancyStatus,
                              style: TextStyle(color: occupancyColor, fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: actionBgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(actionIcon, color: actionTextColor, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      actionText,
                      style: TextStyle(
                        color: actionTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.more_vert, color: Color(0xFFcbd5e1), size: 24), // slate-300
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(bool isDark) {
    final navBgColor = isDark ? backgroundDark : Colors.white;
    final borderColor = isDark ? const Color(0xFF1e293b) : const Color(0xFFf1f5f9); // slate-800 / slate-100

    return Container(
      decoration: BoxDecoration(
        color: navBgColor,
        border: Border(
          top: BorderSide(color: borderColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.cleaning_services, 'Limpieza', true),
              _buildNavItem(Icons.report_problem, 'Incidencias', false),
              _buildNavItem(Icons.settings, 'Ajustes', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    final color = isActive ? primaryColor : iconColor;
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
