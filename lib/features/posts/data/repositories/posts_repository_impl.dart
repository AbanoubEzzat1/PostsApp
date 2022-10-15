// ignore_for_file: prefer_generic_function_type_aliases

import 'package:flutter_posts/core/error/exceptions.dart';
import 'package:flutter_posts/core/network/network_info.dart';
import 'package:flutter_posts/features/posts/data/datasources/post_local_data_source.dart';
import 'package:flutter_posts/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:flutter_posts/features/posts/data/models/post_model.dart';
import 'package:flutter_posts/features/posts/domain/entites/post.dart';
import 'package:flutter_posts/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_posts/features/posts/domain/repositories/posts_repository.dart';

typedef Future<Unit> AddOrDeleteOrUpdatePost();

class PostsRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.postRemoteDataSource,
      required this.postLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => postRemoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => postRemoteDataSource.deletPost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => postRemoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      AddOrDeleteOrUpdatePost addOrDeleteOrUpdatePost) async {
    if (await networkInfo.isConnected) {
      try {
        await addOrDeleteOrUpdatePost();
        return const Right(unit);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
