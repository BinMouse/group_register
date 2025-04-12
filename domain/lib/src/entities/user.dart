import 'base_entity.dart';

/// Сущность пользователя
class User extends BaseEntity {
  String firstName;
  String lastName;
  String middleName;
  String groupID;
  String role;
  String address;
  String email;

  // неважные данные
  String? avatarUrl;

  User(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.groupID,
      required this.role,
      required this.address,
      required this.email,
      this.avatarUrl = "empty"});
}
