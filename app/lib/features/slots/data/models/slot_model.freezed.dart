// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SlotModel {

 String get timeSlot; String get status; String? get bookingId; String? get userId;
/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotModelCopyWith<SlotModel> get copyWith => _$SlotModelCopyWithImpl<SlotModel>(this as SlotModel, _$identity);

  /// Serializes this SlotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotModel&&(identical(other.timeSlot, timeSlot) || other.timeSlot == timeSlot)&&(identical(other.status, status) || other.status == status)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeSlot,status,bookingId,userId);

@override
String toString() {
  return 'SlotModel(timeSlot: $timeSlot, status: $status, bookingId: $bookingId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $SlotModelCopyWith<$Res>  {
  factory $SlotModelCopyWith(SlotModel value, $Res Function(SlotModel) _then) = _$SlotModelCopyWithImpl;
@useResult
$Res call({
 String timeSlot, String status, String? bookingId, String? userId
});




}
/// @nodoc
class _$SlotModelCopyWithImpl<$Res>
    implements $SlotModelCopyWith<$Res> {
  _$SlotModelCopyWithImpl(this._self, this._then);

  final SlotModel _self;
  final $Res Function(SlotModel) _then;

/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timeSlot = null,Object? status = null,Object? bookingId = freezed,Object? userId = freezed,}) {
  return _then(_self.copyWith(
timeSlot: null == timeSlot ? _self.timeSlot : timeSlot // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotModel].
extension SlotModelPatterns on SlotModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotModel value)  $default,){
final _that = this;
switch (_that) {
case _SlotModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotModel value)?  $default,){
final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String timeSlot,  String status,  String? bookingId,  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
return $default(_that.timeSlot,_that.status,_that.bookingId,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String timeSlot,  String status,  String? bookingId,  String? userId)  $default,) {final _that = this;
switch (_that) {
case _SlotModel():
return $default(_that.timeSlot,_that.status,_that.bookingId,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String timeSlot,  String status,  String? bookingId,  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _SlotModel() when $default != null:
return $default(_that.timeSlot,_that.status,_that.bookingId,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlotModel extends SlotModel {
  const _SlotModel({required this.timeSlot, required this.status, this.bookingId, this.userId}): super._();
  factory _SlotModel.fromJson(Map<String, dynamic> json) => _$SlotModelFromJson(json);

@override final  String timeSlot;
@override final  String status;
@override final  String? bookingId;
@override final  String? userId;

/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotModelCopyWith<_SlotModel> get copyWith => __$SlotModelCopyWithImpl<_SlotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotModel&&(identical(other.timeSlot, timeSlot) || other.timeSlot == timeSlot)&&(identical(other.status, status) || other.status == status)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeSlot,status,bookingId,userId);

@override
String toString() {
  return 'SlotModel(timeSlot: $timeSlot, status: $status, bookingId: $bookingId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$SlotModelCopyWith<$Res> implements $SlotModelCopyWith<$Res> {
  factory _$SlotModelCopyWith(_SlotModel value, $Res Function(_SlotModel) _then) = __$SlotModelCopyWithImpl;
@override @useResult
$Res call({
 String timeSlot, String status, String? bookingId, String? userId
});




}
/// @nodoc
class __$SlotModelCopyWithImpl<$Res>
    implements _$SlotModelCopyWith<$Res> {
  __$SlotModelCopyWithImpl(this._self, this._then);

  final _SlotModel _self;
  final $Res Function(_SlotModel) _then;

/// Create a copy of SlotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timeSlot = null,Object? status = null,Object? bookingId = freezed,Object? userId = freezed,}) {
  return _then(_SlotModel(
timeSlot: null == timeSlot ? _self.timeSlot : timeSlot // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
