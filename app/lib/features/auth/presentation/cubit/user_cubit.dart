import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_client.dart';

class UserState {
  final String? selectedUserId;
  final String? selectedUserName;

  const UserState({this.selectedUserId, this.selectedUserName});
}

class UserCubit extends Cubit<UserState> {
  final ApiClient apiClient;

  UserCubit(this.apiClient) : super(const UserState());

  void selectUser(String userId, String userName) {
    apiClient.setUserId(userId);
    emit(UserState(selectedUserId: userId, selectedUserName: userName));
  }

  void logout() {
    apiClient.setUserId(null);
    emit(const UserState());
  }
}
