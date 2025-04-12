import 'package:uuid/uuid.dart';

/// Базовый класс сущности
///
/// Реализует основную работу с сущностями
class BaseEntity {
  String? id;
  BaseEntity() {
    var uuid = Uuid();
    id = uuid.v1();
  }
}
