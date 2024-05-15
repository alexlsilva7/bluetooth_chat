class Message {
  final String id;
  final String author;
  final String message;
  final DateTime createdAt;
  final bool isMe;

  Message({
    required this.id,
    required this.author,
    required this.message,
    required this.createdAt,
    required this.isMe,
  });
}
