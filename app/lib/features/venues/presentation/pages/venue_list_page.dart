import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/user_cubit.dart';
import '../../../auth/presentation/pages/user_select_page.dart';
import '../../../bookings/presentation/pages/my_bookings_page.dart';
import '../../../slots/presentation/pages/venue_detail_page.dart';
import '../../domain/entities/venue_entity.dart';
import '../bloc/venue_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_widget.dart';

class VenueListPage extends StatefulWidget {
  const VenueListPage({Key? key}) : super(key: key);

  @override
  State<VenueListPage> createState() => _VenueListPageState();
}

class _VenueListPageState extends State<VenueListPage> {
  @override
  void initState() {
    super.initState();
    context.read<VenueBloc>().add(const GetVenuesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final userName = userState.selectedUserName ?? 'Guest';

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, $userName 👋',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            Text(
              'Find and book sports slots',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_added_rounded, color: Color(0xFF6366F1)),
            tooltip: 'My Bookings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyBookingsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            tooltip: 'Logout',
            onPressed: () {
              context.read<UserCubit>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserSelectPage()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<VenueBloc, VenueState>(
        builder: (context, state) {
          if (state is VenueLoading) {
            return const QuickLoadingWidget(message: 'Loading venues...');
          } else if (state is VenueError) {
            return QuickErrorWidget(
              errorMessage: state.message,
              onRetry: () {
                context.read<VenueBloc>().add(const GetVenuesEvent());
              },
            );
          } else if (state is VenueLoaded) {
            final venues = state.venues;
            if (venues.isEmpty) {
              return const QuickEmptyWidget(
                title: 'No Venues Found',
                message: 'No sports venues are currently available in the database.',
                icon: Icons.sports_tennis_rounded,
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<VenueBloc>().add(const GetVenuesEvent());
              },
              color: const Color(0xFF6366F1),
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: venues.length,
                itemBuilder: (context, index) {
                  final venue = venues[index];
                  return _buildVenueCard(context, venue);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildVenueCard(BuildContext context, VenueEntity venue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VenueDetailPage(venue: venue),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Venue Image
              Stack(
                children: [
                  Image.network(
                    venue.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        venue.type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            venue.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Venue Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: 14, color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            venue.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(height: 1, color: Colors.grey[150]),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price / Hour',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        Text(
                          '₹${venue.pricePerHour.toInt()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
