import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/utils/base_page.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

abstract class BaseState<Page extends BaseStatefulWidget>
    extends ConsumerState<Page> {
  bool enablePincodeObserver;
  BaseState({this.enablePincodeObserver = true});
  StylishDialog? _progressDialog;

  @override
  void initState() {
    _initProgressDialog();
    super.initState();
  }

  void _initProgressDialog() {
    _progressDialog = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      contentText: 'Please wait...',
      dismissOnTouchOutside: false,
    );
  }

  Future<void> showProgressDialog() async {
    _initProgressDialog();
    if (_progressDialog != null) {
      await _progressDialog?.show();
    }
  }

  void dismissProgressDialog() {
    _progressDialog?.dismiss();
    _progressDialog = null;
  }
}
