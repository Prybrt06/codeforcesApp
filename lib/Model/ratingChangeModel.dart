class RatingChangeModel {
  final String contestName;
  final int rank;
  final int oldRating;
  final int newRating;

  RatingChangeModel({
    required this.contestName,
    required this.rank,
    required this.oldRating,
    required this.newRating,
  });
}
