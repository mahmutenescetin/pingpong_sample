class Extension {
  final String code;
  final num limit;

  const Extension({
    required this.code,
    required this.limit,
  });

  factory Extension.fromJson(Map<String, dynamic> json) {
    return Extension(
      code: json['code'],
      limit: (json['limit'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'limit': limit,
    };
  }

  @override
  String toString() => '''Limits(code: $code, limit: $limit,)''';

  List<Object?> get props => [
        code,
        limit,
      ];
}
