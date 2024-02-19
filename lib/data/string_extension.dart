extension StringExtension on String {
  String capitalize() {

    if (this != null && this.isNotEmpty) {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
    return this;
  }
}