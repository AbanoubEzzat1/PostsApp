import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/entites/post.dart';
import 'package:flutter_posts/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error/failures.dart';

class UpdatePostUseCase {
  final PostRepository postRepository;

  UpdatePostUseCase(this.postRepository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.updatePost(post);
  }
}
