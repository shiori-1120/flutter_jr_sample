import 'package:flutter/material.dart';
import 'package:flutter_jr_sample/constants/app_style.dart';
import 'package:gap/gap.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    required this.titleText,
    required this.valueText,
    required this.iconSection,
    required this.onTap,
    super.key,
  });

  final String titleText;
  final String valueText;
  final IconData iconSection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: AppStyle.headingOne,
            ),
            const Gap(6),
            Material(
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(iconSection),
                        const Gap(6),
                        Text(valueText),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
