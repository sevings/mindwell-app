import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// The title of the application
  ///
  /// In ru, this message translates to:
  /// **'Mindwell'**
  String get appTitle;

  /// Home screen title
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get home;

  /// New entry menu item
  ///
  /// In ru, this message translates to:
  /// **'Новая запись'**
  String get newEntry;

  /// My entries menu item
  ///
  /// In ru, this message translates to:
  /// **'Мои записи'**
  String get myEntries;

  /// Subscriptions menu item
  ///
  /// In ru, this message translates to:
  /// **'Подписки'**
  String get subscriptions;

  /// Live feed menu item
  ///
  /// In ru, this message translates to:
  /// **'Прямой эфир'**
  String get live;

  /// Best content menu item
  ///
  /// In ru, this message translates to:
  /// **'Лучшее'**
  String get best;

  /// Tlogs menu item
  ///
  /// In ru, this message translates to:
  /// **'Тлоги'**
  String get tlogs;

  /// Themes menu item
  ///
  /// In ru, this message translates to:
  /// **'Темы'**
  String get themes;

  /// Settings menu item
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// Help menu item
  ///
  /// In ru, this message translates to:
  /// **'Помощь'**
  String get help;

  /// News menu item
  ///
  /// In ru, this message translates to:
  /// **'Новости'**
  String get news;

  /// Rules menu item
  ///
  /// In ru, this message translates to:
  /// **'Правила'**
  String get rules;

  /// About menu item
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get about;

  /// Login button/menu item
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get login;

  /// Register button/menu item
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get register;

  /// Logout button
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get logout;

  /// Error screen title
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get error;

  /// Go home button
  ///
  /// In ru, this message translates to:
  /// **'На главную'**
  String get goHome;

  /// Error message when something goes wrong
  ///
  /// In ru, this message translates to:
  /// **'Что-то пошло не так'**
  String get somethingWentWrong;

  /// Message for unknown errors
  ///
  /// In ru, this message translates to:
  /// **'Произошла неизвестная ошибка'**
  String get unknownError;

  /// Feed/home content title
  ///
  /// In ru, this message translates to:
  /// **'Лента'**
  String get feed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
