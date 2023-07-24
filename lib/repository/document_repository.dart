import 'dart:convert';

import 'package:collaborative_text_editor/models/document_model.dart';
import 'package:collaborative_text_editor/models/error_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../constants.dart';

final documentRepositoryProvider = Provider((ref) {
  return DocumentRepository(
    client: Client(),
  );
});
final userDocumentsProvider =
    FutureProvider.family<ErrorModel?, String>((ref, token) async {
  final documentRepository = ref.read(documentRepositoryProvider);
  return documentRepository.getDocuments(token);
});

class DocumentRepository {
  final Client _client;
  DocumentRepository({required Client client}) : _client = client;
  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error = ErrorModel(error: "some error", data: null);
    try {
      final res = await _client.post(
        Uri.parse('$host/doc/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode({
          'createdAt': DateTime.now().microsecondsSinceEpoch,
        }),
      );
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(res.body),
          );
          break;
        default:
          error = ErrorModel(
            error: res.body,
            data: null,
          );
          break;
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }

  Future<ErrorModel?> getDocuments(String token) async {
    ErrorModel error = ErrorModel(error: "some error", data: null);
    try {
      final res = await _client.get(
        Uri.parse('$host/docs/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
      switch (res.statusCode) {
        case 200:
          final List<DocumentModel> documents = [];
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            documents.add(
              DocumentModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
          error = ErrorModel(
            error: null,
            data: documents,
          );
          break;
        default:
          error = ErrorModel(
            error: res.body,
            data: null,
          );
          break;
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }
}
