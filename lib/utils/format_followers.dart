String formatFollowers(List<String> names, int totalCount) {
  if (names.isEmpty) return 'No followers yet';

  final moreCount = totalCount - names.length;

  if (names.length == 1) {
    return 'Followed by ${names[0]}';
  } else if (names.length == 2) {
    return 'Followed by ${names[0]} and ${names[1]}';
  } else if (moreCount > 0) {
    return 'Followed by ${names[0]}, ${names[1]}, ${names[2]} +$moreCount more';
  }
  return 'Followed by ${names[0]}, ${names[1]}, and ${names[2]}';
}
