import 'dart:ui';

const APP_URL = '197.241.42.179';

class R {
  static final image = _Images();
  static final color = _Color();
}

class _Images {
  final ic_appoitment = 'assets/images/ic_appoitment.svg';
  final ic_doctor = 'assets/images/ic_doctor.svg';
  final ic_drugs = 'assets/images/ic_drugs.svg';
  final btn_back_intro = 'assets/images/btn_back_intro.svg';
  final btn_next_intro = 'assets/images/btn_next_intro.svg';
  final ic_password = 'assets/images/ic_password.svg';
  final ic_forgot_pass = 'assets/images/ic_forgot_pass.svg';
  final ic_user = 'assets/images/ic_user.svg';
  final ic_back_grey = 'assets/images/ic_back_grey.svg';
  final ic_email = 'assets/images/ic_email.svg';
  final ic_edit_white = 'assets/images/ic_edit_white.svg';
  final ic_mail = 'assets/images/ic_mail.svg';
  final ic_menu_white = 'assets/images/ic_menu_white.svg';
  final ic_notification = 'assets/images/ic_notification.svg';
  final ic_search = 'assets/images/ic_search.svg';
  final ic_setting = 'assets/images/ic_setting.svg';
  final logo_healer = 'assets/images/logo_healer.svg';
  final avatar = 'assets/images/avatar.png';
  final ic_appointment_white = 'assets/images/ic_appointment_white.svg';
  final ic_doctor_white = 'assets/images/ic_doctor_white.svg';
  final ic_hospital_white = 'assets/images/ic_hospital_white.svg';
  final ic_price_services = 'assets/images/ic_price_services.svg';
  final ic_tabbar_dashboard_blue = 'assets/images/ic_tabbar_dashboard_blue.svg';
  final ic_tabbar_doctors_blue = 'assets/images/ic_tabbar_doctors_blue.svg';
  final ic_tabbar_drugs_blue = 'assets/images/ic_tabbar_drugs_blue.svg';
  final ic_tabbar_profile_blue = 'assets/images/ic_tabbar_profile_blue.svg';
  final ic_tabbar_dashboard_grey = 'assets/images/ic_tabbar_dashboard_grey.svg';
  final ic_tabbar_doctors_grey = 'assets/images/ic_tabbar_doctors_grey.svg';
  final ic_tabbar_drugs_grey = 'assets/images/ic_tabbar_drugs_grey.svg';
  final ic_tabbar_profile_grey = 'assets/images/ic_tabbar_profile_grey.svg';
  final ic_tabbar_services_white = 'assets/images/ic_tabbar_services_white.svg';
  final ic_tabbar_services_grey = 'assets/images/ic_tabbar_services_grey.svg';
  final ic_back_white = 'assets/images/ic_back_white.svg';
  final ic_location = 'assets/images/ic_location.svg';
  final ic_star_blue = 'assets/images/ic_star_blue.svg';
  final ic_more = 'assets/images/ic_more.svg';
  final rectangle = 'assets/images/rectangle.png';
  final ic_calendar_black = 'assets/images/ic_calendar_black.svg';
  final ic_clock_black = 'assets/images/ic_clock_black.svg';
  final ic_notify_drugs = 'assets/images/ic_notify_drugs.svg';
  final ic_notify_list = 'assets/images/ic_notify_list.svg';
  final ic_send_mss = 'assets/images/ic_send_mss.svg';
  final ic_add_grey = 'assets/images/ic_add_grey.svg';
  final ic_chat_white = 'assets/images/ic_chat_white.svg';
  final ic_clipboard_grey = 'assets/images/ic_clipboard_grey.svg';
  final ic_exit_white = 'assets/images/ic_exit_white.svg';
  final ic_phone_call_grey = 'assets/images/ic_phone_call_grey.svg';
  final ic_call_doctor = 'assets/images/ic_call_doctor.svg';
  final ic_chat_doctor = 'assets/images/ic_chat_doctor.svg';
  final ic_doctors_info = 'assets/images/ic_doctors_info.svg';
  final ic_hospital_blue = 'assets/images/ic_hospital_blue.svg';
  final ic_arrow_right = 'assets/images/ic_arrow_right.svg';
  final ic_remove = 'assets/images/ic_remove.svg';
  final ic_search_fill = 'assets/images/ic_search_fill.svg';
  final ic_baget = 'assets/images/ic_baget.svg';
  final ic_message_blue = 'assets/images/ic_message_blue.svg';
  final ic_phone_white = 'assets/images/ic_phone_white.svg';
  final ic_mute = 'assets/images/ic_mute.svg';
  final ic_done_blue = 'assets/images/ic_done_blue.svg';
  final ic_apple_health = 'assets/images/ic_apple_health.png';
  final ic_cerner = 'assets/images/ic_cerner.png';
  final ic_checked = 'assets/images/ic_checked.svg';
  final ic_desinfectant = 'assets/images/ic_desinfectant.svg';
  final ic_edit = 'assets/images/ic_edit.svg';
  final ic_ihealth = 'assets/images/ic_ihealth.png';
  final ic_miband = 'assets/images/ic_miband.png';
  final ic_transfusion = 'assets/images/ic_transfusion.svg';
  final ic_uncheck = 'assets/images/ic_uncheck.svg';
  final ic_weight = 'assets/images/ic_weight.svg';
  final ic_withings = 'assets/images/ic_withings.png';
  final ic_detail = 'assets/images/ic_detail.svg';
  final ic_goal = 'assets/images/ic_goal.svg';
  final ic_edit_goal = 'assets/images/ic_edit_goal.svg';
  final ic_doctor_fav = 'assets/images/ic_doctor_fav.svg';
  final ic_goals = 'assets/images/ic_goals.svg';
  final ic_personal_info = 'assets/images/ic_personal_info.svg';
  final ic_logo_hospital = 'assets/images/ic_logo_hospital.svg';
  final ic_drugs_child = 'assets/images/ic_drugs_child.svg';
  final ic_add_image = 'assets/images/ic_add_image.svg';
  final ic_demo_product = 'assets/images/ic_demo_product.svg';
  final ic_expand = 'assets/images/ic_expand.svg';
  final ic_shopping_bag = 'assets/images/ic_shopping_bag.svg';
  final img_new1 = 'assets/images/img_new1.png';
  final ic_bookmark = 'assets/images/ic_bookmark.svg';
  final img = 'assets/images/img.png';
  final ic_bookmark_news = 'assets/images/ic_bookmark_news.svg';
  final ic_comment_news = 'assets/images/ic_comment_news.svg';
  final ic_level_news = 'assets/images/ic_level_news.svg';
  final ic_like_news = 'assets/images/ic_like_news.svg';
  final ic_share_news = 'assets/images/ic_share_news.svg';
  final ic_location_white = 'assets/images/ic_location_white.svg';
  final ic_tabbar_addpayment_grey =
      'assets/images/ic_tabbar_addpayment_grey.svg';
  final ic_tabbar_addpayment_blue =
      'assets/images/ic_tabbar_addpayment_blue.svg';
  final ic_tabbar_addgrievance_grey =
      'assets/images/ic_tabbar_addgrievance_grey.svg';
  final ic_tabbar_addgrievance_blue =
      'assets/images/ic_tabbar_addgrievance_blue.svg';
  final ic_tabbar_addproductivemeasure_blue =
      'assets/images/ic_tabbar_addproductivemeasure_blue.svg';

