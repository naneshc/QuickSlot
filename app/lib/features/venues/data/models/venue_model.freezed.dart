// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VenueModel _$VenueModelFromJson(Map<String, dynamic> json) {
  return _VenueModel.fromJson(json);
}

/// @nodoc
mixin _$VenueModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  double get pricePerHour => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this VenueModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VenueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VenueModelCopyWith<VenueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VenueModelCopyWith<$Res> {
  factory $VenueModelCopyWith(
    VenueModel value,
    $Res Function(VenueModel) then,
  ) = _$VenueModelCopyWithImpl<$Res, VenueModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String location,
    String imageUrl,
    double pricePerHour,
    double rating,
    String description,
  });
}

/// @nodoc
class _$VenueModelCopyWithImpl<$Res, $Val extends VenueModel>
    implements $VenueModelCopyWith<$Res> {
  _$VenueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VenueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? location = null,
    Object? imageUrl = null,
    Object? pricePerHour = null,
    Object? rating = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            pricePerHour: null == pricePerHour
                ? _value.pricePerHour
                : pricePerHour // ignore: cast_nullable_to_non_nullable
                      as double,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VenueModelImplCopyWith<$Res>
    implements $VenueModelCopyWith<$Res> {
  factory _$$VenueModelImplCopyWith(
    _$VenueModelImpl value,
    $Res Function(_$VenueModelImpl) then,
  ) = __$$VenueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String location,
    String imageUrl,
    double pricePerHour,
    double rating,
    String description,
  });
}

/// @nodoc
class __$$VenueModelImplCopyWithImpl<$Res>
    extends _$VenueModelCopyWithImpl<$Res, _$VenueModelImpl>
    implements _$$VenueModelImplCopyWith<$Res> {
  __$$VenueModelImplCopyWithImpl(
    _$VenueModelImpl _value,
    $Res Function(_$VenueModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VenueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? location = null,
    Object? imageUrl = null,
    Object? pricePerHour = null,
    Object? rating = null,
    Object? description = null,
  }) {
    return _then(
      _$VenueModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        pricePerHour: null == pricePerHour
            ? _value.pricePerHour
            : pricePerHour // ignore: cast_nullable_to_non_nullable
                  as double,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VenueModelImpl extends _VenueModel {
  const _$VenueModelImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.imageUrl,
    required this.pricePerHour,
    required this.rating,
    required this.description,
  }) : super._();

  factory _$VenueModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VenueModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String location;
  @override
  final String imageUrl;
  @override
  final double pricePerHour;
  @override
  final double rating;
  @override
  final String description;

  @override
  String toString() {
    return 'VenueModel(id: $id, name: $name, type: $type, location: $location, imageUrl: $imageUrl, pricePerHour: $pricePerHour, rating: $rating, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VenueModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.pricePerHour, pricePerHour) ||
                other.pricePerHour == pricePerHour) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    location,
    imageUrl,
    pricePerHour,
    rating,
    description,
  );

  /// Create a copy of VenueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VenueModelImplCopyWith<_$VenueModelImpl> get copyWith =>
      __$$VenueModelImplCopyWithImpl<_$VenueModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VenueModelImplToJson(this);
  }
}

abstract class _VenueModel extends VenueModel {
  const factory _VenueModel({
    required final String id,
    required final String name,
    required final String type,
    required final String location,
    required final String imageUrl,
    required final double pricePerHour,
    required final double rating,
    required final String description,
  }) = _$VenueModelImpl;
  const _VenueModel._() : super._();

  factory _VenueModel.fromJson(Map<String, dynamic> json) =
      _$VenueModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get location;
  @override
  String get imageUrl;
  @override
  double get pricePerHour;
  @override
  double get rating;
  @override
  String get description;

  /// Create a copy of VenueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VenueModelImplCopyWith<_$VenueModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
