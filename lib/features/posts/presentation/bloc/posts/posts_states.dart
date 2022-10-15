import 'package:equatable/equatable.dart';
import 'package:flutter_posts/features/posts/domain/entites/post.dart';

abstract class GetAllPostsStates extends Equatable {
  const GetAllPostsStates();

  @override
  List<Object?> get props => [];
}

class GetAllPostsInitialState extends GetAllPostsStates {}

class LoadingPostsState extends GetAllPostsStates {}

class LoadedPostsState extends GetAllPostsStates {
  final List<Post> posts;

  const LoadedPostsState({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class ErrorPostsState extends GetAllPostsStates {
  final String msg;

  const ErrorPostsState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
