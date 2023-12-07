abstract class DashboardConstants {
  DashboardConstants._();

  static const String home = 'Home';
  static const String dairy = 'Dairy';
  static const String services = 'Services';
  static const String track = 'Track';
  static const String articles = 'Articles';

  static const Map<String, int> pageAddress = <String, int>{
    home: 0,
    dairy: 1,
    services: 2,
    track: 3,
    articles: 4,
  };
}
