import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LockScreenContainer extends StatelessWidget {
  static final timeFormat = DateFormat('hh:mm');
  static final dateFormat = DateFormat('EEEE, dd MMMM');

  final IconData iconData;
  final VoidCallback onTap;
  final Widget? child;

  const LockScreenContainer(this.iconData, this.onTap, {super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now();

    return Column(
      children: [
        Text(
          timeFormat.format(dateTime),
          style: const TextStyle(fontSize: 50),
        ),
        const VerticalSpacing(of: 10),
        Text(
          dateFormat.format(dateTime),
          style: const TextStyle(fontSize: 20),
        ),
        child ?? const SizedBox(),
        const Spacer(),
        getAnimatedPaintWidget(iconData, onTap),
      ],
    );
  }

  static Widget getAnimatedPaintWidget(IconData iconData, VoidCallback onTap) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        final button = IconButton(
            icon: Icon(iconData),
            onPressed: onTap,
            color: Theme.of(context).colorScheme.primary);
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: snapshot.connectionState == ConnectionState.waiting ? 0 : 1,
          child: button,
        );
      },
    );
  }
}
