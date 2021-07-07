import 'package:dio/dio.dart';

Future<Stream<String>> getAllGamesFrom(String name) async {
  final requester = Dio()..options.baseUrl = 'https://lichess.org/api/';
  final Response<ResponseBody> dataFlow = await requester.get(
      'games/user/$name?max=100',
      options: Options(responseType: ResponseType.stream));
  return dataFlow.data!.stream.map((x) => String.fromCharCodes(x));
}
