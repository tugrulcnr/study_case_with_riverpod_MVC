import 'package:flutter/material.dart';
import 'package:voco_study_case/product/enum/project_enums.dart';

// ignore: non_constant_identifier_names
void CustomShowSnackBar(
    {required BuildContext context,
    required String message,
    SnackBarAction? action,
    EnumSnackBarType? type = EnumSnackBarType.message}) {
  FocusScope.of(context).unfocus();
  ScaffoldMessenger.of(context)
      .showSnackBar(_snackBar(message, action, type, context));
}

SnackBar _snackBar(String message, SnackBarAction? action,
    EnumSnackBarType? type, BuildContext context) {
  final snackBarContent = Text(
    message,
    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
  );

  Color backgroundColor;
  switch (type) {
    case EnumSnackBarType.success:
      backgroundColor = Colors.green;
      break;
    case EnumSnackBarType.error:
      backgroundColor = Colors.red;
      break;
    default:
      backgroundColor = Theme.of(context).colorScheme.surface;
      break;
  }

  return SnackBar(
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.fixed,
    content: snackBarContent,
    action: action,
    
  );
}
