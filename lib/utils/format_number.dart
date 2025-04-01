String formatNumber(int number) {
  if (number < 1000) {
    print(number);
    return number.toString();
  } else if (number < 1000000) {
    return '${(number / 1000).toStringAsFixed(1).replaceAll('.0', '')}K';
  } else {
    return '${(number / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M';
  }
}
