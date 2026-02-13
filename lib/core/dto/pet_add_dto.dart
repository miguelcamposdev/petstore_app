class PetAddDto {
  final int? id;
  final Category? category;
  final String name;
  final List<String> photoUrls;
  final List<Tag>? tags;
  final String? status;

  PetAddDto({
    this.id,
    this.category,
    required this.name,
    required this.photoUrls,
    this.tags,
    this.status,
  });

  factory PetAddDto.fromJson(Map<String, dynamic> json) {
    return PetAddDto(
      id: json['id'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      name: json['name'] ?? '',
      photoUrls: List<String>.from(json['photoUrls'] ?? []),
      tags: json['tags'] != null
          ? (json['tags'] as List).map((i) => Tag.fromJson(i)).toList()
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category?.toJson(),
      'name': name,
      'photoUrls': photoUrls,
      'tags': tags?.map((t) => t.toJson()).toList(),
      'status': status,
    };
  }
}

class Category {
  final int? id;
  final String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Tag {
  final int? id;
  final String? name;

  Tag({this.id, this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
