List<String> sportsName = [
  'Tennis',
  'Badminton',
  'Pickle Ball',
  'Padel Tennis',
  'Table Tennis',
  'Golf',
  'Swimming',
  'Squash'
];

List<String> icons = [
  'assets/icons/badminton.png',
  'assets/icons/breaking.png',
  'assets/icons/golf.png',
  'assets/icons/swimming.png',
  'assets/icons/table-tennis.png',
  'assets/icons/tennis.png',
  'assets/icons/weightlifting.png',
];

class CategoryModel {
  final String sport;
  final String iconData;

  CategoryModel({required this.sport, required this.iconData});
}

List<CategoryModel> categories = [
  CategoryModel(sport: 'Tennis', iconData: icons[5]),
  CategoryModel(sport: 'Golf', iconData: icons[2]),
  CategoryModel(sport: 'Swimming', iconData: icons[3]),
  CategoryModel(sport: 'Table Tennis', iconData: icons[4]),
  CategoryModel(sport: 'Badminton', iconData: icons[0]),
  CategoryModel(sport: 'Pickle Ball', iconData: icons[1]),
  CategoryModel(sport: 'Physique', iconData: icons[6]),
  CategoryModel(sport: 'Paddle Tennis', iconData: icons[1]),
];
