import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/category_icons.dart';
import '../../core/utils/formatters.dart';
import '../../features/categories/domain/category.dart';
import '../../features/transactions/domain/app_transaction.dart';
import '../../features/transactions/domain/tx_type.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.tx, this.category});

  final AppTransaction tx;
  final Category? category;

  @override
  Widget build(BuildContext context) {
    final cat = category;
    final color = cat == null ? Colors.grey : Color(cat.colorValue);
    final isIncome = tx.type == TxType.income;
    final amountText =
        '${isIncome ? '+' : '-'} ${formatRupiah(tx.amount)}';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withAlpha(38),
        child: Icon(
          cat == null ? Icons.help_outline : iconFromKey(cat.iconKey),
          color: color,
        ),
      ),
      title: Text(cat?.name ?? 'Tanpa kategori'),
      subtitle: Text(
        tx.note == null || tx.note!.isEmpty
            ? formatDate(tx.date)
            : '${tx.note} • ${formatDate(tx.date)}',
      ),
      trailing: Text(
        amountText,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isIncome ? AppColors.income : AppColors.expense,
        ),
      ),
    );
  }
}
