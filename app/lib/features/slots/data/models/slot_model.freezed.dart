// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SlotModel _$SlotModelFromJson(Map<String, dynamic> json) {
  return _SlotModel.fromJson(json);
}

/// @nodoc
mixin _$SlotModel {
  String get timeSlot => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get bookingId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  /// Serializes this SlotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SlotModelCopyWith<SlotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlotModelCopyWith<$Res> {
  factory $SlotModelCopyWith(SlotModel value, $Res Function(SlotModel) then) =
      _$SlotModelCopyWithImpl<$Res, SlotModel>;
  @useResult
  $Res call({
    String timeSlot,
    String status,
    String? bookingId,
    String? userId,
  });
}

/// @nodoc
class _$SlotModelCopyWithImpl<$Res, $Val extends SlotModel>
    implements $SlotModelCopyWith<$Res> {
  _$SlotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeSlot = null,
    Object? status = null,
    Object? bookingId = freezed,
    Object? userId = freezed,
  }) {
    return _then(
      _value.copyWith(
            timeSlot: null == timeSlot
                ? _value.timeSlot
                : timeSlot // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            bookingId: freezed == bookingId
                ? _value.bookingId
                : bookingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SlotModelImplCopyWith<$Res>
    implements $SlotModelCopyWith<$Res> {
  factory _$$SlotModelImplCopyWith(
    _$SlotModelImpl value,
    $Res Function(_$SlotModelImpl) then,
  ) = __$$SlotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String timeSlot,
    String status,
    String? bookingId,
    String? userId,
  });
}

/// @nodoc
class __$$SlotModelImplCopyWithImpl<$Res>
    extends _$SlotModelCopyWithImpl<$Res, _$SlotModelImpl>
    implements _$$SlotModelImplCopyWith<$Res> {
  __$$SlotModelImplCopyWithImpl(
    _$SlotModelImpl _value,
    $Res Function(_$SlotModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeSlot = null,
    Object? status = null,
    Object? bookingId = freezed,
    Object? userId = freezed,
  }) {
    return _then(
      _$SlotModelImpl(
        timeSlot: null == timeSlot
            ? _value.timeSlot
            : timeSlot // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        bookingId: freezed == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SlotModelImpl extends _SlotModel {
  const _$SlotModelImpl({
    required this.timeSlot,
    required this.status,
    this.bookingId,
    this.userId,
  }) : super._();

  factory _$SlotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlotModelImplFromJson(json);

  @override
  final String timeSlot;
  @override
  final String status;
  @override
  final String? bookingId;
  @override
  final String? userId;

  @override
  String toString() {
    return 'SlotModel(timeSlot: $timeSlot, status: $status, bookingId: $bookingId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotModelImpl &&
            (identical(other.timeSlot, timeSlot) ||
                other.timeSlot == timeSlot) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, timeSlot, status, bookingId, userId);

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotModelImplCopyWith<_$SlotModelImpl> get copyWith =>
      __$$SlotModelImplCopyWithImpl<_$SlotModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlotModelImplToJson(this);
  }
}

abstract class _SlotModel extends SlotModel {
  const factory _SlotModel({
    required final String timeSlot,
    required final String status,
    final String? bookingId,
    final String? userId,
  }) = _$SlotModelImpl;
  const _SlotModel._() : super._();

  factory _SlotModel.fromJson(Map<String, dynamic> json) =
      _$SlotModelImpl.fromJson;

  @override
  String get timeSlot;
  @override
  String get status;
  @override
  String? get bookingId;
  @override
  String? get userId;

  /// Create a copy of SlotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SlotModelImplCopyWith<_$SlotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
