// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mindwell';

  @override
  String get appSubtitle => 'Your mindful journey starts here';

  @override
  String get home => 'Home';

  @override
  String get newEntry => 'New Entry';

  @override
  String get myEntries => 'My Entries';

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get live => 'Live';

  @override
  String get best => 'Best';

  @override
  String get tlogs => 'Tlogs';

  @override
  String get themes => 'Themes';

  @override
  String get invited => 'Invited';

  @override
  String get waiting => 'Waiting';

  @override
  String get rank => 'Rank';

  @override
  String get settings => 'Settings';

  @override
  String get help => 'Help';

  @override
  String get news => 'News';

  @override
  String get rules => 'Rules';

  @override
  String get about => 'About';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get logout => 'Logout';

  @override
  String get error => 'Error';

  @override
  String get goHome => 'Go Home';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get unknownError => 'Unknown error occurred';

  @override
  String get feed => 'Feed';

  @override
  String get email => 'Email';

  @override
  String get emailOrUsername => 'Email or Username';

  @override
  String get password => 'Password';

  @override
  String get emailHint => 'Enter your email address';

  @override
  String get emailOrUsernameHint => 'Enter your email or username';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get loginButton => 'Login';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailOrUsernameRequired => 'Email or username is required';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get username => 'Username';

  @override
  String get usernameHint => 'Enter your username';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get usernameTooShort => 'Username must be at least 3 characters';

  @override
  String get usernameInvalid =>
      'Username can only contain letters, numbers, and underscores';

  @override
  String get registerButton => 'Register';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Confirm your password';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordStrength => 'Password Strength';

  @override
  String get passwordStrengthWeak => 'Weak';

  @override
  String get passwordStrengthMedium => 'Medium';

  @override
  String get passwordStrengthStrong => 'Strong';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String agreeToTerms(String termsOfService, String privacyPolicy) {
    return 'By registering, you agree to our $termsOfService and $privacyPolicy';
  }

  @override
  String get gender => 'Gender';

  @override
  String get genderHint => 'Select your gender';

  @override
  String get genderNotSet => 'Not set';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get discussed => 'Discussed';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get friends => 'Friends';

  @override
  String get watching => 'Watching';

  @override
  String get entries => 'entries';

  @override
  String get replies => 'Replies';

  @override
  String get displayFormat => 'Display Format';

  @override
  String get sortOrder => 'Sort Order';

  @override
  String get filterOptions => 'Filter Options';

  @override
  String get autoRefresh => 'Auto-refresh';

  @override
  String get short => 'Short';

  @override
  String get full => 'Full';

  @override
  String get newestFirst => 'Newest First';

  @override
  String get oldestFirst => 'Oldest First';

  @override
  String get bestFirst => 'Best First';

  @override
  String get imagesOnly => 'Images Only';

  @override
  String get imagesOnlySubtitle => 'Show only entries with images';

  @override
  String get favoritesOnly => 'Favorites Only';

  @override
  String get favoritesOnlySubtitle => 'Show only favorited entries';

  @override
  String get followedOnly => 'Followed Only';

  @override
  String get followedOnlySubtitle => 'Show only entries from followed users';

  @override
  String get enableAutoRefresh => 'Enable Auto-refresh';

  @override
  String get enableAutoRefreshSubtitle => 'Automatically refresh the feed';

  @override
  String get refreshInterval => 'Refresh Interval';

  @override
  String get refresh => 'Refresh';

  @override
  String get refreshing => 'Refreshing';

  @override
  String get seconds => 'seconds';

  @override
  String get minute => 'minute';

  @override
  String get minutes => 'minutes';

  @override
  String get applySettings => 'Apply Settings';

  @override
  String get sourceOptions => 'Source Options';

  @override
  String get includeTlogs => 'Include Diaries';

  @override
  String get includeTlogsSubtitle => 'Show entries from user diaries';

  @override
  String get includeThemes => 'Include Themes';

  @override
  String get includeThemesSubtitle => 'Show entries from themes';

  @override
  String get entryCount => 'Entry Count';

  @override
  String get entryCountSubtitle => 'Number of entries to display per page';

  @override
  String get entriesCount10 => '10 entries';

  @override
  String get entriesCount20 => '20 entries';

  @override
  String get entriesCount30 => '30 entries';

  @override
  String get entriesCount50 => '50 entries';

  @override
  String get entriesCount100 => '100 entries';

  @override
  String get entryDetail => 'Entry Detail';

  @override
  String get entry => 'Entry';

  @override
  String get comments => 'Comments';

  @override
  String get loadMoreComments => 'Load more';

  @override
  String displayComments(int count) {
    return 'Display $count comments';
  }

  @override
  String get displayMoreComments => 'Display more comments';

  @override
  String get addComment => 'Add comment';

  @override
  String get commentHint => 'Write your comment...';

  @override
  String get vote => 'Vote';

  @override
  String get favorite => 'Favorite';

  @override
  String get upvote => 'Upvote';

  @override
  String get downvote => 'Downvote';

  @override
  String get previousEntry => 'Previous entry';

  @override
  String get nextEntry => 'Next entry';

  @override
  String get noComments => 'No comments yet';

  @override
  String get loadingComments => 'Loading comments...';

  @override
  String get commentPostedSuccessfully => 'Comment posted successfully!';

  @override
  String get failedToPostComment => 'Failed to post comment';

  @override
  String get commentAlreadyExists => 'This comment already exists';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get preview => 'Preview';

  @override
  String get publish => 'Publish';

  @override
  String get entryTitle => 'Entry title';

  @override
  String get entryContent => 'Write your entry content here...';

  @override
  String get publishing => 'Publishing...';

  @override
  String get retry => 'Retry';

  @override
  String get goBack => 'Go Back';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get images => 'Images';

  @override
  String get addImages => 'Add Images';

  @override
  String get invalidTagFormat =>
      'Invalid tag format. Use letters, numbers, hyphens, and underscores only.';

  @override
  String get duplicateTag => 'This tag already exists.';

  @override
  String get tagLimitReached => 'Maximum number of tags reached.';

  @override
  String get tags => 'Tags';

  @override
  String get addTag => 'Add Tag';

  @override
  String get used => 'used';

  @override
  String get time => 'time';

  @override
  String get times => 'times';

  @override
  String get draftSaved => 'Draft saved';

  @override
  String get entryPublished => 'Entry published successfully!';

  @override
  String get uploadingImages => 'Uploading images...';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get redirecting => 'Redirecting...';

  @override
  String get pin => 'Pin';

  @override
  String get unpin => 'Unpin';

  @override
  String get follow => 'Follow';

  @override
  String get unfollow => 'Unfollow';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get complain => 'Complain';

  @override
  String get share => 'Share';

  @override
  String get copyLink => 'Copy Link';

  @override
  String get entryActions => 'Entry Actions';

  @override
  String get commentActions => 'Comment Actions';

  @override
  String get confirmDelete => 'Are you sure you want to delete this entry?';

  @override
  String get confirmDeleteComment =>
      'Are you sure you want to delete this comment?';

  @override
  String get entryDeleted => 'Entry deleted successfully';

  @override
  String get commentDeleted => 'Comment deleted successfully';

  @override
  String get entryPinned => 'Entry pinned';

  @override
  String get entryUnpinned => 'Entry unpinned';

  @override
  String get entryFollowed => 'Now following this entry';

  @override
  String get entryUnfollowed => 'No longer following this entry';

  @override
  String get linkCopied => 'Link copied to clipboard';

  @override
  String get complaintSubmitted => 'Complaint submitted successfully';

  @override
  String get untitled => 'Untitled';

  @override
  String get entrySettings => 'Entry Settings';

  @override
  String get privacyLevel => 'Privacy Level';

  @override
  String get privacyAll => 'Public';

  @override
  String get privacyFriends => 'Friends Only';

  @override
  String get privacyPrivate => 'Private';

  @override
  String get privacyRegistered => 'Registered Users';

  @override
  String get privacyInvited => 'Invited Users';

  @override
  String get privacyFollowers => 'Followers';

  @override
  String get privacyMe => 'Only Me';

  @override
  String get allowComments => 'Allow Comments';

  @override
  String get allowCommentsSubtitle => 'Let others comment on this entry';

  @override
  String get allowVotes => 'Allow Votes';

  @override
  String get allowVotesSubtitle => 'Let others vote on this entry';

  @override
  String get postInLive => 'Post in Live Feed';

  @override
  String get postInLiveSubtitle => 'Show this entry in the live feed';

  @override
  String get allowSharing => 'Allow Sharing';

  @override
  String get allowSharingSubtitle => 'Let others share this entry';

  @override
  String get postAnonymously => 'Post Anonymously';

  @override
  String get postAnonymouslySubtitle =>
      'Hide your identity when posting in themes';

  @override
  String get previewCreated => 'Preview created successfully!';

  @override
  String get redirectingToPreview => 'Redirecting to preview...';

  @override
  String get previewMode => 'Preview Mode - Interactions Disabled';

  @override
  String get previewModeCommentsDisabled =>
      'Comments are disabled in preview mode. Publish the entry to enable comments.';

  @override
  String get thisIsDraft => 'This is a draft';

  @override
  String get entryNotPublishedYet => 'This entry is not published yet';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get privacy => 'Privacy';

  @override
  String get voting => 'Voting';

  @override
  String get liveFeed => 'Live Feed';

  @override
  String get sharing => 'Sharing';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get close => 'Close';

  @override
  String get privacySome => 'Some';

  @override
  String commentsByUser(String username) {
    return 'Comments by @$username';
  }

  @override
  String get followUser => 'Follow';

  @override
  String get unfollowUser => 'Unfollow';

  @override
  String get blockUser => 'Block';

  @override
  String get unblockUser => 'Unblock';

  @override
  String get messageUser => 'Message';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get badges => 'Badges';

  @override
  String get viewAllBadges => 'View All Badges';

  @override
  String get noBadges => 'No badges earned yet';

  @override
  String get badgeEarned => 'Badge earned';

  @override
  String get lastImages => 'Last Images';

  @override
  String get viewAllImages => 'View All Images';

  @override
  String get viewAll => 'View All';

  @override
  String get imageGallery => 'Image Gallery';

  @override
  String get imageNumber => 'Image';

  @override
  String get lastEntries => 'Last Entries';

  @override
  String get viewAllEntries => 'View All Entries';

  @override
  String get noEntries => 'No entries yet';

  @override
  String get calendar => 'Calendar';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get oneEntry => '1 entry';

  @override
  String get untitledEntry => 'Untitled entry';

  @override
  String get followers => 'followers';

  @override
  String get following => 'following';

  @override
  String get favorited => 'favorited';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get bio => 'About';

  @override
  String get showName => 'Display Name';

  @override
  String get country => 'Country';

  @override
  String get city => 'City';

  @override
  String get birthday => 'Birthday';

  @override
  String get chatPrivacy => 'Chat Privacy';

  @override
  String get showInTops => 'Show in Tops';

  @override
  String get isDaylog => 'Daylog Mode';

  @override
  String get giveInvite => 'Give Invite';

  @override
  String get allowFollowRequest => 'Allow';

  @override
  String get denyFollowRequest => 'Deny';

  @override
  String get hideFromLive => 'Hide from Live';

  @override
  String get unhideFromLive => 'Unhide from Live';

  @override
  String get notifications => 'Notifications';

  @override
  String get markAllAsRead => 'Mark all as read';

  @override
  String get loadingNotifications => 'Loading notifications...';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get noNotificationsSubtitle =>
      'You\'ll see notifications here when you receive them';

  @override
  String notificationCommentText(String userName) {
    return '$userName commented on your entry';
  }

  @override
  String notificationCommentGeneralText(String userName) {
    return '$userName commented on your content';
  }

  @override
  String notificationFollowerText(String userName) {
    return '$userName started following you';
  }

  @override
  String notificationRequestText(String userName) {
    return '$userName sent you a follow request';
  }

  @override
  String notificationAcceptText(String userName) {
    return '$userName accepted your follow request';
  }

  @override
  String notificationInviteText(String userName) {
    return '$userName invited you to join';
  }

  @override
  String notificationInvitedText(String userName) {
    return 'You were invited by $userName';
  }

  @override
  String get notificationWelcomeText => 'Welcome to Mindwell!';

  @override
  String notificationBadgeText(String badgeName) {
    return 'You earned a new badge: $badgeName';
  }

  @override
  String get notificationBadgeGeneralText => 'You earned a new badge!';

  @override
  String notificationAdmSentText(String userName) {
    return 'You sent a message to $userName';
  }

  @override
  String notificationAdmReceivedText(String userName) {
    return 'You received a message from $userName';
  }

  @override
  String notificationWishCreatedText(String userName) {
    return '$userName created a wish';
  }

  @override
  String notificationWishReceivedText(String userName) {
    return 'You received a wish from $userName';
  }

  @override
  String get notificationEntryMovedText => 'Your entry was moved';

  @override
  String get notificationInfoText => 'New information available';

  @override
  String get notificationDefaultText => 'New notification';

  @override
  String timeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get timeJustNow => 'Just now';

  @override
  String get chats => 'Chats';

  @override
  String get noConversations => 'No conversations yet';

  @override
  String get noConversationsSubtitle =>
      'Start a conversation with someone to see it here';

  @override
  String get loadingChats => 'Loading chats...';

  @override
  String get lastMessage => 'Last message';

  @override
  String get unreadMessages => 'Unread messages';

  @override
  String get reportEntryTitle => 'Report this entry for inappropriate content.';

  @override
  String get reportCommentTitle =>
      'Report this comment for inappropriate content.';

  @override
  String get failedToDeleteComment =>
      'Failed to delete comment. Please try again.';

  @override
  String get additionalDetails => 'Additional details (optional)';

  @override
  String get describeIssue => 'Please describe the issue...';

  @override
  String get submitComplaint => 'Submit Complaint';

  @override
  String get failedToSubmitComplaint =>
      'Failed to submit complaint. Please try again.';
}
