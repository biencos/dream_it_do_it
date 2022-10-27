// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:wishes_api/wishes_api.dart';

part 'wish.g.dart';

@immutable
@JsonSerializable()
class Wish extends Equatable {
  /// {@macro wish}
  Wish({
    String? id,
    required this.title,
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          "id can't be null and should be empty",
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final bool isCompleted;

  static Wish fromJson(JsonMap json) => _$WishFromJson(json);

  JsonMap toJson() => _$WishToJson(this);

  Wish copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return Wish(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object> get props => [id, title, isCompleted];
}
