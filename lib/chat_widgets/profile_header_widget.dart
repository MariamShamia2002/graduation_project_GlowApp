import 'package:flutter/material.dart';
import 'package:Glow/models/chat_user.dart';
import 'package:Glow/screens/app/user_profile_screen.dart';
import 'package:Glow/constants.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final ChatUser user;
  final bool isDermatologist;

  const ProfileHeaderWidget({
    required this.user,
    required this.isDermatologist,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        padding: const EdgeInsets.all(16).copyWith(left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BackButton(
              color: kTitleColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: () {
                if (isDermatologist) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(
                          id: user.id, isDermatologist: isDermatologist),
                    ),
                  );
                }
              },
              child: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: kTitleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 4),
          ],
        ),
      );
}
