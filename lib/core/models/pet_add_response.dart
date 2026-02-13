import 'dart:convert';

class PetAddResponse {
  final int id;
  final Category? category;
  final String name;
  final List<String> photoUrls;
  final List<Tag>? tags;
  final String status;

  PetAddResponse({
    required this.id,
    this.category,
    required this.name,
    required this.photoUrls,
    this.tags,
    required this.status,
  });

  // Método para transformar el JSON (Map) a la clase de Dart
  factory PetAddResponse.fromJson(Map<String, dynamic> json) {
    return PetAddResponse(
      id: json['id'] as int,
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      name: json['name'] ?? '',
      photoUrls: List<String>.from(json['photoUrls'] ?? []),
      tags: json['tags'] != null
          ? (json['tags'] as List).map((i) => Tag.fromJson(i)).toList()
          : null,
      status: json['status'] ?? 'unknown',
    );
  }

  // Método para transformar la clase de vuelta a JSON (Map)
  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category?.toJson(),
    'name': name,
    'photoUrls': photoUrls,
    'tags': tags?.map((t) => t.toJson()).toList(),
    'status': status,
  };
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'] as int, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Tag {
  final int id;
  final String name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['id'] as int, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
