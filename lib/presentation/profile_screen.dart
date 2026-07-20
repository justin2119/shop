import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../domain/wiewmodel/provider/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF263238),
      appBar: AppBar(
        title: Text(
          'PROFIL',
          style: GoogleFonts.abel(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: const Color(0xFF263238),
        elevation: 0,
        centerTitle: true,
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (err, stack) => Center(child: Text('Erreur: \$err', style: const TextStyle(color: Colors.white))),
        data: (profile) => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white10,
                    backgroundImage: NetworkImage(profile.avatarUrl),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                profile.name.toUpperCase(),
                style: GoogleFonts.abel(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                profile.email,
                style: GoogleFonts.abel(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  profile.bio,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abel(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildMenuItem(context, Icons.shopping_bag_outlined, 'Mes Commandes'),
              _buildMenuItem(context, Icons.favorite_border, 'Mes Favoris'),
              _buildMenuItem(context, Icons.location_on_outlined, 'Adresses de Livraison'),
              _buildMenuItem(context, Icons.settings_outlined, 'Paramètres'),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF263238),
                    minimumSize: const Size(double.infinity, 54),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(
                    'DECONNEXION',
                    style: GoogleFonts.abel(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 24),
      title: Text(
        title.toUpperCase(),
        style: GoogleFonts.abel(
          color: Colors.white,
          fontSize: 14,
          letterSpacing: 1.2,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
      onTap: () {},
    );
  }
}
