import 'package:flutter_bloc/flutter_bloc.dart';

class SearchingCubit extends Cubit<bool> {
  SearchingCubit() : super(false);
  bool isSearch = false;

  void isSearching() => emit(isSearch = !isSearch);
}
