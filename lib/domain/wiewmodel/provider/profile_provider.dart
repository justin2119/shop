import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_profile.dart';

class ProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    // Simulating API fetch for user profile data
    await Future.delayed(const Duration(seconds: 1));
    return const UserProfile(
      name: 'Justin Draoude',
      email: 'justin@poke.com',
      avatarUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
      bio: 'Développeur passionné par Flutter et l\'architecture propre.',
    );
  }

  Future<void> updateProfile(UserProfile profile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Logic to update profile via repository would go here
      return profile;
    });
  }
}

final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserProfile>(ProfileNotifier.new);
