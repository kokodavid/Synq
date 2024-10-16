import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synq/helpers/utils/strings.dart';

class CheckItem extends StatelessWidget {
  const CheckItem({
    super.key,
  });

  @override
   Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.circleCheck,
          color: Colors.green,
        ),
        const SizedBox(width: 5,),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              Strings.needAccountItem1,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}