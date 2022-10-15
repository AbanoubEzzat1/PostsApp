import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error/failures.dart';
import '../entites/post.dart';

class GetAllPostsUseCase {
  final PostRepository postsRepository;

  GetAllPostsUseCase(this.postsRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
