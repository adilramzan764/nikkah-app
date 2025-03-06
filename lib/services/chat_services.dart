import '../model/chat_model.dart';
import 'package:nikkah_app/model/match_model.dart';

class ChatService {
  List<ChatModel> fetchMessages() {
    return [
      ChatModel(
        id: '1',
        date: "8 Aug",
        isOnline: true,
        isYourTurn: true,
        name: "John Andrewson",
        message: "Hey what's up?",
        avatarPath: 'assets/explore-screen-imageOne.png',
      ),
      ChatModel(
        id: '2',
        date: "8 Aug",
        name: "Amelia",
        isOnline: false,
        isYourTurn: true,
        message: "I don't want anything to drink",
        avatarPath: 'assets/explore-screen-imageTwo.png',
      ),
      ChatModel(
        id: '3',
        date: "8 Aug",
        isOnline: true,
        isYourTurn: true,
        name: "John Andrewson",
        message: "Hey what's up?",
        avatarPath: 'assets/explore-screen-imageThree.png',
      ),
      ChatModel(
        id: '4',
        date: "8 Aug",
        name: "Amelia",
        isOnline: false,
        isYourTurn: true,
        message: "I don't want anything to drink",
        avatarPath: 'assets/explore-screen-imageFour.png',
      ),
      ChatModel(
        id: '5',
        date: "8 Aug",
        isOnline: true,
        isYourTurn: true,
        name: "John Andrewson",
        message: "Hey what's up?",
        avatarPath: 'assets/explore-screen-imageFive.png',
      ),
      ChatModel(
        id: '5',
        date: "8 Aug",
        name: "Amelia",
        isOnline: false,
        isYourTurn: true,
        message: "I don't want anything to drink",
        avatarPath: 'assets/explore-screen-imageSix.png',
      ),
    ];
  }

  List<MatchModel> fetchMatches() {
    return [
      MatchModel(
        id: '1',
        age: 25,
        name: "Amelia",
        avatarPath: "assets/explore-screen-imageFive.png",
      ),
      MatchModel(
        id: '2',
        age: 28,
        name: "Emma",
        avatarPath: "assets/explore-screen-imageThree.png",
      ),
      MatchModel(
        id: '3',
        age: 23,
        name: "Emma",
        avatarPath: "assets/explore-screen-imageTwo.png",
      ),
      MatchModel(
        id: '4',
        age: 23,
        name: "Emma",
        avatarPath: "assets/explore-screen-imageTwo.png",
      ),
      MatchModel(
        id: '5',
        age: 23,
        name: "Emma",
        avatarPath: "assets/explore-screen-imageTwo.png",
      ),
      MatchModel(
        id: '6',
        age: 23,
        name: "Emma",
        avatarPath: "assets/explore-screen-imageTwo.png",
      ),
    ];
  }
}