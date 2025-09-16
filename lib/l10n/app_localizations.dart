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

  /// Multiple entries count
  ///
  /// In ru, this message translates to:
  /// **'записей'**
  String get entries;

  /// Tab label for replies
  ///
  /// In ru, this message translates to:
  /// **'Ответы'**
  String get replies;

  /// Display format section title in feed settings
  ///
  /// In ru, this message translates to:
  /// **'Формат отображения'**
  String get displayFormat;

  /// Sort order section title in feed settings
  ///
  /// In ru, this message translates to:
  /// **'Порядок сортировки'**
  String get sortOrder;

  /// Filter options section title in feed settings
  ///
  /// In ru, this message translates to:
  /// **'Параметры фильтрации'**
  String get filterOptions;

  /// Auto-refresh section title in feed settings
  ///
  /// In ru, this message translates to:
  /// **'Автообновление'**
  String get autoRefresh;

  /// Short display format option
  ///
  /// In ru, this message translates to:
  /// **'Краткий'**
  String get short;

  /// Full display format option
  ///
  /// In ru, this message translates to:
  /// **'Полный'**
  String get full;

  /// Newest first sort order option
  ///
  /// In ru, this message translates to:
  /// **'Сначала новые'**
  String get newestFirst;

  /// Oldest first sort order option
  ///
  /// In ru, this message translates to:
  /// **'Сначала старые'**
  String get oldestFirst;

  /// Best first sort order option
  ///
  /// In ru, this message translates to:
  /// **'Сначала лучшие'**
  String get bestFirst;

  /// Images only filter option
  ///
  /// In ru, this message translates to:
  /// **'Только с изображениями'**
  String get imagesOnly;

  /// Images only filter option subtitle
  ///
  /// In ru, this message translates to:
  /// **'Показывать только записи с изображениями'**
  String get imagesOnlySubtitle;

  /// Favorites only filter option
  ///
  /// In ru, this message translates to:
  /// **'Только избранное'**
  String get favoritesOnly;

  /// Favorites only filter option subtitle
  ///
  /// In ru, this message translates to:
  /// **'Показывать только избранные записи'**
  String get favoritesOnlySubtitle;

  /// Followed only filter option
  ///
  /// In ru, this message translates to:
  /// **'Только подписки'**
  String get followedOnly;

  /// Followed only filter option subtitle
  ///
  /// In ru, this message translates to:
  /// **'Показывать только записи от отслеживаемых пользователей'**
  String get followedOnlySubtitle;

  /// Enable auto-refresh option
  ///
  /// In ru, this message translates to:
  /// **'Включить автообновление'**
  String get enableAutoRefresh;

  /// Enable auto-refresh option subtitle
  ///
  /// In ru, this message translates to:
  /// **'Автоматически обновлять ленту'**
  String get enableAutoRefreshSubtitle;

  /// Refresh interval setting
  ///
  /// In ru, this message translates to:
  /// **'Интервал обновления'**
  String get refreshInterval;

  /// Refresh button text
  ///
  /// In ru, this message translates to:
  /// **'Обновить'**
  String get refresh;

  /// Refreshing status text
  ///
  /// In ru, this message translates to:
  /// **'Обновление'**
  String get refreshing;

  /// Seconds unit for time intervals
  ///
  /// In ru, this message translates to:
  /// **'секунд'**
  String get seconds;

  /// Minute unit for time intervals
  ///
  /// In ru, this message translates to:
  /// **'минута'**
  String get minute;

  /// Minutes unit for time intervals
  ///
  /// In ru, this message translates to:
  /// **'минут'**
  String get minutes;

  /// Apply settings button text
  ///
  /// In ru, this message translates to:
  /// **'Применить настройки'**
  String get applySettings;

  /// Source options section title in feed settings
  ///
  /// In ru, this message translates to:
  /// **'Источники'**
  String get sourceOptions;

  /// Include diaries option
  ///
  /// In ru, this message translates to:
  /// **'Включить дневники'**
  String get includeTlogs;

  /// Include diaries option subtitle
  ///
  /// In ru, this message translates to:
  /// **'Показывать записи из дневников пользователей'**
  String get includeTlogsSubtitle;

  /// Include themes option
  ///
  /// In ru, this message translates to:
  /// **'Включить темы'**
  String get includeThemes;

  /// Include themes option subtitle
  ///
  /// In ru, this message translates to:
  /// **'Показывать записи из тем'**
  String get includeThemesSubtitle;

  /// Title for entry count section in feed settings
  ///
  /// In ru, this message translates to:
  /// **'Количество записей'**
  String get entryCount;

  /// Subtitle for entry count option
  ///
  /// In ru, this message translates to:
  /// **'Количество записей для отображения на странице'**
  String get entryCountSubtitle;

  /// Entry count option for 10 entries
  ///
  /// In ru, this message translates to:
  /// **'10 записей'**
  String get entriesCount10;

  /// Entry count option for 20 entries
  ///
  /// In ru, this message translates to:
  /// **'20 записей'**
  String get entriesCount20;

  /// Entry count option for 30 entries
  ///
  /// In ru, this message translates to:
  /// **'30 записей'**
  String get entriesCount30;

  /// Entry count option for 50 entries
  ///
  /// In ru, this message translates to:
  /// **'50 записей'**
  String get entriesCount50;

  /// Entry count option for 100 entries
  ///
  /// In ru, this message translates to:
  /// **'100 записей'**
  String get entriesCount100;

  /// Entry detail screen title
  ///
  /// In ru, this message translates to:
  /// **'Детали записи'**
  String get entryDetail;

  /// Comments section title
  ///
  /// In ru, this message translates to:
  /// **'Комментарии'**
  String get comments;

  /// Button to load more comments
  ///
  /// In ru, this message translates to:
  /// **'Загрузить ещё'**
  String get loadMoreComments;

  /// Button to display specific number of comments
  ///
  /// In ru, this message translates to:
  /// **'Показать {count} комментариев'**
  String displayComments(int count);

  /// Add comment button text
  ///
  /// In ru, this message translates to:
  /// **'Добавить комментарий'**
  String get addComment;

  /// Comment input field hint
  ///
  /// In ru, this message translates to:
  /// **'Напишите ваш комментарий...'**
  String get commentHint;

  /// Vote button accessibility label
  ///
  /// In ru, this message translates to:
  /// **'Голосовать'**
  String get vote;

  /// Favorite button accessibility label
  ///
  /// In ru, this message translates to:
  /// **'В избранное'**
  String get favorite;

  /// Upvote button accessibility label
  ///
  /// In ru, this message translates to:
  /// **'Плюс'**
  String get upvote;

  /// Downvote button accessibility label
  ///
  /// In ru, this message translates to:
  /// **'Минус'**
  String get downvote;

  /// Previous entry navigation button
  ///
  /// In ru, this message translates to:
  /// **'Предыдущая запись'**
  String get previousEntry;

  /// Next entry navigation button
  ///
  /// In ru, this message translates to:
  /// **'Следующая запись'**
  String get nextEntry;

  /// Message when there are no comments
  ///
  /// In ru, this message translates to:
  /// **'Пока нет комментариев'**
  String get noComments;

  /// Loading comments message
  ///
  /// In ru, this message translates to:
  /// **'Загрузка комментариев...'**
  String get loadingComments;

  /// Success message when a comment is posted
  ///
  /// In ru, this message translates to:
  /// **'Комментарий успешно добавлен!'**
  String get commentPostedSuccessfully;

  /// Error message when posting a comment fails
  ///
  /// In ru, this message translates to:
  /// **'Не удалось добавить комментарий'**
  String get failedToPostComment;

  /// Error message when trying to post a duplicate comment
  ///
  /// In ru, this message translates to:
  /// **'Этот комментарий уже существует'**
  String get commentAlreadyExists;

  /// Edit entry screen title
  ///
  /// In ru, this message translates to:
  /// **'Редактировать запись'**
  String get editEntry;

  /// Preview button text
  ///
  /// In ru, this message translates to:
  /// **'Предпросмотр'**
  String get preview;

  /// Publish button text
  ///
  /// In ru, this message translates to:
  /// **'Опубликовать'**
  String get publish;

  /// Entry title accessibility label
  ///
  /// In ru, this message translates to:
  /// **'Заголовок записи'**
  String get entryTitle;

  /// Entry content field placeholder
  ///
  /// In ru, this message translates to:
  /// **'Напишите содержание вашей записи здесь...'**
  String get entryContent;

  /// Publishing status message
  ///
  /// In ru, this message translates to:
  /// **'Публикация...'**
  String get publishing;

  /// Retry button text
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// Go back button text
  ///
  /// In ru, this message translates to:
  /// **'Назад'**
  String get goBack;

  /// Camera option for image picker
  ///
  /// In ru, this message translates to:
  /// **'Камера'**
  String get camera;

  /// Gallery option for image picker
  ///
  /// In ru, this message translates to:
  /// **'Галерея'**
  String get gallery;

  /// Images section title
  ///
  /// In ru, this message translates to:
  /// **'Изображения'**
  String get images;

  /// Add images button tooltip
  ///
  /// In ru, this message translates to:
  /// **'Добавить изображения'**
  String get addImages;

  /// Error message for invalid tag format
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат тега. Используйте только буквы, цифры, дефисы и подчеркивания.'**
  String get invalidTagFormat;

  /// Error message for duplicate tag
  ///
  /// In ru, this message translates to:
  /// **'Этот тег уже существует.'**
  String get duplicateTag;

  /// Error message when tag limit is reached
  ///
  /// In ru, this message translates to:
  /// **'Достигнуто максимальное количество тегов.'**
  String get tagLimitReached;

  /// Tags section title
  ///
  /// In ru, this message translates to:
  /// **'Теги'**
  String get tags;

  /// Add tag button tooltip
  ///
  /// In ru, this message translates to:
  /// **'Добавить тег'**
  String get addTag;

  /// Word used to indicate tag usage count
  ///
  /// In ru, this message translates to:
  /// **'использован'**
  String get used;

  /// Singular form of time unit
  ///
  /// In ru, this message translates to:
  /// **'раз'**
  String get time;

  /// Plural form of time unit
  ///
  /// In ru, this message translates to:
  /// **'раз'**
  String get times;

  /// Success message when draft is saved
  ///
  /// In ru, this message translates to:
  /// **'Черновик сохранен'**
  String get draftSaved;

  /// Success message when entry is published
  ///
  /// In ru, this message translates to:
  /// **'Запись успешно опубликована!'**
  String get entryPublished;

  /// Status message when uploading images
  ///
  /// In ru, this message translates to:
  /// **'Загрузка изображений...'**
  String get uploadingImages;

  /// Please wait message
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, подождите...'**
  String get pleaseWait;

  /// Redirecting message
  ///
  /// In ru, this message translates to:
  /// **'Перенаправление...'**
  String get redirecting;

  /// Pin entry action
  ///
  /// In ru, this message translates to:
  /// **'Закрепить'**
  String get pin;

  /// Unpin entry action
  ///
  /// In ru, this message translates to:
  /// **'Открепить'**
  String get unpin;

  /// Follow entry action
  ///
  /// In ru, this message translates to:
  /// **'Отслеживать'**
  String get follow;

  /// Unfollow entry action
  ///
  /// In ru, this message translates to:
  /// **'Не отслеживать'**
  String get unfollow;

  /// Edit action
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get edit;

  /// Delete action
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// Complain action
  ///
  /// In ru, this message translates to:
  /// **'Пожаловаться'**
  String get complain;

  /// Share action
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get share;

  /// Copy link action
  ///
  /// In ru, this message translates to:
  /// **'Копировать ссылку'**
  String get copyLink;

  /// Entry actions menu title
  ///
  /// In ru, this message translates to:
  /// **'Действия с записью'**
  String get entryActions;

  /// Comment actions menu title
  ///
  /// In ru, this message translates to:
  /// **'Действия с комментарием'**
  String get commentActions;

  /// Confirmation message for deleting entry
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить эту запись?'**
  String get confirmDelete;

  /// Confirmation message for deleting comment
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить этот комментарий?'**
  String get confirmDeleteComment;

  /// Success message when entry is deleted
  ///
  /// In ru, this message translates to:
  /// **'Запись успешно удалена'**
  String get entryDeleted;

  /// Success message when comment is deleted
  ///
  /// In ru, this message translates to:
  /// **'Комментарий успешно удален'**
  String get commentDeleted;

  /// Success message when entry is pinned
  ///
  /// In ru, this message translates to:
  /// **'Запись закреплена'**
  String get entryPinned;

  /// Success message when entry is unpinned
  ///
  /// In ru, this message translates to:
  /// **'Запись откреплена'**
  String get entryUnpinned;

  /// Success message when entry is followed
  ///
  /// In ru, this message translates to:
  /// **'Теперь отслеживаете эту запись'**
  String get entryFollowed;

  /// Success message when entry is unfollowed
  ///
  /// In ru, this message translates to:
  /// **'Больше не отслеживаете эту запись'**
  String get entryUnfollowed;

  /// Success message when link is copied
  ///
  /// In ru, this message translates to:
  /// **'Ссылка скопирована в буфер обмена'**
  String get linkCopied;

  /// Success message when complaint is submitted
  ///
  /// In ru, this message translates to:
  /// **'Жалоба успешно отправлена'**
  String get complaintSubmitted;

  /// Default title for entries without a title
  ///
  /// In ru, this message translates to:
  /// **'Без названия'**
  String get untitled;

  /// Entry settings bottom sheet title
  ///
  /// In ru, this message translates to:
  /// **'Настройки записи'**
  String get entrySettings;

  /// Privacy level setting title
  ///
  /// In ru, this message translates to:
  /// **'Уровень приватности'**
  String get privacyLevel;

  /// Public privacy level option
  ///
  /// In ru, this message translates to:
  /// **'Публично'**
  String get privacyAll;

  /// Friends only privacy level option
  ///
  /// In ru, this message translates to:
  /// **'Только друзья'**
  String get privacyFriends;

  /// Private privacy level option
  ///
  /// In ru, this message translates to:
  /// **'Приватно'**
  String get privacyPrivate;

  /// Registered users privacy level option
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрированные пользователи'**
  String get privacyRegistered;

  /// Invited users privacy level option
  ///
  /// In ru, this message translates to:
  /// **'Приглашенные пользователи'**
  String get privacyInvited;

  /// Followers privacy level option
  ///
  /// In ru, this message translates to:
  /// **'Подписчики'**
  String get privacyFollowers;

  /// Only me privacy level option
  ///
  /// In ru, this message translates to:
  /// **'Только я'**
  String get privacyMe;

  /// Allow comments setting title
  ///
  /// In ru, this message translates to:
  /// **'Разрешить комментарии'**
  String get allowComments;

  /// Allow comments setting subtitle
  ///
  /// In ru, this message translates to:
  /// **'Позволить другим комментировать эту запись'**
  String get allowCommentsSubtitle;

  /// Allow votes setting title
  ///
  /// In ru, this message translates to:
  /// **'Разрешить голосование'**
  String get allowVotes;

  /// Allow votes setting subtitle
  ///
  /// In ru, this message translates to:
  /// **'Позволить другим голосовать за эту запись'**
  String get allowVotesSubtitle;

  /// Post in live feed setting title
  ///
  /// In ru, this message translates to:
  /// **'Опубликовать в прямой эфир'**
  String get postInLive;

  /// Post in live feed setting subtitle
  ///
  /// In ru, this message translates to:
  /// **'Показать эту запись в прямом эфире'**
  String get postInLiveSubtitle;

  /// Allow sharing setting title
  ///
  /// In ru, this message translates to:
  /// **'Разрешить поделиться'**
  String get allowSharing;

  /// Allow sharing setting subtitle
  ///
  /// In ru, this message translates to:
  /// **'Позволить другим поделиться этой записью'**
  String get allowSharingSubtitle;

  /// Post anonymously setting title
  ///
  /// In ru, this message translates to:
  /// **'Опубликовать анонимно'**
  String get postAnonymously;

  /// Post anonymously setting subtitle
  ///
  /// In ru, this message translates to:
  /// **'Скрыть вашу личность при публикации в темах'**
  String get postAnonymouslySubtitle;

  /// Success message when preview is created
  ///
  /// In ru, this message translates to:
  /// **'Предварительный просмотр создан успешно!'**
  String get previewCreated;

  /// Redirecting to preview message
  ///
  /// In ru, this message translates to:
  /// **'Перенаправление к предварительному просмотру...'**
  String get redirectingToPreview;

  /// Preview mode indicator text
  ///
  /// In ru, this message translates to:
  /// **'Режим предварительного просмотра - Взаимодействие отключено'**
  String get previewMode;

  /// Preview mode comments disabled message
  ///
  /// In ru, this message translates to:
  /// **'Комментарии отключены в режиме предварительного просмотра. Опубликуйте запись, чтобы включить комментарии.'**
  String get previewModeCommentsDisabled;

  /// No description provided for @thisIsDraft.
  ///
  /// In ru, this message translates to:
  /// **'Это черновик'**
  String get thisIsDraft;

  /// No description provided for @entryNotPublishedYet.
  ///
  /// In ru, this message translates to:
  /// **'Эта запись еще не опубликована'**
  String get entryNotPublishedYet;

  /// No description provided for @anonymous.
  ///
  /// In ru, this message translates to:
  /// **'Анонимно'**
  String get anonymous;

  /// Privacy setting label
  ///
  /// In ru, this message translates to:
  /// **'Приватность'**
  String get privacy;

  /// No description provided for @voting.
  ///
  /// In ru, this message translates to:
  /// **'Голосование'**
  String get voting;

  /// No description provided for @liveFeed.
  ///
  /// In ru, this message translates to:
  /// **'Живая лента'**
  String get liveFeed;

  /// No description provided for @sharing.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get sharing;

  /// No description provided for @enabled.
  ///
  /// In ru, this message translates to:
  /// **'Включено'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In ru, this message translates to:
  /// **'Отключено'**
  String get disabled;

  /// No description provided for @close.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get close;

  /// No description provided for @privacySome.
  ///
  /// In ru, this message translates to:
  /// **'Некоторые'**
  String get privacySome;

  /// Title for comment feed screen showing comments by a specific user
  ///
  /// In ru, this message translates to:
  /// **'Комментарии от @{username}'**
  String commentsByUser(String username);

  /// Follow user button text
  ///
  /// In ru, this message translates to:
  /// **'Подписаться'**
  String get followUser;

  /// Unfollow user button text
  ///
  /// In ru, this message translates to:
  /// **'Отписаться'**
  String get unfollowUser;

  /// Block user button text
  ///
  /// In ru, this message translates to:
  /// **'Заблокировать'**
  String get blockUser;

  /// Unblock user button text
  ///
  /// In ru, this message translates to:
  /// **'Разблокировать'**
  String get unblockUser;

  /// Message user button text
  ///
  /// In ru, this message translates to:
  /// **'Написать'**
  String get messageUser;

  /// Online status text
  ///
  /// In ru, this message translates to:
  /// **'В сети'**
  String get online;

  /// Offline status text
  ///
  /// In ru, this message translates to:
  /// **'Не в сети'**
  String get offline;

  /// Badges section title
  ///
  /// In ru, this message translates to:
  /// **'Значки'**
  String get badges;

  /// Button to view all badges
  ///
  /// In ru, this message translates to:
  /// **'Показать все значки'**
  String get viewAllBadges;

  /// Message when user has no badges
  ///
  /// In ru, this message translates to:
  /// **'Пока нет заработанных значков'**
  String get noBadges;

  /// Accessibility label for earned badge
  ///
  /// In ru, this message translates to:
  /// **'Заработанный значок'**
  String get badgeEarned;

  /// Last images section title
  ///
  /// In ru, this message translates to:
  /// **'Последние изображения'**
  String get lastImages;

  /// Button to view all images
  ///
  /// In ru, this message translates to:
  /// **'Показать все изображения'**
  String get viewAllImages;

  /// View all button text
  ///
  /// In ru, this message translates to:
  /// **'Показать все'**
  String get viewAll;

  /// Image gallery screen title
  ///
  /// In ru, this message translates to:
  /// **'Галерея изображений'**
  String get imageGallery;

  /// Image number accessibility label
  ///
  /// In ru, this message translates to:
  /// **'Изображение'**
  String get imageNumber;

  /// Last entries section title
  ///
  /// In ru, this message translates to:
  /// **'Последние записи'**
  String get lastEntries;

  /// Button to view all entries
  ///
  /// In ru, this message translates to:
  /// **'Показать все записи'**
  String get viewAllEntries;

  /// Message when user has no entries
  ///
  /// In ru, this message translates to:
  /// **'Пока нет записей'**
  String get noEntries;

  /// Calendar section title
  ///
  /// In ru, this message translates to:
  /// **'Календарь'**
  String get calendar;

  /// Monday day name
  ///
  /// In ru, this message translates to:
  /// **'Понедельник'**
  String get monday;

  /// Tuesday day name
  ///
  /// In ru, this message translates to:
  /// **'Вторник'**
  String get tuesday;

  /// Wednesday day name
  ///
  /// In ru, this message translates to:
  /// **'Среда'**
  String get wednesday;

  /// Thursday day name
  ///
  /// In ru, this message translates to:
  /// **'Четверг'**
  String get thursday;

  /// Friday day name
  ///
  /// In ru, this message translates to:
  /// **'Пятница'**
  String get friday;

  /// Saturday day name
  ///
  /// In ru, this message translates to:
  /// **'Суббота'**
  String get saturday;

  /// Sunday day name
  ///
  /// In ru, this message translates to:
  /// **'Воскресенье'**
  String get sunday;

  /// January month name
  ///
  /// In ru, this message translates to:
  /// **'Январь'**
  String get january;

  /// February month name
  ///
  /// In ru, this message translates to:
  /// **'Февраль'**
  String get february;

  /// March month name
  ///
  /// In ru, this message translates to:
  /// **'Март'**
  String get march;

  /// April month name
  ///
  /// In ru, this message translates to:
  /// **'Апрель'**
  String get april;

  /// May month name
  ///
  /// In ru, this message translates to:
  /// **'Май'**
  String get may;

  /// June month name
  ///
  /// In ru, this message translates to:
  /// **'Июнь'**
  String get june;

  /// July month name
  ///
  /// In ru, this message translates to:
  /// **'Июль'**
  String get july;

  /// August month name
  ///
  /// In ru, this message translates to:
  /// **'Август'**
  String get august;

  /// September month name
  ///
  /// In ru, this message translates to:
  /// **'Сентябрь'**
  String get september;

  /// October month name
  ///
  /// In ru, this message translates to:
  /// **'Октябрь'**
  String get october;

  /// November month name
  ///
  /// In ru, this message translates to:
  /// **'Ноябрь'**
  String get november;

  /// December month name
  ///
  /// In ru, this message translates to:
  /// **'Декабрь'**
  String get december;

  /// Single entry count
  ///
  /// In ru, this message translates to:
  /// **'1 запись'**
  String get oneEntry;

  /// Default title for entries without title
  ///
  /// In ru, this message translates to:
  /// **'Запись без заголовка'**
  String get untitledEntry;

  /// Followers count label
  ///
  /// In ru, this message translates to:
  /// **'подписчиков'**
  String get followers;

  /// Following count label
  ///
  /// In ru, this message translates to:
  /// **'подписок'**
  String get following;

  /// Favorited count label
  ///
  /// In ru, this message translates to:
  /// **'избранных'**
  String get favorited;

  /// Edit profile button text
  ///
  /// In ru, this message translates to:
  /// **'Редактировать профиль'**
  String get editProfile;

  /// Save button text
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// Cancel button text
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// Bio field label
  ///
  /// In ru, this message translates to:
  /// **'О себе'**
  String get bio;

  /// Display name field label
  ///
  /// In ru, this message translates to:
  /// **'Отображаемое имя'**
  String get showName;

  /// Country field label
  ///
  /// In ru, this message translates to:
  /// **'Страна'**
  String get country;

  /// City field label
  ///
  /// In ru, this message translates to:
  /// **'Город'**
  String get city;

  /// Birthday field label
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthday;

  /// Chat privacy setting label
  ///
  /// In ru, this message translates to:
  /// **'Приватность чата'**
  String get chatPrivacy;

  /// Show in tops setting label
  ///
  /// In ru, this message translates to:
  /// **'Показывать в топах'**
  String get showInTops;

  /// Daylog mode setting label
  ///
  /// In ru, this message translates to:
  /// **'Режим дневника'**
  String get isDaylog;

  /// Give invite button text
  ///
  /// In ru, this message translates to:
  /// **'Дать приглашение'**
  String get giveInvite;

  /// Allow follow request button text
  ///
  /// In ru, this message translates to:
  /// **'Разрешить'**
  String get allowFollowRequest;

  /// Deny follow request button text
  ///
  /// In ru, this message translates to:
  /// **'Отклонить'**
  String get denyFollowRequest;

  /// Hide from live action text
  ///
  /// In ru, this message translates to:
  /// **'Скрыть из ленты'**
  String get hideFromLive;

  /// Unhide from live action text
  ///
  /// In ru, this message translates to:
  /// **'Показать в ленте'**
  String get unhideFromLive;
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
