class Config {
  static const buildType = String.fromEnvironment('BUILD_TYPE');

  static String get baseUrl {
    switch (buildType) {
      case 'prod':
        return 'https://mindwell.win';
      case 'test':
        return 'https://mindwell.win';
      default:
        return 'http://127.0.0.1:8000';
    }
  }

  static int get clientId {
    switch (buildType) {
      case 'prod':
        return 100500;
      case 'test':
        return 100501;
      default:
        return 100502;
    }
  }

  static String get clientSecret {
    switch (buildType) {
      case 'prod':
        return 'prod_secret';
      case 'test':
        return 'test_secret';
      default:
        return 'dev_secret';
    }
  }
}
