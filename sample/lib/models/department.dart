class Department {
  static const CSE = const Department._(0);

  static get values => [CSE];

  final int value;
  String get title => titles[value];

  const Department._(this.value);

  @override
  String toString() {
    return title;
  }
}

// TODO: Need localization for this.
const titles = ["Computer Science Engineering"];

