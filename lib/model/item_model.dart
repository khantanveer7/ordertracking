class Item {
  final String name;
  final String tags;
  final String qty;
  final DateTime time;
  final String description;
  final String placeToDeliver;
  // final int phone;

  const Item({
    required this.name,
    required this.tags,
    required this.qty,
    required this.time,
    required this.description,
    required this.placeToDeliver,
    // required this.phone,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final dateStr = properties['Time']?['date']?['start'];
    return Item(
      name: properties['Name']?['title']?[0]?['plain_text'] ?? '?',
      tags: properties['Tags']?['select']?['name'] ?? 'Any',
      qty:
          properties['Qty']?['rich_text']?[0]?['text']?['content'] ?? "Tanveer",
      description: properties['Description']?['rich_text']?[0]?['text']
              ?['content'] ??
          "Tanveer",
      time: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),
      placeToDeliver: properties['Place to deliver']?['rich_text']?[0]?['text']
              ?['content'] ??
          '?',
      // phone: properties['Phone']['phone_number'],
    );
  }
}