  final ic_tabbar_historic_grey = 'assets/images/ic_tabbar_historic_grey.svg';
  final ic_tabbar_historic_blue = 'assets/images/ic_tabbar_historic_blue.svg';
  final ic_nfc_white = 'assets/images/ic_nfc_white.svg';
  // e-SPMIS
  final ic_scan_white = 'assets/images/ic_scan_white.svg';
  final ic_payment_site_white = 'assets/images/ic_payment_site_white.svg';
  final ic_payment_list_white = 'assets/images/ic_payment_list_white.svg';
  final ic_payment_transaction_white =
      'assets/images/ic_payment_transaction_white.svg';
  final ic_payment_white = 'assets/images/ic_payment_white.svg';
  final ic_grievances_white = 'assets/images/ic_grievances_white.svg';
  final ic_beneficiaries_white = 'assets/images/ic_beneficiaries_white.svg';
  final ic_modules_white = 'assets/images/ic_modules_white.svg';
  final ic_setup_white = 'assets/images/ic_setup_white.svg';
  final ic_history_white = 'assets/images/ic_history_white.svg';
  final ic_map_blue = 'assets/images/ic_map_blue.svg';
  final ic_tabbar_setting_grey = 'assets/images/ic_tabbar_setting_grey.svg';
  final ic_tabbar_setting_blue = 'assets/images/ic_tabbar_setting_blue.svg';
  final ic_tabbar_beneficiaries_blue =
      'assets/images/ic_tabbar_beneficiaries_blue.svg';
  final ic_tabbar_beneficiaries_grey =
      'assets/images/ic_tabbar_beneficiaries_grey.svg';

  final ic_productive_measures_white =
      'assets/images/ic_productive_measures_white.svg';
  final ic_groupement_white =
      'assets/images/ic_groupement_white.svg';
  final ic_tabbar_groupement_blue =
      'assets/images/ic_tabbar_groupement_blue.svg';
  final ic_subvention_white =
      'assets/images/ic_subvention_white.svg';
  final ic_tabbar_subvention_blue =
      'assets/images/ic_tabbar_subvention_blue.svg';
  final ic_activity_white =
      'assets/images/ic_activity_white.svg';
  final ic_tabbar_activity_blue =
      'assets/images/ic_tabbar_activity_blue.svg';
  final ic_training_white =
      'assets/images/ic_training_white.svg';
  final ic_tabbar_training_blue =
      'assets/images/ic_tabbar_training_blue.svg';
}

