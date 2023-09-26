import 'package:mspmis/utils/dataTable/extensions/textstyle_extension.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key key,
    this.titleText = 'Your Title',
    this.child,
    this.showAppBar = true,
    this.showDrawer = false,
    this.showAppBarActions = false,
    this.enableDarkMode = false,
    this.isInAsyncCall = false,
    this.drawerChild,
    Widget bottomSheet,
    this.actions,
  })  : _bottomSheet = bottomSheet,
        super(key: key);

  final String titleText;
  final Widget child;
  final bool showAppBar;
  final bool showAppBarActions;
  final bool showDrawer;
  final bool enableDarkMode;
  final Widget drawerChild;
  final Widget _bottomSheet;
  final List<Widget> actions;
  final bool isInAsyncCall;

  static TextStyle get light => TextStyle().c(Colors.black);
  static TextStyle get dark => TextStyle().c(Colors.white);

  List<Widget> get _showActions {
    if (showAppBarActions) {
      return actions;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
        body: ModalProgressHUD(
            child: ListView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                child,
              ],
            ),
            inAsyncCall: isInAsyncCall,
            // demo of some additional parameters
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator()));
  }
}
