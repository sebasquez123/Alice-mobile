  Map<String, dynamic> groupByCategory(List<dynamic> items) {
    final grouped = <String, List<dynamic>>{};
    for (var item in items) {
      final category = item.category?? 'Sin categoría';
      grouped.putIfAbsent(category, () => []).add(item);
    }
    return grouped;
  }