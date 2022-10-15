import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts/core/strings/failures.dart';
import 'package:flutter_posts/core/strings/messages.dart';
import 'package:flutter_posts/features/posts/domain/entites/post.dart';
import 'package:flutter_posts/features/posts/domain/usecases/add_post.dart';
import 'package:flutter_posts/features/posts/domain/usecases/delet_post.dart';
import 'package:flutter_posts/features/posts/domain/usecases/update_post.dart';

import '../../../../../core/error/failures.dart';
import 'add_delete_update_post_states.dart';

class AddDeleteUpdateCubit extends Cubit<AddDeleteUpdateStates> {
  final AddPostUseCase addPostUseCase;
  final DeletPostUseCase deletPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  AddDeleteUpdateCubit({
    required this.addPostUseCase,
    required this.deletPostUseCase,
    required this.updatePostUseCase,
  }) : super(AddDeleteUpdateInitialState());

  static AddDeleteUpdateCubit getAddDeleteUpdateCubit(context) =>
      BlocProvider.of(context);

  Future addPost({required Post post}) async {
    emit(LoadingAddPostState());
    Either<Failure, Unit> response = await addPostUseCase.call(post);
    emit(
      response.fold(
        (failure) => ErrorAddPostState(message: _mapFailureToMessage(failure)),
        (_) => SuccessAddPostState(post: post, msg: ADD_SUCCESS_MESSAGE),
      ),
    );
  }

  Future updatePost({required Post post}) async {
    emit(LoadingUpdatePostState());
    Either<Failure, Unit> response = await updatePostUseCase.call(post);
    emit(
      response.fold(
        (failure) =>
            ErrorUpdatePostState(message: _mapFailureToMessage(failure)),
        (_) => SuccessUpdatePostState(post: post, msg: UPDATE_SUCCESS_MESSAGE),
      ),
    );
  }

  Future deletePost({required int postId}) async {
    emit(LoadingDeletePostState());
    Either<Failure, Unit> response = await deletPostUseCase.call(postId);
    emit(
      response.fold(
        (failure) =>
            ErrorDeletePostState(message: _mapFailureToMessage(failure)),
        (_) => SuccessDeletePostState(msg: DELETE_SUCCESS_MESSAGE),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
