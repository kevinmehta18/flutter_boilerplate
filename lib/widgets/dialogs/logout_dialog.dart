import 'package:boilerplate/utils/helper_function.dart';
import 'package:boilerplate/widgets/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';


class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: AppLocalizations.of(context)!.logout,
      description: AppLocalizations.of(context)!.logoutWarning,
      cancelBtnText: AppLocalizations.of(context)!.no,
      confirmBtnText: AppLocalizations.of(context)!.yes,
      onCancelTap: () => context.pop(),
      onConfirmTap: () => _onConfirmTap(context),
    );
  }

  Future<void> _onConfirmTap(BuildContext context) async {
   await HelperFunction.clearAppData();
    context.go('/login',extra: {'replace': true});
  }
}
