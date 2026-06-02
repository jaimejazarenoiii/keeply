import 'package:equatable/equatable.dart';

enum ResourceStatus {
  initial,
  loading,
  loaded,
  empty,
  error,
  submitting,
  success,
}

class ResourceState<T> extends Equatable {
  const ResourceState({
    this.status = ResourceStatus.initial,
    this.data,
    this.message,
    this.disabledIds = const {},
  });
  final ResourceStatus status;
  final T? data;
  final String? message;
  final Set<String> disabledIds;
  ResourceState<T> copyWith({
    ResourceStatus? status,
    T? data,
    String? message,
    Set<String>? disabledIds,
  }) => ResourceState<T>(
    status: status ?? this.status,
    data: data ?? this.data,
    message: message,
    disabledIds: disabledIds ?? this.disabledIds,
  );
  @override
  List<Object?> get props => [status, data, message, disabledIds];
}
