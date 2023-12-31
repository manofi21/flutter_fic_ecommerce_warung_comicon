import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/home/presentation/widget/home_navigator_bar_widget.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/home/presentation/widget/home_page_view_widget.dart';

import '../../../order_history/presentation/bloc/order_history_bloc.dart';
import '../../../product/presentation/bloc/product_bloc.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => HomePageCubit(
        context.read<OrderHistoryBloc>(),
        context.read<ProductBloc>(),
      ),
      child: const HomeChild(),
    );
  }
}

class HomeChild extends StatefulWidget {
  const HomeChild({super.key});

  @override
  State<HomeChild> createState() => _HomeChildState();
}

class _HomeChildState extends State<HomeChild> {
  late HomePageCubit homePageCubit;

  @override
  void initState() {
    super.initState();
    homePageCubit = context.read<HomePageCubit>();
  }

  @override
  void dispose() {
    homePageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, index) {
        final homeBloc = context.watch<HomePageCubit>();
        return Scaffold(
          body: HomePageViweWidget(
            pageIndex: index,
          ),
          bottomNavigationBar: HomeNavigatorBarWidget(
            onTabClick: homeBloc.onChangePage,
            pageIndex: index,
          ),
        );
      },
    );
  }
}
