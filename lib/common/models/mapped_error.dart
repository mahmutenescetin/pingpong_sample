import 'package:equatable/equatable.dart';

class MappedError extends Equatable {
  final String? errorCode;
  final String? message;
  final String? description;
  final String? assetName;

  const MappedError({
    this.errorCode,
    this.message,
    this.description,
    this.assetName,
  });

  MappedError copyWith({
    String? errorCode,
    String? message,
    String? description,
    String? assetName,
  }) {
    return MappedError(
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
      description: description ?? this.description,
      assetName: assetName ?? this.assetName,
    );
  }

  factory MappedError.fromJson(Map<String, dynamic> json) {
    return MappedError(
      errorCode: json['errorCode'],
      message: json['message'],
      description: json['description'],
      assetName: json['assetName'],
    );
  }

  factory MappedError.somethingWentWrong() => MappedError(
        message: "Error",
        description: "Bir Şeyler ters gitti",
      );

  Map<String, dynamic> toJson() {
    return {
      'errorCode': errorCode,
      'message': message,
      'description': description,
      'assetName': assetName,
    };
  }

  @override
  String toString() {
    return '''MappedError(errorCode: $errorCode, message: $message, description: $description, assetName: $assetName)''';
  }

  @override
  List<Object?> get props => [errorCode, message, description, assetName];
}
