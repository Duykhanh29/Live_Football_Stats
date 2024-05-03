import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/get_current_user_uc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/get_otp_verify_uc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/get_user_uc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/is_login_uc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/sign_in_with_facebook_uc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/sign_in_with_google_uc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/sign_in_with_phone_uc.dart';
import 'package:live_football_stats/features/auth/domain/usecases/sign_out_uc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_state.dart';
import 'dart:async';
import '../../../domain/usecases/get_update_user_uc.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignInWithGoogleUseCase signInWithGoogleUseCase;
  GetCurrentUserUseCase currentUserUseCase;
  GetUpdateUserUseCase updateUserUseCase;
  SignOutUseCase signOutUseCase;
  SignInWithPhoneUseCase signInWithPhoneUseCase;
  SignInWithFacebookeUseCase signInWithFacebookeUseCase;
  IsLoginUseCase isLoginUseCase;
  GetOTPVerifyUseCase verifyUseCase;
  GetUserUseCase getUserUseCase;
  // StreamController<UserEntity?> streamController =
  //     StreamController<UserEntity?>.broadcast();
  AuthBloc(
      {required this.currentUserUseCase,
      required this.signInWithFacebookeUseCase,
      required this.signInWithGoogleUseCase,
      required this.signInWithPhoneUseCase,
      required this.signOutUseCase,
      required this.updateUserUseCase,
      required this.isLoginUseCase,
      required this.verifyUseCase,
      required this.getUserUseCase})
      : super(AuthInitial()) {
    on<SignInWithGoogle>(onSignInWithGoogleEvent);
    on<SignInWithPhone>(onSignInWithPhoneEvent);
    on<SignInWithFacebook>(onSignInWithFacebookEvent);
    on<SignOut>(onSignOutEvent);
    on<UpdateUser>(onUpdateUserEvent);
    on<IsLoginEvent>(onIsLoginEvent);
    on<OtpVerify>(onOtpVerifyEvent);
    //  on<GetCurrentUserEvent>(onGetCurrentUserEvent);
  }
  Future<void> onIsLoginEvent(
      IsLoginEvent event, Emitter<AuthState> emit) async {
    try {
      final result = await isLoginUseCase.call();
      UserEntity? user = await getUserUseCase.call();
      if (result != null) {
        result.fold((l) {
          emit(ErrorAuthState());
        }, (r) async {
          if (r) {
            if (user != null) {
              emit(AuthorizedState(user: user)); // Emit nếu chưa kết thúc
            } else {
              emit(UnauthorizedState());
            }
            //  emit(AuthorizedState(user: user));
          } else {
            emit(UnauthorizedState());
          }
        });
      } else {
        emit(UnauthorizedState());
      }
    } catch (e) {
      emit(ErrorAuthState());
    }
  }

  Stream<UserEntity?> get currentUser async* {
    StreamController<UserEntity?> streamController =
        StreamController<UserEntity?>.broadcast();

    final result = currentUserUseCase.call();
    StreamSubscription subscription = result.listen((event) {
      streamController.sink.add(event);
    });
    streamController.onCancel = () {
      subscription.cancel();
      streamController.close();
    };
    yield* streamController.stream;
  }
  // Future<void> onGetCurrentUserEvent(
  //     GetCurrentUserEvent event, Emitter<AuthState> emit) async {
  //   try {
  //     final result = currentUserUseCase.call().asBroadcastStream();
  //     result.listen((userEntity) {
  //       // Cập nhật trạng thái của AuthBloc với dữ liệu người dùng mới
  //       //   emit(AuthorizedState());
  //       // Đẩy dữ liệu người dùng mới vào StreamController
  //       streamController.add(userEntity);
  //     }, onError: (error) {
  //       emit(ErrorAuthState(message: error.toString()));
  //     });
  //   } catch (e) {
  //     emit(ErrorAuthState(message: e.toString()));
  //   }
  // }

  Future<void> onSignInWithGoogleEvent(
      SignInWithGoogle event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final result = await signInWithGoogleUseCase.call();
      UserEntity? user = await getUserUseCase.call();
      if (result != null) {
        result.fold((l) => emit(ErrorAuthState()), (r) async {
          if (r) {
            if (user != null) {
              emit(AuthorizedState(user: user));
            } else {
              emit(UnauthorizedState());
            }
          } else {
            emit(UnauthorizedState());
          }
        });
      } else {
        emit(ErrorAuthState());
      }
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

  Future<void> onSignInWithPhoneEvent(
      SignInWithPhone event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final result = await signInWithPhoneUseCase.call(event.phone);
      UserEntity? user = await getUserUseCase.call();
      if (result != null) {
        result.fold((l) => emit(ErrorAuthState()), (r) async {
          if (r == null) {
            if (user != null) {
              emit(AuthorizedState(user: user));
            } else {
              emit(ErrorAuthState());
            }
          } else {
            emit(IsOTPVerified(verificationId: r));
          }
        });
      } else {
        emit(ErrorAuthState());
      }
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

  Future<void> onSignInWithFacebookEvent(
      SignInWithFacebook event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final result = await signInWithFacebookeUseCase.call();
      UserEntity? user = await getUserUseCase.call();
      if (result != null) {
        result.fold((l) {
          emit(ErrorAuthState());
        }, (r) async {
          if (r) {
            if (user != null) {
              emit(AuthorizedState(user: user));
            } else {
              emit(ErrorAuthState());
            }
          } else {
            emit(UnauthorizedState());
          }
        });
      } else {
        emit(ErrorAuthState());
      }
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

  Future<void> onSignOutEvent(SignOut event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final result = await signOutUseCase.call();
      if (result != null) {
        result.fold((l) {
          emit(ErrorAuthState());
        }, (r) {
          emit(UnauthorizedState());
        });
      } else {
        emit(ErrorAuthState());
      }
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

  Future<void> onOtpVerifyEvent(
      OtpVerify event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final result =
          await verifyUseCase.call(event.verificationId, event.userOtp);
      UserEntity? user = await getUserUseCase.call();
      if (result != null) {
        result.fold((l) => emit(ErrorAuthState()), (r) async {
          if (user != null) {
            emit(AuthorizedState(user: user));
          } else {
            emit(ErrorAuthState());
          }
        });
      } else {
        emit(ErrorAuthState());
      }
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

  Future<void> onUpdateUserEvent(
      UpdateUser event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final result = await updateUserUseCase.call(event.userEntity);
      if (result != null) {
        result.fold(
            (l) => emit(ErrorAuthState()), (r) => emit(ChangeUserInfoState()));
      } else {
        emit(ErrorAuthState());
      }
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }
}
