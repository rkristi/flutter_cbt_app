// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_app/data/datasources/content_remote_datasource.dart';
import 'package:flutter_cbt_app/data/models/responses/content_reponse_model.dart';

part 'content_bloc.freezed.dart';
part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRemoteDatasource contentRemoteDatasource;
  ContentBloc(
    this.contentRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetContentById>((event, emit) async {
      emit(const _Loading());
      final response = await contentRemoteDatasource.getContentById(event.id);
      response.fold(
        (l) => emit(_Error(l)), 
        (r) => emit(_Success(r)),
      );
    });
  }
}
