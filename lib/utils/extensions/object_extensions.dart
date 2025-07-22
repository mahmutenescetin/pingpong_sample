extension ObjectExtensions on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;

  bool isAnyOf(List<Object?> items) {
    return items.contains(this);
  }
}
