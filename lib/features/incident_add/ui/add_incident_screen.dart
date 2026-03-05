import 'package:flutter/material.dart';

class AddIncidentScreen extends StatefulWidget {
  const AddIncidentScreen({super.key});

  @override
  State<AddIncidentScreen> createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  int _currentStep = 1;

  // Step 1 State
  String? _selectedCategory = 'Mantenimiento';
  String? _selectedCity;
  String? _selectedLocation;

  // Step 2 State
  final TextEditingController _descriptionController = TextEditingController();

  void _nextStep() {
    setState(() {
      _currentStep = 2;
    });
  }

  void _submit() {
    // Handle submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Incidencia enviada')),
    );
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // We will use a primary color similar to the design #137fec
    final Color primaryBlue = const Color(0xFF137FEC);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        leading: _currentStep == 2
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => setState(() => _currentStep = 1),
              )
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
              ),
        title: const Text(
          'Nueva Incidencia',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildStepper(primaryBlue),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 100),
                  child: _currentStep == 1 ? _buildStep1(primaryBlue) : _buildStep2(primaryBlue),
                ),
              ),
            ],
          ),
          // Bottom Navigation for Step 2
          if (_currentStep == 2)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBottomNavItem(Icons.home_outlined, 'Inicio', false, primaryBlue),
                    _buildBottomNavItem(Icons.add_circle, 'Nueva', true, primaryBlue),
                    _buildBottomNavItem(Icons.history, 'Historial', false, primaryBlue),
                  ],
                ),
              ),
            ),
          // Action Button
          Positioned(
            bottom: _currentStep == 2 ? 64 : 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.9),
                border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
              ),
              child: ElevatedButton(
                onPressed: _currentStep == 1 ? _nextStep : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentStep == 1 ? 'Siguiente' : 'Enviar Incidencia',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Icon(_currentStep == 1 ? Icons.arrow_forward : Icons.send, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive, Color primaryColor) {
    final color = isActive ? primaryColor : Colors.grey.shade400;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStepper(Color primaryColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white; // slate-800 or white
    final textColor = isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569); // slate-300 or slate-600

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (_currentStep == 1) ...[
                  _buildStepCircle('1', isActive: true, primaryColor: primaryColor),
                  Container(
                    width: 48,
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                  ),
                  _buildStepCircle('2', isActive: false, primaryColor: primaryColor),
                ] else ...[
                  _buildCompletedStepCircle(primaryColor),
                  Container(
                    width: 24,
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: primaryColor.withOpacity(0.3),
                  ),
                  _buildCompletedStepCircle(primaryColor),
                  Container(
                    width: 24,
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: primaryColor.withOpacity(0.3),
                  ),
                  _buildStepCircle('3', isActive: true, primaryColor: primaryColor),
                ],
              ],
            ),
            Text(
              _currentStep == 1 ? 'Paso 1 de 2' : 'Paso 3 de 3',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCircle(String text, {required bool isActive, required Color primaryColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isActive) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      );
    } else {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9), // slate-700 or slate-100
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0), // slate-600 or slate-200
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8), // slate-400
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    }
  }

  Widget _buildCompletedStepCircle(Color primaryColor) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.check, size: 16, color: primaryColor),
    );
  }

  Widget _buildStep1(Color primaryColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A); // slate-100 or slate-900
    final subtitleColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B); // slate-400 or slate-500

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo de incidencia',
          style: TextStyle(color: titleColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecciona la categoría que mejor describa el problema.',
          style: TextStyle(color: subtitleColor, fontSize: 14),
        ),
        const SizedBox(height: 24),

        _buildCategoryCard(
          title: 'Mantenimiento',
          subtitle: 'Fontanería, electricidad, mobiliario...',
          icon: Icons.build,
          isSelected: _selectedCategory == 'Mantenimiento',
          onTap: () => setState(() => _selectedCategory = 'Mantenimiento'),
          primaryColor: primaryColor,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildCategoryCard(
          title: 'Informática',
          subtitle: 'Software, hardware, red, impresoras...',
          icon: Icons.computer,
          isSelected: _selectedCategory == 'Informática',
          onTap: () => setState(() => _selectedCategory = 'Informática'),
          primaryColor: primaryColor,
          isDark: isDark,
        ),

        const SizedBox(height: 40),
        Text(
          'Lugar',
          style: TextStyle(color: titleColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '¿Dónde ha ocurrido el incidente?',
          style: TextStyle(color: subtitleColor, fontSize: 14),
        ),
        const SizedBox(height: 16),

        Text(
          'CIUDAD',
          style: TextStyle(
            color: subtitleColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),

        // City Dropdown
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC), // slate-800 or slate-50
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedCity,
              hint: Text('Selecciona una ciudad', style: TextStyle(color: titleColor)),
              icon: Icon(Icons.expand_more, color: subtitleColor),
              items: ['Madrid', 'Barcelona', 'Valencia', 'Sevilla'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: titleColor)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCity = newValue;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Location Grid
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: [
            _buildLocationCard('Alojamiento', Icons.bed, isDark, primaryColor),
            _buildLocationCard('Aula', Icons.school, isDark, primaryColor),
            _buildLocationCard('Oficina', Icons.work, isDark, primaryColor),
            _buildLocationCard('Vehículo', Icons.directions_car, isDark, primaryColor),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color primaryColor,
    required bool isDark,
  }) {
    final titleColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    final subtitleColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final cardColor = isDark ? const Color(0xFF1E293B).withOpacity(0.5) : Colors.white;
    final borderColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.05) : cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryColor : borderColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withOpacity(0.1)
                    : (isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 28,
                color: isSelected
                    ? primaryColor
                    : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: primaryColor, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(String title, IconData icon, bool isDark, Color primaryColor) {
    final isSelected = _selectedLocation == title;
    final titleColor = isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569);
    final cardColor = isDark ? const Color(0xFF1E293B).withOpacity(0.5) : Colors.white;
    final borderColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);

    return GestureDetector(
      onTap: () => setState(() => _selectedLocation = title),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryColor.withOpacity(0.3) : borderColor,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8)),
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? primaryColor : titleColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2(Color primaryColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    final subtitleColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fotos y Descripción',
          style: TextStyle(color: titleColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Añade una evidencia visual y detalla el problema.',
          style: TextStyle(color: subtitleColor, fontSize: 14),
        ),
        const SizedBox(height: 24),

        Text(
          'IMÁGENES',
          style: TextStyle(
            color: subtitleColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),

        // Image Upload Area
        Container(
          width: double.infinity,
          height: 180, // aspect-video roughly
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B).withOpacity(0.3) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            // Dashed border representation (simplified in standard Flutter)
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.photo_camera,
                  color: subtitleColor,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Añadir Fotos',
                style: TextStyle(
                  color: subtitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'DESCRIPCIÓN',
          style: TextStyle(
            color: subtitleColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),

        // Description TextField
        TextField(
          controller: _descriptionController,
          maxLines: 5,
          style: TextStyle(color: titleColor),
          decoration: InputDecoration(
            hintText: 'Describe brevemente lo ocurrido...',
            hintStyle: TextStyle(color: subtitleColor),
            fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }
}
