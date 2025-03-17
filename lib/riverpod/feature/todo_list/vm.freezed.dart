// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoListPageState {
  List<Todo> get todos;

  /// Create a copy of TodoListPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodoListPageStateCopyWith<TodoListPageState> get copyWith =>
      _$TodoListPageStateCopyWithImpl<TodoListPageState>(
          this as TodoListPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodoListPageState &&
            const DeepCollectionEquality().equals(other.todos, todos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(todos));

  @override
  String toString() {
    return 'TodoListPageState(todos: $todos)';
  }
}

/// @nodoc
abstract mixin class $TodoListPageStateCopyWith<$Res> {
  factory $TodoListPageStateCopyWith(
          TodoListPageState value, $Res Function(TodoListPageState) _then) =
      _$TodoListPageStateCopyWithImpl;
  @useResult
  $Res call({List<Todo> todos});
}

/// @nodoc
class _$TodoListPageStateCopyWithImpl<$Res>
    implements $TodoListPageStateCopyWith<$Res> {
  _$TodoListPageStateCopyWithImpl(this._self, this._then);

  final TodoListPageState _self;
  final $Res Function(TodoListPageState) _then;

  /// Create a copy of TodoListPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
  }) {
    return _then(_self.copyWith(
      todos: null == todos
          ? _self.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc

class _TodoPageState implements TodoListPageState {
  const _TodoPageState({required final List<Todo> todos}) : _todos = todos;

  final List<Todo> _todos;
  @override
  List<Todo> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  /// Create a copy of TodoListPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodoPageStateCopyWith<_TodoPageState> get copyWith =>
      __$TodoPageStateCopyWithImpl<_TodoPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TodoPageState &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_todos));

  @override
  String toString() {
    return 'TodoListPageState(todos: $todos)';
  }
}

/// @nodoc
abstract mixin class _$TodoPageStateCopyWith<$Res>
    implements $TodoListPageStateCopyWith<$Res> {
  factory _$TodoPageStateCopyWith(
          _TodoPageState value, $Res Function(_TodoPageState) _then) =
      __$TodoPageStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Todo> todos});
}

/// @nodoc
class __$TodoPageStateCopyWithImpl<$Res>
    implements _$TodoPageStateCopyWith<$Res> {
  __$TodoPageStateCopyWithImpl(this._self, this._then);

  final _TodoPageState _self;
  final $Res Function(_TodoPageState) _then;

  /// Create a copy of TodoListPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todos = null,
  }) {
    return _then(_TodoPageState(
      todos: null == todos
          ? _self._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

// dart format on
