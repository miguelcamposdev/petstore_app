import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddOrganizationScreen extends StatefulWidget {
  const AddOrganizationScreen({super.key});

  @override
  State<AddOrganizationScreen> createState() => _AddOrganizationScreenState();
}

class _AddOrganizationScreenState extends State<AddOrganizationScreen> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    _hostController.dispose();
    _postalCodeController.dispose();
    _addressController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use the primary blue color from the design, similar to AddIncidentScreen
    final Color primaryBlue = const Color(0xFF137FEC);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDOPt1QLVCdqJ7dA8PyJigO1bsLWLyl-yzG0Zx6zalvwVf4-8-pLSRtTT1YnBdsQ5vRPBLVozaUFGKSx5Je1-V_0AqprRgH58NOZRKr9RoyTvdr5g9xEbxOUhepZKjZL9GCjU5s5scZAfOXjfHmN1ZBUSmrFQxvjg8ksfCMjY2ypjTH6EUBZUPOHNhgJsLnTC74kSt-3Vdg1-E-mgVGXaqXymCyCdaFMkxKkNLoYb1opyAO8bmkDEwuZntdLjUd21-I5Z0h8Y1_HRs',
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                errorWidget: (context, url, error) => const Icon(Icons.water_drop, color: Colors.white),
              ),
            ),
          ),
        ),
        title: const Text(
          'Nueva Organización',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
                splashRadius: 20,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Map Section
              Container(
                height: 250,
                width: double.infinity,
                color: theme.colorScheme.surfaceVariant,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuCf_FNJZhQHn-wWHMYZS-wvcsbgS5yqTLsZ5RYVr-NgDTSdWakQbu9adGrZWpKFlM1Iy4ulTAvBpSdgLJ7ziwQdheT3S5bkAZu22LJZQVuGGNocVu53LJtU5wUUy-yFk4v5R1X5TDtW-eZMFM7oL8FAiqDBHKJBRjeshqTepGvbse_Rr-OpHDu7eZyF7qmXCcITpCrHuhBBDtOvspexb8n6H7j43QGKLvSXwK6u7LkfJi7rLc1h-c3_QBNUY0kGhYiFqOODeKZ1vfQ',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: theme.colorScheme.surfaceVariant),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.map, size: 50, color: Colors.grey)),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.location_on,
                        size: 48,
                        color: primaryBlue,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Column(
                        children: [
                          _buildMapControlButton(Icons.add, theme),
                          const SizedBox(height: 8),
                          _buildMapControlButton(Icons.remove, theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form Section
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: primaryBlue, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Detalles de la Organización',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildLabel('Buscar ciudad'),
                      TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: 'Escribe el nombre de la ciudad...',
                          prefixIcon: const Icon(Icons.search),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryBlue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Nombre del Host'),
                                TextField(
                                  controller: _hostController,
                                  decoration: InputDecoration(
                                    hintText: 'Ej. Corporativo Central',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: primaryBlue, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Código Postal'),
                                TextField(
                                  controller: _postalCodeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '00000',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: primaryBlue, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildLabel('Dirección completa'),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          hintText: 'Calle, número, colonia',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryBlue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.comment, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                          const SizedBox(width: 4),
                          _buildLabel('Comentarios de seguimiento'),
                        ],
                      ),
                      TextField(
                        controller: _commentsController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Agregue notas importantes sobre la organización o el contacto...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryBlue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Bottom Action Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 10,
                  )
                ],
                border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Save action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Organización guardada')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Guardar Organización',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControlButton(IconData icon, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: theme.colorScheme.onSurface),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
        ),
      ),
    );
  }
}
