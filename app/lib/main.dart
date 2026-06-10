import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_client.dart';
import 'features/auth/presentation/cubit/user_cubit.dart';
import 'features/auth/presentation/pages/user_select_page.dart';

import 'features/venues/data/datasources/venue_remote_datasource.dart';
import 'features/venues/data/repositories/venue_repository_impl.dart';
import 'features/venues/domain/usecases/get_venues.dart';
import 'features/venues/presentation/bloc/venue_bloc.dart';

import 'features/slots/data/datasources/slot_remote_datasource.dart';
import 'features/slots/data/repositories/slot_repository_impl.dart';
import 'features/slots/domain/usecases/get_slots.dart';
import 'features/slots/domain/usecases/book_slot.dart';
import 'features/slots/presentation/bloc/slot_bloc.dart';

import 'features/bookings/data/datasources/booking_remote_datasource.dart';
import 'features/bookings/data/repositories/booking_repository_impl.dart';
import 'features/bookings/domain/usecases/get_user_bookings.dart';
import 'features/bookings/domain/usecases/cancel_booking.dart';
import 'features/bookings/presentation/bloc/booking_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();

  // BASE API URL
  // NOTE: For Android Emulator, use 10.0.2.2.
  // For iOS Simulator, use localhost.
  // For physical testing on two devices, change this to your machine's Local Network IP (e.g. 192.168.1.10)
  const String backendBaseUrl = 'http://10.0.2.2:5000'; 
  
  final apiClient = ApiClient(baseUrl: backendBaseUrl);

  // Setup Data Sources
  final venueRemoteDataSource = VenueRemoteDataSourceImpl(apiClient);
  final slotRemoteDataSource = SlotRemoteDataSourceImpl(apiClient);
  final bookingRemoteDataSource = BookingRemoteDataSourceImpl(apiClient);

  // Setup Repositories
  final venueRepository = VenueRepositoryImpl(venueRemoteDataSource);
  final slotRepository = SlotRepositoryImpl(slotRemoteDataSource);
  final bookingRepository = BookingRepositoryImpl(
    remoteDataSource: bookingRemoteDataSource,
    sharedPreferences: sharedPrefs,
  );

  // Setup Use Cases
  final getVenues = GetVenues(venueRepository);
  final getSlots = GetSlots(slotRepository);
  final bookSlot = BookSlot(slotRepository);
  final getUserBookings = GetUserBookings(bookingRepository);
  final cancelBooking = CancelBooking(bookingRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(apiClient),
        ),
        BlocProvider<VenueBloc>(
          create: (context) => VenueBloc(getVenues),
        ),
        BlocProvider<SlotBloc>(
          create: (context) => SlotBloc(
            getSlots: getSlots,
            bookSlot: bookSlot,
          ),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(
            getUserBookings: getUserBookings,
            cancelBooking: cancelBooking,
          ),
        ),
      ],
      child: const QuickSlotApp(),
    ),
  );
}

class QuickSlotApp extends StatelessWidget {
  const QuickSlotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickSlot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6366F1), // Indigo 500
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          primary: const Color(0xFF6366F1),
          secondary: const Color(0xFF10B981), // Emerald 500
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xFF1F2937)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
      ),
      home: const UserSelectPage(),
    );
  }
}
