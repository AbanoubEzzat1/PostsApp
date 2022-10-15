// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';
import 'package:flutter_posts/features/posts/domain/entites/post.dart';

abstract class AddDeleteUpdateStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDeleteUpdateInitialState extends AddDeleteUpdateStates {}

//-- AddPostStates
class LoadingAddPostState extends AddDeleteUpdateStates {}

class SuccessAddPostState extends AddDeleteUpdateStates {
  final Post post;
  final String msg;

  SuccessAddPostState({required this.msg, required this.post});
  @override
  List<Object> get props => [post];
}

class ErrorAddPostState extends AddDeleteUpdateStates {
  final String message;

  ErrorAddPostState({required this.message});

  @override
  List<Object> get props => [message];
}

//-- UpdatePostStates
class LoadingUpdatePostState extends AddDeleteUpdateStates {}

class SuccessUpdatePostState extends AddDeleteUpdateStates {
  final Post post;
  final msg;
  SuccessUpdatePostState({required this.post, required this.msg});
  @override
  List<Object> get props => [post];
}

class ErrorUpdatePostState extends AddDeleteUpdateStates {
  final String message;

  ErrorUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

//-- DeletePostStates
class LoadingDeletePostState extends AddDeleteUpdateStates {}

class SuccessDeletePostState extends AddDeleteUpdateStates {
  final msg;

  SuccessDeletePostState({required this.msg});
}

class ErrorDeletePostState extends AddDeleteUpdateStates {
  final String message;

  ErrorDeletePostState({required this.message});

  @override
  List<Object> get props => [message];
}

// -- //
class LoadingAddDeleteUpdatePostState extends AddDeleteUpdateStates {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdateStates {
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdateStates {
  final String message;

  MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}
