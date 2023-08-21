class OrderHistoryEntity {
    final int id;
    final List<Item> items;
    final int totalPrice;
    final String deliveryAddress;
    final String courierName;
    final int shippingCost;
    final String orderStatus;
    final String urlPayment;

    OrderHistoryEntity({
        required this.id,
        required this.items,
        required this.totalPrice,
        required this.deliveryAddress,
        required this.courierName,
        required this.shippingCost,
        required this.orderStatus,
        required this.urlPayment,
    });

    OrderHistoryEntity copyWith({
        int? id,
        List<Item>? items,
        int? totalPrice,
        String? deliveryAddress,
        String? courierName,
        int? shippingCost,
        String? orderStatus,
        String? urlPayment,
    }) => 
        OrderHistoryEntity(
            id: id ?? this.id,
            items: items ?? this.items,
            totalPrice: totalPrice ?? this.totalPrice,
            deliveryAddress: deliveryAddress ?? this.deliveryAddress,
            courierName: courierName ?? this.courierName,
            shippingCost: shippingCost ?? this.shippingCost,
            orderStatus: orderStatus ?? this.orderStatus,
            urlPayment: urlPayment ?? this.urlPayment,
        );
}

class Item {
    final String productName;
    final int price;
    final int qty;

    Item({
        required this.productName,
        required this.price,
        required this.qty,
    });

    Item copyWith({
        String? productName,
        int? price,
        int? qty,
    }) => 
        Item(
            productName: productName ?? this.productName,
            price: price ?? this.price,
            qty: qty ?? this.qty,
        );
}