import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order_history/presentation/widget/order_history_item_widget.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        // final addressCheckoutBloc = context.read<OrderHistoryBloc>();
        // addressCheckoutBloc.add(OrderHistoryLoadData());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(title: const Text("History Order"), leading: Container()),
      body: RefreshIndicator(
        onRefresh: () async {
        context.read<OrderHistoryBloc>().add(OrderHistoryLoadData());
        },
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(),
                ),
              );
            }
      
            if (state.isError) {
              return Center(
                child: Text((state as OrderHistoryError).message),
              );
            }
      
            if (state is OrderHistoryLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    (appBarHeight + statusBarHeight),
                child: ListView.builder(
                  itemCount: state.listOrderHistory.length,
                  itemBuilder: (context, index) {
                    return OrderHistoryItemWidget(
                      orderHistoryEntity: state.listOrderHistory[index],
                      isFirst: index == 0,
                    );
                  },
                ),
              );
            }
      
            return Container();
          },
        ),
      ),
    );
  }
}
