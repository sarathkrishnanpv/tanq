import 'package:flutter/material.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';

class TopSpacing extends StatelessWidget {
  const TopSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .07,
    );
  }
}

class Halfh extends StatelessWidget {
  const Halfh({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .005,
    );
  }
}

class Oneh extends StatelessWidget {
  const Oneh({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .01,
    );
  }
}

class Twoh extends StatelessWidget {
  const Twoh({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .02,
    );
  }
}

class Threeh extends StatelessWidget {
  const Threeh({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .03,
    );
  }
}

class Fiveh extends StatelessWidget {
  const Fiveh({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .05,
    );
  }
}

class Sevenh extends StatelessWidget {
  const Sevenh({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .07,
    );
  }
}

class Onew extends StatelessWidget {
  const Onew({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .01,
    );
  }
}

class Twow extends StatelessWidget {
  const Twow({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .02,
    );
  }
}

class Threew extends StatelessWidget {
  const Threew({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .03,
    );
  }
}

class Fivew extends StatelessWidget {
  const Fivew({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .05,
    );
  }
}

class WhiteLine extends StatelessWidget {
  const WhiteLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 2,
      child: Divider(color: AppColors.black.withOpacity(.6)),
    );
  }
}

class LightWhiteLine extends StatelessWidget {
  const LightWhiteLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 2,
      child: Divider(color: AppColors.black.withOpacity(.2)),
    );
  }
}

void openModelSheet(
    {required BuildContext context,
    required Widget Function(BuildContext) builder}) {
  showModalBottomSheet(
    isDismissible: true,
    enableDrag: true,
    backgroundColor: AppColors.backgroundColor,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjust for keyboard height
            ),
            child: builder(context),
          ),
        ],
      );
    },
  );
}
