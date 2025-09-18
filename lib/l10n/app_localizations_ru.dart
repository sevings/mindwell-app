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
  String get invited => 'Приглашенные';

  @override
  String get waiting => 'Ожидающие';

  @override
  String get rank => 'Рейтинг';

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
  String get invites => 'Приглашения';

  @override
  String get availableInvites => 'Доступные приглашения';

  @override
  String get invitesDescription =>
      'Вы можете дать приглашение другому пользователю на странице его профиля, предоставив ему полные права.';

  @override
  String get howItWorks => 'Как это работает';

  @override
  String get tip => 'Совет';

  @override
  String get inviteTip =>
      'Посетите страницу профиля любого пользователя, чтобы отправить ему приглашение. Он получит полный доступ к платформе.';

  @override
  String get noInvitesAvailable => 'Нет доступных приглашений';

  @override
  String get noInvitesDescription =>
      'У вас нет приглашений для отправки в данный момент.';

  @override
  String get retry => 'Повторить';

  @override
  String get loading => 'Загрузка...';

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

  @override
  String get discussed => 'Обсуждаемое';

  @override
  String get week => 'Неделя';

  @override
  String get month => 'Месяц';

  @override
  String get year => 'Год';

  @override
  String get friends => 'Друзья';

  @override
  String get watching => 'Отслеживаемые';

  @override
  String get entries => 'записей';

  @override
  String get replies => 'Ответы';

  @override
  String get displayFormat => 'Формат отображения';

  @override
  String get sortOrder => 'Порядок сортировки';

  @override
  String get filterOptions => 'Параметры фильтрации';

  @override
  String get autoRefresh => 'Автообновление';

  @override
  String get short => 'Краткий';

  @override
  String get full => 'Полный';

  @override
  String get newestFirst => 'Сначала новые';

  @override
  String get oldestFirst => 'Сначала старые';

  @override
  String get bestFirst => 'Сначала лучшие';

  @override
  String get imagesOnly => 'Только с изображениями';

  @override
  String get imagesOnlySubtitle => 'Показывать только записи с изображениями';

  @override
  String get favoritesOnly => 'Только избранное';

  @override
  String get favoritesOnlySubtitle => 'Показывать только избранные записи';

  @override
  String get followedOnly => 'Только подписки';

  @override
  String get followedOnlySubtitle =>
      'Показывать только записи от отслеживаемых пользователей';

  @override
  String get enableAutoRefresh => 'Включить автообновление';

  @override
  String get enableAutoRefreshSubtitle => 'Автоматически обновлять ленту';

  @override
  String get refreshInterval => 'Интервал обновления';

  @override
  String get refresh => 'Обновить';

  @override
  String get refreshing => 'Обновление';

  @override
  String get seconds => 'секунд';

  @override
  String get minute => 'минута';

  @override
  String get minutes => 'минут';

  @override
  String get applySettings => 'Применить настройки';

  @override
  String get sourceOptions => 'Источники';

  @override
  String get includeTlogs => 'Включить дневники';

  @override
  String get includeTlogsSubtitle =>
      'Показывать записи из дневников пользователей';

  @override
  String get includeThemes => 'Включить темы';

  @override
  String get includeThemesSubtitle => 'Показывать записи из тем';

  @override
  String get entryCount => 'Количество записей';

  @override
  String get entryCountSubtitle =>
      'Количество записей для отображения на странице';

  @override
  String get entriesCount10 => '10 записей';

  @override
  String get entriesCount20 => '20 записей';

  @override
  String get entriesCount30 => '30 записей';

  @override
  String get entriesCount50 => '50 записей';

  @override
  String get entriesCount100 => '100 записей';

  @override
  String get entryDetail => 'Детали записи';

  @override
  String get entry => 'Запись';

  @override
  String get comments => 'Комментарии';

  @override
  String get loadMoreComments => 'Загрузить ещё';

  @override
  String displayComments(int count) {
    return 'Показать $count комментариев';
  }

  @override
  String get displayMoreComments => 'Показать больше комментариев';

  @override
  String get addComment => 'Добавить комментарий';

  @override
  String get commentHint => 'Напишите ваш комментарий...';

  @override
  String get vote => 'Голосовать';

  @override
  String get favorite => 'В избранное';

  @override
  String get upvote => 'Плюс';

  @override
  String get downvote => 'Минус';

  @override
  String get previousEntry => 'Предыдущая запись';

  @override
  String get nextEntry => 'Следующая запись';

  @override
  String get noComments => 'Пока нет комментариев';

  @override
  String get loadingComments => 'Загрузка комментариев...';

  @override
  String get commentPostedSuccessfully => 'Комментарий успешно добавлен!';

  @override
  String get failedToPostComment => 'Не удалось добавить комментарий';

  @override
  String get commentAlreadyExists => 'Этот комментарий уже существует';

  @override
  String get editEntry => 'Редактировать запись';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get publish => 'Опубликовать';

  @override
  String get entryTitle => 'Заголовок записи';

  @override
  String get entryContent => 'Напишите содержание вашей записи здесь...';

  @override
  String get publishing => 'Публикация...';

  @override
  String get goBack => 'Назад';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get images => 'Изображения';

  @override
  String get addImages => 'Добавить изображения';

  @override
  String get invalidTagFormat =>
      'Неверный формат тега. Используйте только буквы, цифры, дефисы и подчеркивания.';

  @override
  String get duplicateTag => 'Этот тег уже существует.';

  @override
  String get tagLimitReached => 'Достигнуто максимальное количество тегов.';

  @override
  String get tags => 'Теги';

  @override
  String get addTag => 'Добавить тег';

  @override
  String get used => 'использован';

  @override
  String get time => 'раз';

  @override
  String get times => 'раз';

  @override
  String get draftSaved => 'Черновик сохранен';

  @override
  String get entryPublished => 'Запись успешно опубликована!';

  @override
  String get uploadingImages => 'Загрузка изображений...';

  @override
  String get pleaseWait => 'Пожалуйста, подождите...';

  @override
  String get redirecting => 'Перенаправление...';

  @override
  String get pin => 'Закрепить';

  @override
  String get unpin => 'Открепить';

  @override
  String get follow => 'Отслеживать';

  @override
  String get unfollow => 'Не отслеживать';

  @override
  String get edit => 'Редактировать';

  @override
  String get delete => 'Удалить';

  @override
  String get complain => 'Пожаловаться';

  @override
  String get share => 'Поделиться';

  @override
  String get copyLink => 'Копировать ссылку';

  @override
  String get entryActions => 'Действия с записью';

  @override
  String get commentActions => 'Действия с комментарием';

  @override
  String get confirmDelete => 'Вы уверены, что хотите удалить эту запись?';

  @override
  String get confirmDeleteComment =>
      'Вы уверены, что хотите удалить этот комментарий?';

  @override
  String get entryDeleted => 'Запись успешно удалена';

  @override
  String get commentDeleted => 'Комментарий успешно удален';

  @override
  String get entryPinned => 'Запись закреплена';

  @override
  String get entryUnpinned => 'Запись откреплена';

  @override
  String get entryFollowed => 'Теперь отслеживаете эту запись';

  @override
  String get entryUnfollowed => 'Больше не отслеживаете эту запись';

  @override
  String get linkCopied => 'Ссылка скопирована в буфер обмена';

  @override
  String get complaintSubmitted => 'Жалоба успешно отправлена';

  @override
  String get untitled => 'Без названия';

  @override
  String get entrySettings => 'Настройки записи';

  @override
  String get privacyLevel => 'Уровень приватности';

  @override
  String get privacyAll => 'Публично';

  @override
  String get privacyFriends => 'Только друзья';

  @override
  String get privacyPrivate => 'Приватно';

  @override
  String get privacyRegistered => 'Зарегистрированные пользователи';

  @override
  String get privacyInvited => 'Приглашенные пользователи';

  @override
  String get privacyFollowers => 'Подписчики';

  @override
  String get privacyMe => 'Только я';

  @override
  String get allowComments => 'Разрешить комментарии';

  @override
  String get allowCommentsSubtitle =>
      'Позволить другим комментировать эту запись';

  @override
  String get allowVotes => 'Разрешить голосование';

  @override
  String get allowVotesSubtitle => 'Позволить другим голосовать за эту запись';

  @override
  String get postInLive => 'Опубликовать в прямой эфир';

  @override
  String get postInLiveSubtitle => 'Показать эту запись в прямом эфире';

  @override
  String get allowSharing => 'Разрешить поделиться';

  @override
  String get allowSharingSubtitle => 'Позволить другим поделиться этой записью';

  @override
  String get postAnonymously => 'Опубликовать анонимно';

  @override
  String get postAnonymouslySubtitle =>
      'Скрыть вашу личность при публикации в темах';

  @override
  String get previewCreated => 'Предварительный просмотр создан успешно!';

  @override
  String get redirectingToPreview =>
      'Перенаправление к предварительному просмотру...';

  @override
  String get previewMode =>
      'Режим предварительного просмотра - Взаимодействие отключено';

  @override
  String get previewModeCommentsDisabled =>
      'Комментарии отключены в режиме предварительного просмотра. Опубликуйте запись, чтобы включить комментарии.';

  @override
  String get thisIsDraft => 'Это черновик';

  @override
  String get entryNotPublishedYet => 'Эта запись еще не опубликована';

  @override
  String get anonymous => 'Анонимно';

  @override
  String get privacy => 'Приватность';

  @override
  String get voting => 'Голосование';

  @override
  String get liveFeed => 'Живая лента';

  @override
  String get sharing => 'Поделиться';

  @override
  String get enabled => 'Включено';

  @override
  String get disabled => 'Отключено';

  @override
  String get close => 'Закрыть';

  @override
  String get privacySome => 'Некоторые';

  @override
  String commentsByUser(String username) {
    return 'Комментарии от @$username';
  }

  @override
  String get followUser => 'Подписаться';

  @override
  String get unfollowUser => 'Отписаться';

  @override
  String get blockUser => 'Заблокировать';

  @override
  String get unblockUser => 'Разблокировать';

  @override
  String get messageUser => 'Написать';

  @override
  String get online => 'В сети';

  @override
  String get offline => 'Не в сети';

  @override
  String get badges => 'Значки';

  @override
  String get viewAllBadges => 'Показать все значки';

  @override
  String get noBadges => 'Пока нет заработанных значков';

  @override
  String get badgeEarned => 'Заработанный значок';

  @override
  String get lastImages => 'Последние изображения';

  @override
  String get viewAllImages => 'Показать все изображения';

  @override
  String get viewAll => 'Показать все';

  @override
  String get imageGallery => 'Галерея изображений';

  @override
  String get imageNumber => 'Изображение';

  @override
  String get lastEntries => 'Последние записи';

  @override
  String get viewAllEntries => 'Показать все записи';

  @override
  String get noEntries => 'Пока нет записей';

  @override
  String get calendar => 'Календарь';

  @override
  String get monday => 'Понедельник';

  @override
  String get tuesday => 'Вторник';

  @override
  String get wednesday => 'Среда';

  @override
  String get thursday => 'Четверг';

  @override
  String get friday => 'Пятница';

  @override
  String get saturday => 'Суббота';

  @override
  String get sunday => 'Воскресенье';

  @override
  String get january => 'Январь';

  @override
  String get february => 'Февраль';

  @override
  String get march => 'Март';

  @override
  String get april => 'Апрель';

  @override
  String get may => 'Май';

  @override
  String get june => 'Июнь';

  @override
  String get july => 'Июль';

  @override
  String get august => 'Август';

  @override
  String get september => 'Сентябрь';

  @override
  String get october => 'Октябрь';

  @override
  String get november => 'Ноябрь';

  @override
  String get december => 'Декабрь';

  @override
  String get oneEntry => '1 запись';

  @override
  String get untitledEntry => 'Запись без заголовка';

  @override
  String get followers => 'подписчиков';

  @override
  String get following => 'подписок';

  @override
  String get favorited => 'избранных';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get bio => 'О себе';

  @override
  String get showName => 'Отображаемое имя';

  @override
  String get country => 'Страна';

  @override
  String get city => 'Город';

  @override
  String get birthday => 'Дата рождения';

  @override
  String get chatPrivacy => 'Приватность чата';

  @override
  String get showInTops => 'Показывать в топах';

  @override
  String get isDaylog => 'Режим дневника';

  @override
  String get giveInvite => 'Дать приглашение';

  @override
  String get allowFollowRequest => 'Разрешить';

  @override
  String get denyFollowRequest => 'Отклонить';

  @override
  String get hideFromLive => 'Скрыть из ленты';

  @override
  String get unhideFromLive => 'Показать в ленте';

  @override
  String get notifications => 'Уведомления';

  @override
  String get markAllAsRead => 'Отметить все как прочитанные';

  @override
  String get loadingNotifications => 'Загрузка уведомлений...';

  @override
  String get noNotifications => 'Нет уведомлений';

  @override
  String get noNotificationsSubtitle =>
      'Здесь будут отображаться ваши уведомления';

  @override
  String notificationCommentText(String userName) {
    return '$userName прокомментировал вашу запись';
  }

  @override
  String notificationCommentGeneralText(String userName) {
    return '$userName прокомментировал ваш контент';
  }

  @override
  String notificationFollowerText(String userName) {
    return '$userName начал отслеживать вас';
  }

  @override
  String notificationRequestText(String userName) {
    return '$userName отправил запрос на подписку';
  }

  @override
  String notificationAcceptText(String userName) {
    return '$userName принял ваш запрос на подписку';
  }

  @override
  String notificationInviteText(String userName) {
    return '$userName пригласил вас присоединиться';
  }

  @override
  String notificationInvitedText(String userName) {
    return 'Вас пригласил $userName';
  }

  @override
  String get notificationWelcomeText => 'Добро пожаловать в Mindwell!';

  @override
  String notificationBadgeText(String badgeName) {
    return 'Вы заработали новый значок: $badgeName';
  }

  @override
  String get notificationBadgeGeneralText => 'Вы заработали новый значок!';

  @override
  String notificationAdmSentText(String userName) {
    return 'Вы отправили сообщение $userName';
  }

  @override
  String notificationAdmReceivedText(String userName) {
    return 'Вы получили сообщение от $userName';
  }

  @override
  String notificationWishCreatedText(String userName) {
    return '$userName создал желание';
  }

  @override
  String notificationWishReceivedText(String userName) {
    return 'Вы получили желание от $userName';
  }

  @override
  String get notificationEntryMovedText => 'Ваша запись была перемещена';

  @override
  String get notificationInfoText => 'Доступна новая информация';

  @override
  String get notificationDefaultText => 'Новое уведомление';

  @override
  String timeHoursAgo(int hours) {
    return '$hoursч назад';
  }

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutesм назад';
  }

  @override
  String get timeJustNow => 'Только что';

  @override
  String get chats => 'Чаты';

  @override
  String get noConversations => 'Пока нет разговоров';

  @override
  String get noConversationsSubtitle =>
      'Начните разговор с кем-нибудь, чтобы увидеть его здесь';

  @override
  String get loadingChats => 'Загрузка чатов...';

  @override
  String get lastMessage => 'Последнее сообщение';

  @override
  String get unreadMessages => 'Непрочитанные сообщения';

  @override
  String get reportEntryTitle =>
      'Пожаловаться на эту запись за неподходящий контент.';

  @override
  String get reportCommentTitle =>
      'Пожаловаться на этот комментарий за неподходящий контент.';

  @override
  String get failedToDeleteComment =>
      'Не удалось удалить комментарий. Попробуйте еще раз.';

  @override
  String get additionalDetails => 'Дополнительные детали (необязательно)';

  @override
  String get describeIssue => 'Пожалуйста, опишите проблему...';

  @override
  String get submitComplaint => 'Отправить жалобу';

  @override
  String get failedToSubmitComplaint =>
      'Не удалось отправить жалобу. Пожалуйста, попробуйте еще раз.';

  @override
  String get accountSettings => 'Аккаунт';

  @override
  String get changePassword => 'Изменить пароль';

  @override
  String get changeEmail => 'Изменить Email';

  @override
  String get currentPassword => 'Текущий пароль';

  @override
  String get currentPasswordHint => 'Введите ваш текущий пароль';

  @override
  String get currentPasswordRequired => 'Текущий пароль обязателен';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get newPasswordHint => 'Введите ваш новый пароль';

  @override
  String get newPasswordRequired => 'Новый пароль обязателен';

  @override
  String get newPasswordSameAsCurrent =>
      'Новый пароль должен отличаться от текущего';

  @override
  String get confirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get confirmNewPasswordHint => 'Подтвердите ваш новый пароль';

  @override
  String get confirmNewPasswordRequired =>
      'Пожалуйста, подтвердите ваш новый пароль';

  @override
  String get changePasswordButton => 'Изменить пароль';

  @override
  String get changePasswordSuccess => 'Пароль успешно изменен';

  @override
  String get notificationSettings => 'Уведомления';

  @override
  String get notificationSettingsSubtitle =>
      'Управляйте тем, как вы получаете уведомления';

  @override
  String get emailNotifications => 'Email уведомления';

  @override
  String get emailNotificationsSubtitle => 'Получать уведомления по email';

  @override
  String get telegramNotifications => 'Telegram уведомления';

  @override
  String get telegramNotificationsSubtitle =>
      'Получать уведомления через Telegram';

  @override
  String get onsiteNotifications => 'Уведомления в приложении';

  @override
  String get onsiteNotificationsSubtitle => 'Получать уведомления в приложении';

  @override
  String get privacySettings => 'Конфиденциальность и данные';

  @override
  String get blockedProfiles => 'Заблокированные профили';

  @override
  String get hiddenProfiles => 'Скрытые профили';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountWarning =>
      'Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить, и все ваши данные будут безвозвратно потеряны.';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get loadingSettings => 'Загрузка настроек...';

  @override
  String get emailNotificationSettingsComingSoon =>
      'Настройки email уведомлений скоро будут доступны';

  @override
  String get telegramNotificationSettingsComingSoon =>
      'Настройки Telegram уведомлений скоро будут доступны';

  @override
  String get onsiteNotificationSettingsComingSoon =>
      'Настройки уведомлений в приложении скоро будут доступны';

  @override
  String get privacyPolicyComingSoon =>
      'Политика конфиденциальности скоро будет доступна';

  @override
  String get termsOfServiceComingSoon =>
      'Условия использования скоро будут доступны';

  @override
  String get deleteAccountComingSoon =>
      'Удаление аккаунта скоро будет доступно';

  @override
  String get contactUsComingSoon => 'Связь с нами скоро будет доступна';

  @override
  String get newEmail => 'Новый Email';

  @override
  String get newEmailHint => 'Введите ваш новый email адрес';

  @override
  String get changeEmailButton => 'Изменить Email';

  @override
  String get currentEmail => 'Текущий Email';

  @override
  String get emailVerification => 'Подтверждение Email';

  @override
  String get changeEmailSuccess =>
      'Email успешно изменен. Пожалуйста, проверьте ваш новый email для подтверждения.';

  @override
  String get emailVerified => 'Email подтвержден';

  @override
  String get emailNotVerified => 'Email не подтвержден';

  @override
  String get noEmailSet => 'Email не установлен';

  @override
  String get changeEmailInfo =>
      'После изменения email вам потребуется подтвердить новый email адрес.';

  @override
  String get newEmailRequired => 'Новый email обязателен';

  @override
  String get invalidEmailFormat => 'Пожалуйста, введите корректный email адрес';
}
