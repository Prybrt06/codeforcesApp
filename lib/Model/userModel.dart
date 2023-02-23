class UserModel {
  final int lastOnlineTimeSeconds;
  final int rating;
  final String handle;
  final String rank;
  final int maxRating;
  final String maxRank;
  final String avatar;

  UserModel({
    required this.lastOnlineTimeSeconds,
    required this.rating,
    required this.handle,
    required this.maxRank,
    required this.maxRating,
    required this.rank,
    required this.avatar
  });
}
