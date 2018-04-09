class Post {
  final int imageUrl;
  final String title;
  final String categoryColor;
  final String category;
  final String timeToRead;

  Post(
      {this.imageUrl, this.title, this.categoryColor, this.category, this.timeToRead});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
        imageUrl: json['image_url'],
        title: json['title'],
        categoryColor: json['category_color'],
        category: json['category'],
        timeToRead: json['time_to_read']
    );
  }
}
