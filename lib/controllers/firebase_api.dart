import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Glow/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Glow/models/chat_user.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import '../utils.dart';

class FirebaseApi {
  static Stream<List<ChatUser>> getUsers(bool isDermatologist) {
    User user = FbAuthController().user;

    print({user});
    if (isDermatologist) {
      return FirebaseFirestore.instance
          .collection('users')
          .where('lastMessageTime', isNotEqualTo: null)
          .orderBy('lastMessageTime', descending: true)
          .snapshots()
          .transform(Utils.transformer(ChatUser.fromJson));
    } else {
      return FirebaseFirestore.instance
          .collection('Dermatologists')
          .snapshots()
          .transform(Utils.transformer(ChatUser.fromJson));
    }
  }

  static Future uploadMessage(
      bool isDermatologist, String id, String message) async {
    User user = FbAuthController().user;
    final newMessage = Message(
      id: user.uid,
      name: user.displayName!,
      message: message,
      createdAt: DateTime.now(),
    );
    if (isDermatologist) {
      final refMessages =
          FirebaseFirestore.instance.collection('chats/$id/messages');

      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers
          .doc(id)
          .update({UserField.lastMessageTime: DateTime.now()});
    } else {
      final refMessages =
          FirebaseFirestore.instance.collection('chats/${user.uid}/messages');
      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers
          .doc(user.uid)
          .update({UserField.lastMessageTime: DateTime.now()});
    }
  }

  static Stream<List<Message>> getMessages(bool isDermatologist, String id) {
    User user = FbAuthController().user;
    if (isDermatologist) {
      return FirebaseFirestore.instance
          .collection('chats/$id/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    } else {
      return FirebaseFirestore.instance
          .collection('chats/${user.uid}/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    }
  }
}
