import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base.g.dart';

abstract class DomainObject extends Equatable {
  const DomainObject(this.id);

  final String id;

  @override
  bool? get stringify => false;

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return '${this.runtimeType} {id: $id}';
  }
}

enum Gender {
  male,
  female,
}

abstract class FavoriteObject {
  const FavoriteObject(this.id, this.title, this.imagePath, this.color);

  final String id;
  final String title;
  final String imagePath;
  final int color;
}

@JsonSerializable()
@immutable
class FirebaseEmail {
  final String? email;
  final bool? verified;

  factory FirebaseEmail.fromJson(Map<String, Object?> json) => _$FirebaseEmailFromJson(json);

  FirebaseEmail(this.email, this.verified);

  @override
  Map<String, Object?> toJson() => _$FirebaseEmailToJson(this);
}

@JsonSerializable()
@immutable
class FirebasePhone {
  final String? phoneNumber;
  final bool? verified;

  factory FirebasePhone.fromJson(Map<String, Object?> json) => _$FirebasePhoneFromJson(json);

  FirebasePhone(this.phoneNumber, this.verified);

  @override
  Map<String, Object?> toJson() => _$FirebasePhoneToJson(this);
}
