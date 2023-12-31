import 'package:http_interceptor/http_interceptor.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';
import '../modal/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModelDatum>> getProducts({String? searchNameProduct});
}

class ProductRemoteDataSourceImpl extends RemoteDataRequest
    implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<List<ProductModelDatum>> getProducts({String? searchNameProduct}) async {
    try {
      final getProductResult = await getRequest<List<ProductModelDatum>>(
        '/api/products',
        queryParameters: {
          'populate[sub_item_type][populate]': '*',
          'populate[source_item]': '*',
          'populate[images]': '*',
          if (searchNameProduct != null) 'filters[product_name][\$contains]': searchNameProduct
        },
        fromMap: (e) {
          final getData = e['data'];
          if (getData is List) {
            final listResut = getData.map(ProductModelDatum.fromJson).toList();
            return listResut;
          }
          return [];
        },
      );

      return getProductResult;
    } on HttpException {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownException(
        'Occure in Product Remote Data Source : ${e.toString()}',
        stackTrace,
      );
    }
  }
}
