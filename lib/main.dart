import 'dart:io';

import 'package:mspmis/page/beneficiaries/beneficiaries_list_2_page.dart';
import 'package:mspmis/page/beneficiaries/find_beneficiary_auto_page.dart';
import 'package:mspmis/page/beneficiaries/find_beneficiary_page.dart';
import 'package:mspmis/page/find_program/find_program_page.dart';
import 'package:mspmis/page/loading/LoadingPage.dart';
import 'package:mspmis/page/payment/payment_detail_page.dart';
import 'package:mspmis/page/payment/payment_history_2_page.dart';
import 'package:mspmis/page/productivemeasure/groupement_suivi_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mspmis/contanst/contanst.dart';
import 'package:mspmis/page/productivemeasure/find_groupement_auto_page.dart';
import 'package:mspmis/page/productivemeasure/groupement_member_page.dart';
import 'package:mspmis/page/productivemeasure/productivemeasure_page.dart';
import 'package:mspmis/page/vouchers/vouchers_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'page/main/main_page.dart';
import 'generated/i18n.dart';
import 'page/create_account/create_account_page.dart';
import 'page/forgot_password/forgot_password_page.dart';
import 'package:mspmis/page/payment/payment_history_page.dart';

import 'page/signin/signin_page.dart';
import 'page/signup/signup_page.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_home_page.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_grievance_detail_page.dart';


void main() {
  /*if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }*/
 // databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'e-SPMIS Demo',
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    MediaQuery.of(context).size.width <= 400 ? 0.8 : 1.0),
          );
        },
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            //backgroundColor: Color(0xFFe2e2e2),
            primaryColor: R.color.blue,
            accentColor: Colors.white,
            //scaffoldBackgroundColor: Color(0xFFe2e2e2),
            fontFamily: 'Poppins'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.

        home: SignInPage
            .ProviderPage(), //MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          RouterName.SIGN_IN: (context) => SignInPage.ProviderPage(),
          RouterName.SIGN_UP: (context) => SignUpPage.ProviderPage(),
          RouterName.FORGOT_PASSWORD: (context) =>
              ForgotPasswordPage.ProviderPage(),
          RouterName.CREATE_ACCOUNT: (context) =>
              CreateAccountPage.ProviderPage(),
           RouterName.VOUCHERS_MENU: (context) => VouchersPage(),
          RouterName.BENEFICIARY_MENU: (context) => BeneficiariesHomePage(),
          //RouterName.PAYMENTS_MENU: (context) => PaymentListPage(),
          RouterName.PRODUCTIVEMEASURE_MENU: (context) => ProductiveMeasurePage(),
          RouterName.LOADING: (context) => LoadingPage(),
          RouterName.FIND_BENEFICIARY: (context) =>
              FindBeneficiaryAutoCompletePage(),
          RouterName.FIND_GROUPEMENT: (context) =>
              FindGroupementAutoCompletePage(),
          RouterName.GROUPEMENT_MEMBER_LIST: (context) =>
              GroupementMemberPage(),
          RouterName.ADD_SUIVI_GROUPEMENT: (context) =>
              GroupementSuiviPage(),
          RouterName.BENEFICIARIES_LIST: (context) =>
              BeneficiaryPaginableDataTablePage(), //Be.ProviderPage(),
          RouterName.PAYMENT_DASHBOARD: (context) => PaymentDetailPage(),
          RouterName.ADD_PAYMENT: (context) => PaymentDetailPage(),
          RouterName.PAYMENT_HISTORY: (context) =>
              PaymentHistoryPaginableDataTablePage(),
          RouterName.GRIEVANCE_DETAIL: (context) =>
              BeneficiaryGrievanceDetailPage(),
        });
  }
}