class _Color {
  final gray = Color(0xFF969696);
  final grey = Color(0xFF696969);
  final black = Color(0xFF131313);
  final white = Color(0xFFFFFFFF);
  final dark_black = Color(0xFF000000);
  final blue = Color(0xFF4B66EA);
  final light_blue = Color(0xFF82A0F6);
  final dark_blue = Color(0xFF4F6DE6);
  final dark_white = Color(0xFFE5E5E5);
}

class RouterName {
  /*
  eSPMIS Router
   */
  static const ADD_SUIVI_GROUPEMENT = 'groupement_suivi_page';
  static const GROUPEMENT_MEMBER_LIST = 'groupement_member_page';
  static const PRODUCTIVEMEASURE_MENU = 'productivemeasure_page';
  static const FIND_GROUPEMENT = 'find_groupement';
  static const PAYMENT_HISTORY = 'payment_history';
  static const ADD_PAYMENT = 'add_payment';
  static const SCAN_BARCODE = 'scan';
  static const FIND_PAYMENT = 'find_payment';
  static const FIND_BENEFICIARY = 'find_beneficiaries';
  static const PAYMENTS_MENU = 'payments';
  static const GRIEVANCES_MENU = 'grievances';
  static const BENEFICIARY_MENU = 'beneficiaries_menu';
  static const BENEFICIARIES_LIST = 'beneficiaries_list';
  static const GROUPEMENTS_LIST = 'groupements_list';
  static const MODULES_MENU = 'home';
  static const SETUPS_MENU = 'home';
  static const VOUCHERS_MENU = 'vouchers';
  static const PAYMENT_DASHBOARD = 'payment_dashboard';
  static const LOADING = 'loading';
  static const FIND_PROGRAM = 'find_program';
  static const BENEFICIARY_PROFILE = 'beneficiaries_profile';
  static const BENEFICIARY_PAYMENT_DETAIL = 'beneficiaries_payment_detail';
  static const ADD_GRIEVANCE = 'add_grievance';
  static const GRIEVANCE_DETAIL = 'beneficiaries_grievance_detail_page';

  //--------------
  static const SIGN_IN = 'sign_in';
  static const SIGN_UP = 'sign_up';
  static const FORGOT_PASSWORD = 'forgot_password';
  static const CREATE_ACCOUNT = 'create_account';
  static const MAIN = 'main';
  static const FIND_DOCTOR = 'find_doctor';

  static const FIND_HOSPITAL = 'find_hospital';
  static const CREATE_APPOINTMENT = 'create_appointment';
  static const APPOINTMENT_CALENDAR = "appointment_calendar";
  static const PRICE_SERVICE = 'price_service';
  static const APPOINTMENT_DETAIL = "appointment_detail";
  static const NOTIFICATION = "notification";
  static const CHAT_DOCTOR = "chat_doctor";
  static const DOCTORS_PROFILES = "doctors_profiles";
  static const CALLING_DOCTOR = "calling_doctor";
  static const MAP_DOCTORS = "map_doctors";
  static const INFORMATION_DOCTOR = "information_doctor";
  static const WORD_ADDRESS_DOCTOR = "word_address_doctor";
  static const REVIEW_DOCTOR = "review_doctor";
  static const BOOK_APPOINTMENT = "book_appointment";
  static const TEST_INDICATORS = "test_indicators";
  static const SETTING_TEST_INDICATORS = "setting_test_indicators";
  static const DETAIL_TEST_INDICATOR = "detail_test_indicator";
  static const SET_GOAL = "set_goal";
  static const GOAL_SETTING = "goal_setting";
  static const DOCTOR_FAVORITES = "doctor_favorites";
  static const INSURRANCE = "insurrance";
  static const ADD_DRUGS = "add_drugs";
  static const DRUGS_LIST = "drugs_list";
  static const DRUGS_DETAIL = "drugs_detail";
  static const DRUGS_SHOP = "drugs_shop";
  static const NEWS = "news";
  static const NEWS_BOOKMARK = "news_bookmark";
  static const NEWS_DETAIL = "news_detail";
  static const NEWS_COMMENT = "news_comment";
  static const RESULT_FIND_DOCTOR = "result_find_doctor";
  static const CREATE_ACCOUNT_BIRTHDAY = "create_account_birthday";
  static const CREATE_ACCOUNT_GENDER = "create_account_gender";
  static const CREATE_ACCOUNT_FULLNAME = "create_account_fullname";
  static const CREATE_ACCOUNT_HEIGHT = "create_account_height";
  static const CREATE_ACCOUNT_WEIGHT = "create_account_weight";
  static const DOCTOR_LIST = "doctor_list";
  static const HOSPITAL_LIST = "hospital_list";
  static const INPUT_TEST_INDICATORS = 'input_test_indicators';
}
