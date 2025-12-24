import '../network/firebase/dtos/chat_message.dart';

class MockData {
  static List<ChatMessage> getConversation() {
    return [
      ChatMessage(
        id: "1735029600000",
        speaker: "user",
        content: "Hey! I'm looking for some advice on starting my freelance journey. Can you help?",
        timestamp: 1735029600000,
      ),
      ChatMessage(
        id: "1735029605000",
        speaker: "model",
        content: "Of course, Zaw! Since you're a skilled mobile dev (Flutter, Kotlin, iOS), you have a great foundation. What's the first thing on your mind?",
        timestamp: 1735029605000,
      ),
      ChatMessage(
        id: "1735029610000",
        speaker: "user",
        content: "I need to write a proposal for a high-quality Flutter project I found. What should I include?",
        timestamp: 1735029610000,
      ),
      ChatMessage(
        id: "1735029615000",
        speaker: "model",
        content: "Great! Start with a strong hook: mention their specific problem. Then, highlight your expertise in Flutter and Cross-platform. Would you like me to draft a template based on your skills?",
        timestamp: 1735029615000,
      ),
      ChatMessage(
        id: "1735029620000",
        speaker: "user",
        content: "Yes, please. Also, since I'm in Yangon, should I mention my timezone in the proposal?",
        timestamp: 1735029620000,
      ),
      ChatMessage(
        id: "1735029625000",
        speaker: "model",
        content: "Yes, transparency is key. You can frame it as a benefit: 'I can provide overnight updates so work is ready by your morning.'",
        timestamp: 1735029625000,
      ),
      ChatMessage(
        id: "1735029630000",
        speaker: "user",
        content: "That's a smart way to put it. What about pricing? I have an anti-goal of not taking projects under \$2k.",
        timestamp: 1735029630000,
      ),
      ChatMessage(
        id: "1735029635000",
        speaker: "model",
        content: "Exactly. Stick to your boundaries. If the project seems too small, we can draft a message politely declining or explaining your minimum value for high-quality work.",
        timestamp: 1735029635000,
      ),
      ChatMessage(
        id: "1735029640000",
        speaker: "user",
        content: "Thanks! I'm also learning more about RAG architectures right now. Should I mention that too?",
        timestamp: 1735029640000,
      ),
      ChatMessage(
        id: "1735029645000",
        speaker: "model",
        content: "Definitely! AI integration is a hot request. Mentioning you can build RAG-based features with FastAPI and Flutter makes you stand out significantly.",
        timestamp: 1735029645000,
      ),
    ];
  }
}