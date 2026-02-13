import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mediaUrlController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  // State
  String? _selectedCategory;
  String _selectedStatus = 'available';
  final List<String> _photos = [
    // Example initial photo as per design
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBojrkesIzb7rJDkf_lhwHaBqkFpNbeLc0nEprF6cpyEikJH9PS6Bro86NyDxHTty1XJlUkOlmJgHvXRPjXN4JEI7EGEv8HvMOKgerpA9B1ysZiyI62wXQWqXnNQRPblFMCu6aRLXbtTs52MFQvfQzU0ikENUaJ3lN0HVyMj-FATe-Jrzk-aLmRlkdKrZEULlt11LGsaz4rTiV2El9GW5IUMTmovRXxfAQYYzEQhzP8f3irY6i0VC6gGlQGxghqwo_wAzAXz_OfHwnC'
  ];
  final List<String> _tags = ['Friendly', 'Vaccinated'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
               Navigator.of(context).pop();
            }
          },
        ),
        title: const Text('Add New Pet'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: theme.dividerColor, height: 1.0)
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionHeader('General Info'),
                const SizedBox(height: 16),
                _buildTextField(label: 'Pet Name', hint: 'e.g. Buddy', controller: _nameController),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Category',
                  value: _selectedCategory,
                  items: const [
                    DropdownMenuItem(value: '1', child: Text('Dogs')),
                    DropdownMenuItem(value: '2', child: Text('Cats')),
                    DropdownMenuItem(value: '3', child: Text('Birds')),
                    DropdownMenuItem(value: '4', child: Text('Reptiles')),
                  ],
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  hint: 'Select category',
                ),
                const SizedBox(height: 24),

                _buildSectionHeader('Media'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _mediaUrlController,
                        decoration: const InputDecoration(
                          hintText: 'Paste photo URL',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: theme.colorScheme.primary),
                        onPressed: _addPhoto,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._photos.map((url) => _buildPhotoItem(url)),

                const SizedBox(height: 24),
                _buildSectionHeader('Inventory Details'),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Status',
                  value: _selectedStatus,
                  items: const [
                    DropdownMenuItem(value: 'available', child: Text('Available')),
                    DropdownMenuItem(value: 'pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'sold', child: Text('Sold')),
                  ],
                  onChanged: (val) => setState(() => _selectedStatus = val!),
                ),
                const SizedBox(height: 16),
                _buildTagsInput(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor.withOpacity(0.9),
              border: Border(top: BorderSide(color: theme.dividerColor)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Save Pet'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }

  Widget _buildDropdown({required String label, required String? value, required List<DropdownMenuItem<String>> items, required ValueChanged<String?> onChanged, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ),
        DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
      ],
    );
  }

  Widget _buildPhotoItem(String url) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: url,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () => setState(() => _photos.remove(url)),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 6),
          child: Text('Tags', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _tags.map((tag) => Chip(
                  label: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  backgroundColor: Theme.of(context).primaryColor,
                  deleteIcon: const Icon(Icons.close, size: 14, color: Colors.white),
                  onDeleted: () => setState(() => _tags.remove(tag)),
                  padding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                )).toList(),
              ),
              if (_tags.isNotEmpty) const SizedBox(height: 8),
              TextField(
                controller: _tagController,
                decoration: const InputDecoration(
                  hintText: 'Add a tag...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _tags.add(value);
                      _tagController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 4, top: 4),
          child: Text('Press enter to add multiple tags', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ),
      ],
    );
  }

  void _addPhoto() {
    if (_mediaUrlController.text.isNotEmpty) {
      setState(() {
        _photos.add(_mediaUrlController.text);
        _mediaUrlController.clear();
      });
    }
  }
}
