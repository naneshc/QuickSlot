import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_cubit.dart';
import '../../../venues/presentation/pages/venue_list_page.dart';

class UserSelectPage extends StatelessWidget {
  const UserSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockUsers = [
      {'id': 'user_1', 'name': 'Alice Smith', 'role': 'Badminton Player', 'initials': 'AS', 'color': '0xFF6366F1'},
      {'id': 'user_2', 'name': 'Bob Johnson', 'role': 'Football Captain', 'initials': 'BJ', 'color': '0xFF10B981'},
      {'id': 'user_3', 'name': 'Charlie Brown', 'role': 'Cricket Batsman', 'initials': 'CB', 'color': '0xFFF59E0B'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Logo
                const Icon(
                  Icons.sports_soccer_rounded,
                  size: 72,
                  color: Color(0xFF6366F1),
                ),
                const SizedBox(height: 16),
                const Text(
                  'QuickSlot',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Book sports slots instantly. Select a profile to start testing double-booking prevention.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 48),

                const Text(
                  'SELECT TEST PROFILE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4B5563),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Users list
                ...mockUsers.map((user) {
                  final colorVal = int.parse(user['color']!);
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey[200]!),
                    ),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        context.read<UserCubit>().selectUser(user['id']!, user['name']!);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const VenueListPage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Color(colorVal).withOpacity(0.15),
                              child: Text(
                                user['initials']!,
                                style: TextStyle(
                                  color: Color(colorVal),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['name']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    user['role']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
