String formatFollowers(List<String> followers) {
  if (followers.isEmpty) return "";

  String result = "Followed by ";
  int count = followers.length;

  for (int i = 0; i < (count < 3 ? count : 3); i++) {
    result += followers[i];
    if (i == count - 1) {
      break;
    } else if (i == 1 && count > 3) {
      result += ", ";
    } else if (i == 2 || (i == 1 && count == 3)) {
      result += " and ";
    } else {
      result += ", ";
    }
  }

  if (count > 3) {
    result += "${count - 3} others";
  }

  return result;
}
