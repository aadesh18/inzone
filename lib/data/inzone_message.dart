class InZoneMessage {
  final String message;
  final bool isMe;
  final DateTime timeSent;
  final String senderID;
  InZoneMessage(
      {required this.message,
      required this.isMe,
      required this.timeSent,
      required this.senderID});
}
