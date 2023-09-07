import 'package:flutter_fic_ecommerce_warung_comicon/feature/address/data/model/address_model.dart';
import 'package:http_interceptor/http/intercepted_http.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getListAddress();
  Future<AddressModel?> getChoosedAddress();
}

class AddressRemoteDataSourceImpl extends RemoteDataRequest
    implements AddressRemoteDataSource {
  AddressRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<List<AddressModel>> getListAddress() async {
    try {
      final addressResult = await getRequest<List<AddressModel>>(
        '/api/addresshes',
        queryParameters: {
          'populate':'*'
        },
        fromMap: (e) {
          final getData = e['data'];
          if (getData is List) {
            final listResut = getData.map(AddressModel.fromJson).toList();
            return listResut;
          }
          return [];
        },
      );
      return addressResult;
    } on HttpException {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownException(
        'Occure in Address Remote Data Source(getListAddress) : ${e.toString()}',
        stackTrace,
      );
    }
  }
  
  @override
  Future<AddressModel?> getChoosedAddress() async {
    try {
      final addressResult = await getRequest<AddressModel?>(
        '/api/addresshes/choosed-address',
        fromMap: (e) {
          final result = e["data"];
          if (result is List && result.isNotEmpty) {
            final listResut = AddressModel.fromJson(result.first);
            return listResut;
          }
          return null;
        },
      );
      return addressResult;
    } on HttpException {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownException(
        'Occure in Address Remote Data Source(getChoosedAddress) : ${e.toString()}',
        stackTrace,
      );
    }
  }
}
