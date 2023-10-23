import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id? isarId = Isar.autoIncrement;
  final String name;
  final String lastname;
  final String birthDate;
  final List<String> addresses;

  User({
    this.isarId,
    required this.name,
    required this.lastname,
    required this.birthDate,
    required this.addresses,
  });

  User copyWith({
    Id? isarId,
    String? name,
    String? lastname,
    String? birthDate,
    List<String>? addresses,
  }) =>
      User(
        isarId: isarId ?? this.isarId,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        birthDate: birthDate ?? this.birthDate,
        addresses: addresses ?? this.addresses,
      );
}
