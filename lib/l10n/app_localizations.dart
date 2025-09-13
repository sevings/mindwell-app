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

  /// App subtitle text for authentication screen
  ///
  /// In ru, this message translates to:
  /// **'Ваше осознанное путешествие начинается здесь'**
  String get appSubtitle;

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

  /// Email field label
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get email;

  /// Email or username field label
  ///
  /// In ru, this message translates to:
  /// **'Email или имя пользователя'**
  String get emailOrUsername;

  /// Password field label
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// Email field hint text
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш email'**
  String get emailHint;

  /// Email or username field hint text
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш email или имя пользователя'**
  String get emailOrUsernameHint;

  /// Password field hint text
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш пароль'**
  String get passwordHint;

  /// Login button text
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginButton;

  /// Forgot password link text
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get forgotPassword;

  /// Email validation error message
  ///
  /// In ru, this message translates to:
  /// **'Email обязателен'**
  String get emailRequired;

  /// Email or username validation error message
  ///
  /// In ru, this message translates to:
  /// **'Email или имя пользователя обязательно'**
  String get emailOrUsernameRequired;

  /// Email format validation error message
  ///
  /// In ru, this message translates to:
  /// **'Введите корректный email адрес'**
  String get emailInvalid;

  /// Password validation error message
  ///
  /// In ru, this message translates to:
  /// **'Пароль обязателен'**
  String get passwordRequired;

  /// Password length validation error message
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен содержать минимум 6 символов'**
  String get passwordTooShort;

  /// Username field label
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя'**
  String get username;

  /// Username field hint text
  ///
  /// In ru, this message translates to:
  /// **'Введите ваше имя пользователя'**
  String get usernameHint;

  /// Username validation error message
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя обязательно'**
  String get usernameRequired;

  /// Username length validation error message
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя должно содержать минимум 3 символа'**
  String get usernameTooShort;

  /// Username format validation error message
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя может содержать только буквы, цифры и подчеркивания'**
  String get usernameInvalid;

  /// Register button text
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get registerButton;

  /// Confirm password field label
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get confirmPassword;

  /// Confirm password field hint text
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите ваш пароль'**
  String get confirmPasswordHint;

  /// Confirm password validation error message
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, подтвердите ваш пароль'**
  String get confirmPasswordRequired;

  /// Password confirmation validation error message
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get passwordsDoNotMatch;

  /// Password strength indicator label
  ///
  /// In ru, this message translates to:
  /// **'Надежность пароля'**
  String get passwordStrength;

  /// Weak password strength label
  ///
  /// In ru, this message translates to:
  /// **'Слабый'**
  String get passwordStrengthWeak;

  /// Medium password strength label
  ///
  /// In ru, this message translates to:
  /// **'Средний'**
  String get passwordStrengthMedium;

  /// Strong password strength label
  ///
  /// In ru, this message translates to:
  /// **'Сильный'**
  String get passwordStrengthStrong;

  /// Terms of Service link text
  ///
  /// In ru, this message translates to:
  /// **'Условиями использования'**
  String get termsOfService;

  /// Privacy Policy link text
  ///
  /// In ru, this message translates to:
  /// **'Политикой конфиденциальности'**
  String get privacyPolicy;

  /// Terms agreement text with placeholders
  ///
  /// In ru, this message translates to:
  /// **'Регистрируясь, вы соглашаетесь с нашими {termsOfService} и {privacyPolicy}'**
  String agreeToTerms(String termsOfService, String privacyPolicy);

  /// Gender field label
  ///
  /// In ru, this message translates to:
  /// **'Пол'**
  String get gender;

  /// Gender field hint text
  ///
  /// In ru, this message translates to:
  /// **'Выберите ваш пол'**
  String get genderHint;

  /// Gender default option
  ///
  /// In ru, this message translates to:
  /// **'Не указан'**
  String get genderNotSet;

  /// Male gender option
  ///
  /// In ru, this message translates to:
  /// **'Мужской'**
  String get genderMale;

  /// Female gender option
  ///
  /// In ru, this message translates to:
  /// **'Женский'**
  String get genderFemale;

  /// Tab label for invited entries
  ///
  /// In ru, this message translates to:
  /// **'Приглашенные'**
  String get invited;

  /// Tab label for waiting entries
  ///
  /// In ru, this message translates to:
  /// **'Ожидающие'**
  String get waiting;

  /// Tab label for discussed entries
  ///
  /// In ru, this message translates to:
  /// **'Обсуждаемое'**
  String get discussed;

  /// Tab label for weekly best entries
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get week;

  /// Tab label for monthly best entries
  ///
  /// In ru, this message translates to:
  /// **'Месяц'**
  String get month;

  /// Tab label for yearly best entries
  ///
  /// In ru, this message translates to:
  /// **'Год'**
  String get year;

  /// Tab label for friends entries
  ///
  /// In ru, this message translates to:
  /// **'Друзья'**
  String get friends;

  /// Tab label for watching entries
  ///
  /// In ru, this message translates to:
  /// **'Отслеживаемые'**
  String get watching;

  /// Tab label for entries
  ///
  /// In ru, this message translates to:
  /// **'Записи'**
  String get entries;

  /// Tab label for replies
  ///
  /// In ru, this message translates to:
  /// **'Ответы'**
  String get replies;
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
