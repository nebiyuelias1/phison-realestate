import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/models/payment_schedule.dart';
import 'package:phison_realestate_mobile/api/payment_schedule/payment_schedule_api_client.dart';
import 'package:phison_realestate_mobile/api/property/models/property.dart';
import 'package:phison_realestate_mobile/pages/payments/cubit/exchange_rate_cubit.dart';
import 'package:phison_realestate_mobile/repositories/payment_schedule_repository/payment_schedule_query_param.dart';
import 'package:phison_realestate_mobile/repositories/payment_schedule_repository/payment_schedule_repository.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:intl/intl.dart' as intl;

import '../../../generated/l10n.dart';
import '../../../shared/constants/app_assets_constant.dart';
import '../../../shared/utils/format_money.dart';
import '../../../shared/widgets/error_message.dart';
import '../../app/bloc/bloc/app_bloc.dart';
import '../../core/bloc/items_bloc.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final PagingController<String?, PaymentSchedule> _pagingController =
      PagingController(firstPageKey: null);
  late final ItemsBloc<PaymentSchedule, PaymentScheduleQueryParam> _itemsBloc;
  late final ExchangeRateCubit _exchangeRateCubit;

  @override
  void initState() {
    super.initState();
    final token = context.read<AppBloc>().state.authToken;
    final paymentScheduleRepository = PaymentScheduleRepository(
      client: PaymentScheduleApiClient.create(authToken: token),
    );

    _itemsBloc = ItemsBloc<PaymentSchedule, PaymentScheduleQueryParam>(
        paymentScheduleRepository);

    _exchangeRateCubit = ExchangeRateCubit(paymentScheduleRepository)
      ..getExchangeRate();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(String? pageKey) async {
    _itemsBloc.add(
      FetchNextPageRequested<PaymentScheduleQueryParam>(
        param: PaymentScheduleQueryParam(
          after: pageKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: S.of(context).payments,
        hideLeading: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _itemsBloc),
          BlocProvider(create: (_) => _exchangeRateCubit),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ItemsBloc<PaymentSchedule, PaymentScheduleQueryParam>,
                ItemsState<PaymentSchedule>>(
              listener: (context, state) {
                if (state.status.isSubmissionSuccess) {
                  final isLastPage = !state.hasNextPage;
                  isLastPage
                      ? _pagingController.appendLastPage(state.items)
                      : _pagingController.appendPage(
                          state.items, state.endCursor);
                } else if (state.status.isSubmissionFailure) {
                  _pagingController.error = state.error;
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
              builder: (context, state) {
                return PagedListView<String?, PaymentSchedule>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PaymentSchedule>(
                    itemBuilder: (context, item, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _PaymentItem(
                        paymentSchedule: item,
                        usdToEtbRate: state.usdToEtbRate,
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (context) =>
                        ErrorMessage(error: _pagingController.error),
                    firstPageErrorIndicatorBuilder: (context) =>
                        ErrorMessage(error: _pagingController.error),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  final PaymentSchedule paymentSchedule;
  final double? usdToEtbRate;

  const _PaymentItem({
    required this.paymentSchedule,
    this.usdToEtbRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: paymentSchedule.property.propertyImage == null
                    ? Image.asset(
                        'assets/images/welcomeImage.png',
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        paymentSchedule.property.propertyImage!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentSchedule.title,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      paymentSchedule.property.name,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    Text(
                      paymentSchedule.property.propertyType ==
                              PropertyType.villa
                          ? S.of(context).villa
                          : S.of(context).apartment,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: paymentSchedule.status == PaymentScheduleStatus.pending
                      ? PhisonColors.orange.shade900
                      : Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  paymentSchedule.status == PaymentScheduleStatus.pending
                      ? S.of(context).pending
                      : S.of(context).completed,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            paymentSchedule.description,
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                intl.DateFormat.yMMMMd().format(paymentSchedule.deadline),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          text: 'Br ',
                        ),
                        TextSpan(
                          text: usdToEtbRate == null
                              ? '--'
                              : formatMoney(
                                  paymentSchedule.amount * usdToEtbRate!,
                                ),
                          style: TextStyle(
                            color: PhisonColors.purple.shade900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('(\$${formatMoney(paymentSchedule.amount)})'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
