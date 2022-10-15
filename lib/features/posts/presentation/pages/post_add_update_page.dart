import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts/core/util/snackbar_message.dart';
import 'package:flutter_posts/features/posts/domain/entites/post.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_cubit.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_states.dart';
import 'package:flutter_posts/features/posts/presentation/pages/posts_pages.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AddDeleteUpdateCubit, AddDeleteUpdateStates>(
            listener: (context, state) {
              if (state is SuccessAddPostState) {
                SnackBarMessage()
                    .showSuccessSnackBar(message: state.msg, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is SuccessUpdatePostState) {
                SnackBarMessage()
                    .showSuccessSnackBar(message: state.msg, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddPostState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              } else if (state is ErrorUpdatePostState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          )),
    );
  }
}
