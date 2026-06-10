import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../models/venue_model.dart';

abstract class VenueRemoteDataSource {
  Future<List<VenueModel>> getVenues();
}

class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final ApiClient apiClient;

  VenueRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<VenueModel>> getVenues() async {
    try {
      final response = await apiClient.get('/venues');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => VenueModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Server returned code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to backend: ${e.toString()}');
    }
  }
}
