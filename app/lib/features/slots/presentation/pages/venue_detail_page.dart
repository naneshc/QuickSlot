import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/user_cubit.dart';
import '../../domain/entities/slot_entity.dart';
import '../../../venues/domain/entities/venue_entity.dart';
import '../bloc/slot_bloc.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';

class VenueDetailPage extends StatefulWidget {
  final VenueEntity venue;

  const VenueDetailPage({Key? key, required this.venue}) : super(key: key);

  @override
  State<VenueDetailPage> createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 0));
  Timer? _pollingTimer;
  String _activeFilter = 'All'; // 'All', 'Morning', 'Afternoon', 'Evening'

  @override
  void initState() {
    super.initState();
    _fetchSlots(isSilent: false);
    _startPolling();
  }

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }

  void _fetchSlots({bool isSilent = false}) {
    final dateStr = DateFormatter.toApiDate(_selectedDate);
    context.read<SlotBloc>().add(
      GetSlotsEvent(
        venueId: widget.venue.id,
        date: dateStr,
        isSilent: isSilent,
      ),
    );
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchSlots(isSilent: true);
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _fetchSlots(isSilent: false);
  }

  // Filter slots by time of day
  List<SlotEntity> _filterSlots(List<SlotEntity> slots) {
    if (_activeFilter == 'All') return slots;
    
    return slots.where((slot) {
      final hourStr = slot.timeSlot.split(':')[0];
      final hour = int.tryParse(hourStr) ?? 0;

      if (_activeFilter == 'Morning') {
        return hour >= 6 && hour < 12;
      } else if (_activeFilter == 'Afternoon') {
        return hour >= 12 && hour < 16;
      } else if (_activeFilter == 'Evening') {
        return hour >= 16 && hour <= 22;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();
    final currentUserId = userCubit.state.selectedUserId;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(widget.venue.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1F2937))),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        elevation: 0,
      ),
      body: BlocListener<SlotBloc, SlotState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            _showSuccessDialog(state.date);
            _fetchSlots(isSilent: true);
          } else if (state is BookingFailure) {
            _showFailureDialog(state.message, state.errorCode);
            _fetchSlots(isSilent: true);
          }
        },
        child: Column(
          children: [
            // Date Picker Header
            _buildDatePickerSection(),

            // Filter Chips Section
            _buildFilterSection(),

            // Slot Grid
            Expanded(
              child: BlocBuilder<SlotBloc, SlotState>(
                builder: (context, state) {
                  if (state is SlotLoading) {
                    return const QuickLoadingWidget(message: 'Loading slots...');
                  } else if (state is SlotError) {
                    return QuickErrorWidget(
                      errorMessage: state.message,
                      onRetry: () => _fetchSlots(isSilent: false),
                    );
                  } else if (state is SlotLoaded) {
                    final filteredSlots = _filterSlots(state.slots);
                    
                    if (filteredSlots.isEmpty) {
                      return Center(
                        child: Text(
                          'No slots found for this time period.',
                          style: TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: filteredSlots.length,
                      itemBuilder: (context, index) {
                        final slot = filteredSlots[index];
                        final isBookingThisSlot = state.bookingSlotTime == slot.timeSlot;
                        return _buildSlotTile(slot, currentUserId, isBookingThisSlot);
                      },
                    );
                  } else if (state is BookingLoading) {
                    return const QuickLoadingWidget(message: 'Submitting booking...');
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded, color: Color(0xFF6366F1)),
            onPressed: () {
              _onDateChanged(_selectedDate.subtract(const Duration(days: 1)));
            },
          ),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 30)),
                lastDate: DateTime.now().add(const Duration(days: 60)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Color(0xFF6366F1),
                        onPrimary: Colors.white,
                        onSurface: Color(0xFF1F2937),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                _onDateChanged(picked);
              }
            },
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFF6366F1)),
                const SizedBox(width: 8),
                Text(
                  DateFormatter.toHumanDate(_selectedDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF6366F1)),
            onPressed: () {
              _onDateChanged(_selectedDate.add(const Duration(days: 1)));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    final filters = ['All', 'Morning', 'Afternoon', 'Evening'];
    return Container(
      height: 50,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _activeFilter == filter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              selectedColor: const Color(0xFF6366F1).withOpacity(0.15),
              checkmarkColor: const Color(0xFF6366F1),
              labelStyle: TextStyle(
                color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF4B5563),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              backgroundColor: Colors.grey[100],
              side: BorderSide(
                color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _activeFilter = filter;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlotTile(SlotEntity slot, String? currentUserId, bool isBookingThisSlot) {
    final isBooked = slot.isBooked;
    final isMine = isBooked && slot.userId == currentUserId;

    Color bg;
    Color border;
    Color text;
    String statusLabel;

    if (isBookingThisSlot) {
      bg = Colors.amber[50]!;
      border = Colors.amber;
      text = Colors.amber[800]!;
      statusLabel = 'Booking...';
    } else if (isMine) {
      bg = const Color(0xFFEEF2FF); // Light Indigo
      border = const Color(0xFF6366F1);
      text = const Color(0xFF4F46E5);
      statusLabel = 'Booked by You';
    } else if (isBooked) {
      bg = Colors.red[50]!;
      border = Colors.red[100]!;
      text = Colors.red[700]!;
      statusLabel = 'Booked';
    } else {
      bg = const Color(0xFFECFDF5);
      border = const Color(0xFFD1FAE5);
      text = const Color(0xFF047857);
      statusLabel = 'Available';
    }

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 1.5),
      ),
      child: InkWell(
        onTap: (!isBooked && !isBookingThisSlot) ? () => _confirmBooking(slot.timeSlot) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slot.timeSlot,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isBooked ? Colors.grey[700] : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: text,
                    ),
                  ),
                  if (isBookingThisSlot)
                    const SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.amber),
                    )
                  else if (!isBooked)
                    const Icon(Icons.add_circle_outline_rounded, size: 14, color: Color(0xFF10B981)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmBooking(String timeSlot) {
    final dateStr = DateFormatter.toHumanDate(_selectedDate);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Confirm Booking', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Do you want to book this slot ($timeSlot) on $dateStr?'),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Confirm', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<SlotBloc>().add(
                  BookSlotEvent(
                    venueId: widget.venue.id,
                    date: DateFormatter.toApiDate(_selectedDate),
                    timeSlot: timeSlot,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String date) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 28),
              SizedBox(width: 8),
              Text('Booking Successful', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text('Your slot booking has been confirmed and saved!'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Awesome', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showFailureDialog(String message, String? errorCode) {
    final isDoubleBooked = errorCode == 'SLOT_ALREADY_BOOKED';
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(
                isDoubleBooked ? Icons.lock_rounded : Icons.error_rounded,
                color: Colors.redAccent,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                isDoubleBooked ? 'Slot Already Taken' : 'Booking Failed',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            isDoubleBooked
                ? 'Oops! Another user completed their booking for this exact slot just a millisecond before you. Please select another slot.'
                : message,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
