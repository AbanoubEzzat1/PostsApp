import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts/features/posts/domain/usecases/get_all_posts.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/posts/posts_states.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entites/post.dart';

class GetAllPostsCubit extends Cubit<GetAllPostsStates> {
  GetAllPostsCubit({required this.getAllPostsUseCase})
      : super(GetAllPostsInitialState());
  final GetAllPostsUseCase getAllPostsUseCase;
  static GetAllPostsCubit getPostsCubit(context) => BlocProvider.of(context);

  Future getAllPosts() async {
    emit(LoadingPostsState());
    Either<Failure, List<Post>> response = await getAllPostsUseCase.call();
    emit(
      response.fold(
        (failure) => ErrorPostsState(msg: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
