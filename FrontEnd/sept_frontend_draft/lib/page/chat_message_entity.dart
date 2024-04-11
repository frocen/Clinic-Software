/// chat entity
enum MsgDirection {
  /// right
  send,

  /// left
  receive,
}

class ChatDataEntity {
  String text = '';
  String messageId = '';
  MsgDirection messageType = MsgDirection.send;

  ChatDataEntity(this.messageId, this.text, this.messageType);
}

///  ConversationEntity
class ConversationEntity {
  final String id;
  final String name;
  final String laseMessage;
  final String receiverTime;

  ConversationEntity(
      this.name, this.laseMessage, this.receiverTime,this.id);
}
