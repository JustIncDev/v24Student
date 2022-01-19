import 'package:bloc/bloc.dart';
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
        } else if (event is FavoriteSelectTeacherEvent) {
          _handleSelectTeacherEvent(event, emit);
        } else if (event is FavoriteSelectSubjectEvent) {
          _handleSelectSubjectEvent(event, emit);
        } else if (event is FavoritePerformEvent) {
          _handlePerformEvent(event, emit);
        } else if (event is FavoriteSuccessEvent) {
          _handleSuccessEvent(event, emit);
        } else if (event is FavoriteFailedEvent) {
          _handleFailedEvent(event, emit);
        } else if (event is FavoritePrepareLocalEvent) {
          _handlePrepareLocalEvent(event, emit);
        } else if (event is FavoriteSelectSubSubjectLocalEvent) {
          _handleSelectLocalEvent(event, emit);
        } else if (event is FavoriteSelectAllSubSubjectsLocalEvent) {
          _handleSelectAllLocalEvent(event, emit);
        }
      },
    );
  }

  Future<void> _handleInitEvent(
    FavoriteInitEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteScreenStatus.lock));
    var subjects = await _favoriteRepo.getSubjectsList();
    var teachers = await _favoriteRepo.getTeachersList();
    emit(
      state.copyWith(
        favoriteSubjects: subjects,
        favoriteTeachers: teachers,
        status: FavoriteScreenStatus.input,
      ),
    );
  }

  void _handleSelectTeacherEvent(
    FavoriteSelectTeacherEvent event,
    Emitter<FavoriteState> emit,
  ) {
    var newItemList = <String>[];
    newItemList.addAll(state.selectedTeachers);
    newItemList.contains(event.id) ? newItemList.remove(event.id) : newItemList.add(event.id);
    emit(state.copyWith(selectedTeachers: newItemList));
  }

  void _handleSelectSubjectEvent(
    FavoriteSelectSubjectEvent event,
    Emitter<FavoriteState> emit,
  ) {
    var newItemMap = <String, List<String>>{};
    newItemMap.addAll(state.selectedSubjects);
    if (newItemMap.containsKey(event.mainSubjectId)) {
      var subSubjects = <String>[];
      subSubjects.addAll(newItemMap[event.mainSubjectId]?.toList() ?? []);
      state.subjectSelection.forEach((element) {
        if (subSubjects.contains(element)) {
          subSubjects.remove(element);
        } else {
          subSubjects.add(element);
        }
      });
    } else {
      newItemMap.addAll({event.mainSubjectId: state.subjectSelection});
    }
    emit(state.copyWith(selectedSubjects: newItemMap, subjectSelection: []));
  }

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

  void _handlePrepareLocalEvent(
    FavoritePrepareLocalEvent event,
    Emitter<FavoriteState> emit,
  ) {
    emit(state.copyWith(subjectSelection: state.selectedSubjects[event.mainSubjectId]));
  }

  void _handleSelectLocalEvent(
    FavoriteSelectSubSubjectLocalEvent event,
    Emitter<FavoriteState> emit,
  ) {
    var newItemList = <String>[];
    newItemList.addAll(state.subjectSelection);
    newItemList.contains(event.id) ? newItemList.remove(event.id) : newItemList.add(event.id);
    emit(state.copyWith(subjectSelection: newItemList));
  }

  void _handleSelectAllLocalEvent(
    FavoriteSelectAllSubSubjectsLocalEvent event,
    Emitter<FavoriteState> emit,
  ) {
    var newItemList = <String>[];
    newItemList.addAll(state.subjectSelection);
    event.item.subjects?.forEach((element) {
      if (!newItemList.contains(element.id)) {
        newItemList.add(element.id);
      }
    });
    emit(state.copyWith(subjectSelection: newItemList));
  }
}
