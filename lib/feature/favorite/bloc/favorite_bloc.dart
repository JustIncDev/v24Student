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
          await _handlePerformEvent(event, emit);
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
    emit(state.copyWith(status: FavoriteScreenStatus.lock));
    var subjects = await _favoriteRepo.getSubjectsList();
    var teachers = await _favoriteRepo.getTeachersList();
    if (subjects.isNotEmpty) {
      emit(
        state.copyWith(
          favoriteSubjects: subjects,
          favoriteTeachers: teachers,
          status: FavoriteScreenStatus.input,
        ),
      );
    }
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
    if (!event.selectAll) {
      if (newItemMap.containsKey(event.mainSubjectId) && event.subSubjectId != null) {
        if (newItemMap[event.mainSubjectId] != null &&
            newItemMap[event.mainSubjectId]!.isNotEmpty) {
          var subjectList = <String>[];

          subjectList.addAll(newItemMap[event.mainSubjectId]!.toList());

          subjectList.contains(event.subSubjectId)
              ? subjectList.remove(event.subSubjectId)
              : subjectList.add(event.subSubjectId!);

          var newSubjectMap = <String, List<String>>{
            event.mainSubjectId: subjectList,
          };
          newItemMap.addEntries(newSubjectMap.entries);

          if (subjectList.isEmpty) {
            newItemMap.remove(event.mainSubjectId);
          }
        }
      } else if (newItemMap.containsKey(event.mainSubjectId)) {
        newItemMap.remove(event.mainSubjectId);
      } else if (!newItemMap.containsKey(event.mainSubjectId)) {
        var newSubjectMap = <String, List<String>>{
          event.mainSubjectId: event.subSubjectId != null ? [event.subSubjectId!] : [],
        };
        newItemMap.addEntries(newSubjectMap.entries);
      }
    } else {
      var itemList = <String>[];
      state.favoriteSubjects.forEach((element) {
        if (element.id == event.mainSubjectId && element.subjects != null) {
          itemList.addAll(element.subjects!.map((e) => e.id));
        }
      });
      newItemMap[event.mainSubjectId] = itemList;
    }
    emit(state.copyWith(selectedSubjects: newItemMap));
  }

  Future<void> _handlePerformEvent(
    FavoritePerformEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteScreenStatus.lock));
    var response = await _favoriteRepo.saveFavoriteData(
      state.selectedSubjects,
      state.selectedTeachers,
    );
    if (response) {
      emit(state.copyWith(status: FavoriteScreenStatus.next));
    } else {
      add(FavoriteFailedEvent());
    }
  }

  void _handleSuccessEvent(
    FavoriteSuccessEvent event,
    Emitter<FavoriteState> emit,
  ) {}

  void _handleFailedEvent(
    FavoriteFailedEvent event,
    Emitter<FavoriteState> emit,
  ) {}
}
