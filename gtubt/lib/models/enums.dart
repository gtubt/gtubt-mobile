enum Department { cse, eee }

extension DepExt on Department {
  String getString() {
    switch (this) {
      case Department.cse:
        return "Bilgisayar Muhendisligi";
      case Department.eee:
        return "Elektronik Muhendisligi";
    }

    return this.toString();
  }
}
