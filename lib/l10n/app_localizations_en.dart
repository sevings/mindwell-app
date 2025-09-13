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
}
