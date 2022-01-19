import 'package:bloc/bloc.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/domain/subject.dart';
import 'package:v24_student_app/domain/teacher.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_grid_widget.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/repo/favorites_repo.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepo _favoriteRepo;

  FavoriteBloc({required FavoriteRepo favoriteRepo})
      : _favoriteRepo = favoriteRepo,
        super(FavoriteState.init()) {
    on<FavoriteEvent>(
      (event, emit) async {
        if (event is FavoriteInitEvent) {
          await _handleInitEvent(event, emit);
        } else if (event is FavoriteSelectEvent) {
          _handleSelectEvent(event, emit);
        } else if (event is FavoritePerformEvent) {
          _handlePerformEvent(event, emit);
        } else if (event is FavoriteSuccessEvent) {
          _handleSuccessEvent(event, emit);
        } else if (event is FavoriteFailedEvent) {
          _handleFailedEvent(event, emit);
        }
      },
    );
  }

  Future<void> _handleInitEvent(
    FavoriteInitEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(status: BaseScreenStatus.lock));
    var subjects = await _favoriteRepo.getSubjectsList();
    var teachers = await _favoriteRepo.getTeachersList();
    emit(
      state.copyWith(
        favoriteSubjects: subjects,
        favoriteTeachers: teachers,
        status: BaseScreenStatus.input,
      ),
    );
  }

  void _handleSelectEvent(
    FavoriteSelectEvent event,
    Emitter<FavoriteState> emit,
  ) {}

  void _handlePerformEvent(
    FavoritePerformEvent event,
    Emitter<FavoriteState> emit,
  ) {}

  void _handleSuccessEvent(
    FavoriteSuccessEvent event,
    Emitter<FavoriteState> emit,
  ) {}

  void _handleFailedEvent(
    FavoriteFailedEvent event,
    Emitter<FavoriteState> emit,
  ) {}
}
