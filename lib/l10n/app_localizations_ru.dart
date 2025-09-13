// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Mindwell';

  @override
  String get appSubtitle => 'Ваше осознанное путешествие начинается здесь';

  @override
  String get home => 'Главная';

  @override
  String get newEntry => 'Новая запись';

  @override
  String get myEntries => 'Мои записи';

  @override
  String get subscriptions => 'Подписки';

  @override
  String get live => 'Прямой эфир';

  @override
  String get best => 'Лучшее';

  @override
  String get tlogs => 'Тлоги';

  @override
  String get themes => 'Темы';

  @override
  String get settings => 'Настройки';

  @override
  String get help => 'Помощь';

  @override
  String get news => 'Новости';

  @override
  String get rules => 'Правила';

  @override
  String get about => 'О приложении';

  @override
  String get login => 'Войти';

  @override
  String get register => 'Регистрация';

  @override
  String get logout => 'Выйти';

  @override
  String get error => 'Ошибка';

  @override
  String get goHome => 'На главную';

  @override
  String get somethingWentWrong => 'Что-то пошло не так';

  @override
  String get unknownError => 'Произошла неизвестная ошибка';

  @override
  String get feed => 'Лента';

  @override
  String get email => 'Email';

  @override
  String get emailOrUsername => 'Email или имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get emailHint => 'Введите ваш email';

  @override
  String get emailOrUsernameHint => 'Введите ваш email или имя пользователя';

  @override
  String get passwordHint => 'Введите ваш пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get emailRequired => 'Email обязателен';

  @override
  String get emailOrUsernameRequired =>
      'Email или имя пользователя обязательно';

  @override
  String get emailInvalid => 'Введите корректный email адрес';

  @override
  String get passwordRequired => 'Пароль обязателен';

  @override
  String get passwordTooShort => 'Пароль должен содержать минимум 6 символов';

  @override
  String get username => 'Имя пользователя';

  @override
  String get usernameHint => 'Введите ваше имя пользователя';

  @override
  String get usernameRequired => 'Имя пользователя обязательно';

  @override
  String get usernameTooShort =>
      'Имя пользователя должно содержать минимум 3 символа';

  @override
  String get usernameInvalid =>
      'Имя пользователя может содержать только буквы, цифры и подчеркивания';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get confirmPasswordHint => 'Подтвердите ваш пароль';

  @override
  String get confirmPasswordRequired => 'Пожалуйста, подтвердите ваш пароль';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get passwordStrength => 'Надежность пароля';

  @override
  String get passwordStrengthWeak => 'Слабый';

  @override
  String get passwordStrengthMedium => 'Средний';

  @override
  String get passwordStrengthStrong => 'Сильный';

  @override
  String get termsOfService => 'Условиями использования';

  @override
  String get privacyPolicy => 'Политикой конфиденциальности';

  @override
  String agreeToTerms(String termsOfService, String privacyPolicy) {
    return 'Регистрируясь, вы соглашаетесь с нашими $termsOfService и $privacyPolicy';
  }

  @override
  String get gender => 'Пол';

  @override
  String get genderHint => 'Выберите ваш пол';

  @override
  String get genderNotSet => 'Не указан';

  @override
  String get genderMale => 'Мужской';

  @override
  String get genderFemale => 'Женский';
}
