class NumberFormatCustom {
  NumberFormatCustom();

  static String getCustomFormatNumber(int number) {
    String str = number.toString();
    final List<String> strings = str.split('');
    String result = '';
    int index = 1;
    for (int i = strings.length - 1; i >= 0; i--) {
      result += strings[i];
      if (index % 3 == 0 && index != 0 && index != (strings.length)) {
        result += ',';
      }
      index++;
    }
    return revertString(result);
  }

  static String revertString(String oldString) {
    String newString = '';
    for (int i = oldString.length - 1; i >= 0; i--) {
      newString += oldString[i];
    }
    return newString;
  }
}