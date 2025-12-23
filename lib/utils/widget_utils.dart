import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orcal_ai_flutter/dialogs/build_embeddings_success_dialog.dart';
import 'package:orcal_ai_flutter/dialogs/error_dialog.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.white,
          size: 88,
        ),
      );
    },
  );
}

void showErrorDialog({
  required BuildContext context,
  required String errorMessage,
  required VoidCallback onTapOk,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return ErrorDialog(errorMessage: errorMessage, onTapOk: onTapOk);
    },
  );
}

void showBuildKnowledgeBaseSuccessDialog({
  required BuildContext context,
  required VoidCallback onTapOk,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BuildEmbeddingsSuccessDialog(onTapOk: onTapOk);
    },
  );
}
