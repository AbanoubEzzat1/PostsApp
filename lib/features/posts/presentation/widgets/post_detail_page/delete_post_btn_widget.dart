import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts/core/util/snackbar_message.dart';
import 'package:flutter_posts/core/widgets/loading_widget.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_cubit.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_states.dart';
import 'package:flutter_posts/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';

import '../../pages/posts_pages.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdateCubit, AddDeleteUpdateStates>(
            listener: (context, state) {
              if (state is SuccessDeletePostState) {
                SnackBarMessage()
                    .showSuccessSnackBar(message: state.msg, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostsPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorDeletePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingDeletePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}
