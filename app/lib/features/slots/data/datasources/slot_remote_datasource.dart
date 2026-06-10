import 'dart:convert';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/slot_model.dart';

abstract class SlotRemoteDataSource {
  Future<List<SlotModel>> getSlots(String venueId, String date);
  Future<void> bookSlot(String venueId, String date, String timeSlot);
}

class SlotRemoteDataSourceImpl implements SlotRemoteDataSource {
  final ApiClient apiClient;

  SlotRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<SlotModel>> getSlots(String venueId, String date) async {
    try {
      final response = await apiClient.get('/venues/$venueId/slots?date=$date');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => SlotModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw ServerException(
          message: 'Server returned code: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load slots from network');
    }
  }

  @override
  Future<void> bookSlot(String venueId, String date, String timeSlot) async {
    try {
      final response = await apiClient.post(
        '/bookings',
        body: {
          'venueId': venueId,
          'date': date,
          'timeSlot': timeSlot,
        },
      );

      if (response.statusCode == 201) {
        return; // Success
      } else {
        String errMsg = 'Failed to book slot';
        String? errCode;
        try {
          final bodyJson = jsonDecode(response.body);
          errMsg = bodyJson['error'] ?? errMsg;
          errCode = bodyJson['code'];
        } catch (_) {}
        
        throw ServerException(
          message: errMsg,
          statusCode: response.statusCode,
          errorCode: errCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception('Network error while booking slot');
    }
  }
}
