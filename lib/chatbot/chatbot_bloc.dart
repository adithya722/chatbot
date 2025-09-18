import 'package:flutter_bloc/flutter_bloc.dart';
import 'chatbot_event.dart';
import 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc() : super(ChatbotState(messages: [])) {
    on<SendMessage>((event, emit) {
      final updatedMessages = List<Message>.from(state.messages)
        ..add(Message(text: event.message, isUser: true))
        ..add(Message(text: _getBotResponse(event.message), isUser: false));
      emit(ChatbotState(messages: updatedMessages));
    });
  }

  String _getBotResponse(String userMessage) {
    return 'Hello! You said: $userMessage. How can I assist you further?';
  }
}