abstract class ChatbotEvent {}

class SendMessage extends ChatbotEvent {
  final String message;

  SendMessage(this.message);
}