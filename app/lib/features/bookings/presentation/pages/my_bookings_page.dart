import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/user_cubit.dart';
import '../../domain/entities/booking_entity.dart';
import '../bloc/booking_bloc.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_widget.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  void _fetchBookings() {
    final userId = context.read<UserCubit>().state.selectedUserId;
    if (userId != null) {
      context.read<BookingBloc>().add(GetUserBookingsEvent(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<UserCubit>().state.selectedUserId;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('My Bookings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1F2937))),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        elevation: 0,
      ),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingCancelSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Booking canceled successfully'),
                backgroundColor: Color(0xFF10B981),
              ),
            );
            _fetchBookings();
          } else if (state is BookingCancelFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: const Text('Cancellation Failed', style: TextStyle(fontWeight: FontWeight.bold)),
                content: Text(state.message),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                    ),
                    child: const Text('OK', style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
            _fetchBookings(); // Refresh list to get current state
          }
        },
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return const QuickLoadingWidget(message: 'Loading your bookings...');
            } else if (state is BookingCancelInProgress) {
              return const QuickLoadingWidget(message: 'Processing cancellation...');
            } else if (state is BookingError) {
              return QuickErrorWidget(
                errorMessage: state.message,
                onRetry: _fetchBookings,
              );
            } else if (state is BookingLoaded) {
              final bookings = state.bookings;
              if (bookings.isEmpty) {
                return QuickEmptyWidget(
                  title: 'No Bookings Found',
                  message: 'You have not booked any sports slots yet.',
                  icon: Icons.sports_tennis_rounded,
                  buttonLabel: 'Browse Venues',
                  onButtonPressed: () {
                    Navigator.pop(context);
                  },
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  _fetchBookings();
                },
                color: const Color(0xFF6366F1),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return _buildBookingCard(context, booking, userId);
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, BookingEntity booking, String? userId) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    booking.imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.venueName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, size: 12, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              booking.location,
                              style: TextStyle(fontSize: 12, color: Colors.grey[550]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(height: 1, color: Colors.grey[150]),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DATE & TIME',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${DateFormatter.toHumanDateString(booking.date)} • ${booking.timeSlot}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => _confirmCancel(context, booking, userId),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.redAccent),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCancel(BuildContext context, BookingEntity booking, String? userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Cancel Booking', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to cancel your booking for ${booking.venueName} at ${booking.timeSlot}?'),
          actions: [
            TextButton(
              child: const Text('Keep Booking', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Cancel Booking', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
                context.read<BookingBloc>().add(
                  CancelBookingEvent(
                    bookingId: booking.id,
                    userId: userId ?? '',
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
