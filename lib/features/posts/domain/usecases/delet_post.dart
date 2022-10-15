import 'package:dartz/dartz.dart';
import 'package:flutter_posts/core/error/failures.dart';
import 'package:flutter_posts/features/posts/domain/repositories/posts_repository.dart';

class DeletPostUseCase {
  final PostRepository postsRepository;

  DeletPostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(int posId) async {
    return await postsRepository.deletePost(posId);
  }
}
