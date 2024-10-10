import 'package:elevatecheck/app/data/repository/attendance_repository.dart';
import 'package:elevatecheck/app/data/repository/auth_repository.dart';
import 'package:elevatecheck/app/data/repository/photo_repository.dart';
import 'package:elevatecheck/app/data/repository/schedule_repository.dart';
import 'package:elevatecheck/app/data/source/attendance_api_service.dart';
import 'package:elevatecheck/app/data/source/auth_api_service.dart';
import 'package:elevatecheck/app/data/source/photo_api_service.dart';
import 'package:elevatecheck/app/data/source/schedule_api_service.dart';
import 'package:elevatecheck/app/module/repository/attendance_repository.dart';
import 'package:elevatecheck/app/module/repository/auth_repository.dart';
import 'package:elevatecheck/app/module/repository/photo_repository.dart';
import 'package:elevatecheck/app/module/repository/schedule_repository.dart';
import 'package:elevatecheck/app/module/use_case/attendance_get_by_month_year.dart';
import 'package:elevatecheck/app/module/use_case/attendance_get_this_month.dart';
import 'package:elevatecheck/app/module/use_case/attendance_get_today.dart';
import 'package:elevatecheck/app/module/use_case/attendance_send.dart';
import 'package:elevatecheck/app/module/use_case/auth_login.dart';
import 'package:elevatecheck/app/module/use_case/photo_get_bytes.dart';
import 'package:elevatecheck/app/module/use_case/schedule_banned.dart';
import 'package:elevatecheck/app/module/use_case/schedule_get.dart';
import 'package:elevatecheck/app/presentation/detail_attendance/detail_attendance_notifier.dart';
import 'package:elevatecheck/app/presentation/face_recognition/face_recognition_notifier.dart';
import 'package:elevatecheck/app/presentation/home/home_notifier.dart';
import 'package:elevatecheck/app/presentation/login/login_notifier.dart';
import 'package:elevatecheck/app/presentation/map/map_notifier.dart';
import 'package:elevatecheck/core/network/app_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

Future<void> initDependency() async {
  //dio
  Dio dio = Dio();
  dio.interceptors.add(AppInterceptor());
  dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      compact: true));
  sl.registerSingleton<Dio>(dio);

  //apiservice
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<AttendanceApiService>(AttendanceApiService(sl()));
  sl.registerSingleton<ScheduleApiService>(ScheduleApiService(sl()));
  sl.registerSingleton<PhotoApiService>(PhotoApiService(sl()));

  //repositoy
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<AttendanceRepository>(AttendanceRepositoryImpl(sl()));
  sl.registerSingleton<ScheduleRepository>(ScheduleRepositoryImpl(sl()));
  sl.registerSingleton<PhotoRepository>(PhotoRepositoryImpl(sl()));

  //usecase
  sl.registerSingleton<AuthLoginUseCase>(AuthLoginUseCase(sl()));
  sl.registerSingleton<AttendanceGetTodayUseCase>(
      AttendanceGetTodayUseCase(sl()));
  sl.registerSingleton<AttendanceGetMonthUseCase>(
      AttendanceGetMonthUseCase(sl()));
  sl.registerSingleton<AttendanceSendUseCase>(AttendanceSendUseCase(sl()));
  sl.registerSingleton<AttendanceGetByMonthYear>(
      AttendanceGetByMonthYear(sl()));
  sl.registerSingleton<ScheduleGetUseCase>(ScheduleGetUseCase(sl()));
  sl.registerSingleton<ScheduleBannedUseCase>(ScheduleBannedUseCase(sl()));
  sl.registerSingleton<PhotoGetBytesUseCase>(PhotoGetBytesUseCase(sl()));

  //provider
  sl.registerFactoryParam<LoginNotifier, void, void>(
    (param1, param2) => LoginNotifier(sl()),
  );
  sl.registerFactoryParam<HomeNotifier, void, void>(
    (param1, param2) => HomeNotifier(sl(), sl(), sl(), sl()),
  );
  sl.registerFactoryParam<MapNotifier, void, void>(
    (param1, param2) => MapNotifier(sl(), sl(), sl()),
  );
  sl.registerFactoryParam<DetailAttendanceNotifier, void, void>(
      (param1, param2) => DetailAttendanceNotifier(sl()));
  sl.registerFactoryParam<FaceRecognitionNotifier, void, void>(
    (param1, param2) => FaceRecognitionNotifier(sl()),
  );
}
