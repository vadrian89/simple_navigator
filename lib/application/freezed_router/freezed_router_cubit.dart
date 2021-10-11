import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_router_state.dart';
part 'freezed_router_cubit.freezed.dart';

class FreezedRouterCubit extends Cubit<FreezedRouterState> {
  FreezedRouterCubit() : super(const FreezedRouterState.page1());

  void goToPage1([String? text]) => emit(FreezedRouterState.page1(extraPageContent: text));

  void goToPage2([String? text]) => emit(FreezedRouterState.page2(extraPageContent: text));

  void goToPage3([String? text]) => emit(FreezedRouterState.page3(extraPageContent: text));

  void goToPage4([String? text]) => emit(FreezedRouterState.page4(extraPageContent: text));

  void popExtra() {
    state.maybeWhen(
      orElse: () => goToPage1(),
      page2: (_) => goToPage2(),
      page3: (_) => goToPage3(),
      page4: (_) => goToPage4(),
    );
  }
}
