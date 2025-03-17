// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepoHash() => r'c71e4c8248dcde76f3d016bd055c2d1d4024087d';

/// See also [todoRepo].
@ProviderFor(todoRepo)
final todoRepoProvider = AutoDisposeProvider<TodoRepository>.internal(
  todoRepo,
  name: r'todoRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodoRepoRef = AutoDisposeProviderRef<TodoRepository>;
String _$todoRepoCacheHash() => r'5dfb4037a3e36c49e8d44630dc907debfa23a1e1';

/// See also [TodoRepoCache].
@ProviderFor(TodoRepoCache)
final todoRepoCacheProvider =
    NotifierProvider<TodoRepoCache, Map<String, Todo>>.internal(
  TodoRepoCache.new,
  name: r'todoRepoCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepoCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoRepoCache = Notifier<Map<String, Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
