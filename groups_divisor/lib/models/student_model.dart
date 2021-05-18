class Student {
  String name;
  String id;

  Student({this.id, this.name});

  @override
  String toString() {
    return '$id - $name';
  }
}
