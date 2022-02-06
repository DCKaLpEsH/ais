import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_india_stocks/bloc/block_data/block_data_bloc.dart';
import 'package:gold_india_stocks/bloc/bulk_data/bulk_data_bloc.dart';
import 'package:gold_india_stocks/common/constants.dart';
import 'package:gold_india_stocks/data/data_provider/data_provider.dart';
import 'package:gold_india_stocks/data/repository/get_deal_repository.dart';
import 'package:http/http.dart' as http;
import 'tabs/block_deal_widget.dart';
import 'tabs/bulk_deal_widget.dart';

class DealsTabView extends StatefulWidget {
  const DealsTabView({Key? key}) : super(key: key);

  @override
  _DealsTabViewState createState() => _DealsTabViewState();
}

class _DealsTabViewState extends State<DealsTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late BulkDataBloc bulkBloc;
  late BlockDataBloc blockBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    bulkBloc = BulkDataBloc(
      GetDealRepositoryImpl(
        dataProvider: DataProvider(
          http.Client(),
        ),
      ),
    );
    blockBloc = BlockDataBloc(
      GetDealRepositoryImpl(
        dataProvider: DataProvider(
          http.Client(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => bulkBloc,
          ),
          BlocProvider(
            create: (context) => blockBloc,
          ),
        ],
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
              width,
              height * 0.1,
            ),
            child: SizedBox(
              height: height * 0.08,
              width: width,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Constants.orange,
                unselectedLabelColor: Constants.blue.withOpacity(0.3),
                tabs: [
                  Text(
                    "Bulk Deal",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    "Block Deal",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              BulkDealWidget(),
              const BlockDealWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
