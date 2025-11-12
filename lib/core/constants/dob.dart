class DOBItems {
  static final List<int> dates = List.generate(31, (index) => index + 1);
  static final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  static final List<int> years =
      List.generate(100, (index) => DateTime.now().year - index);
}
