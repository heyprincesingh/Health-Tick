import 'package:healthtick/controller/counterScreenController/counterScreenController.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthtick/models/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class counterScreen extends StatefulWidget {
  const counterScreen({super.key});

  @override
  State<counterScreen> createState() => _counterScreenState();
}

class _counterScreenState extends State<counterScreen> {
  final int _duration = 30;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(counterScreenController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 2,
        shadowColor: secondaryColor.withOpacity(0.1),
        title: Text(
          "Mindful Meal timer",
          style: GoogleFonts.raleway(
            color: secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Nom nom :)",
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: MediaQuery.of(context).size.width * 0.075,
                ),
              ),
            ),
            Text(
              "You have 10 minutes to eat before the pause.\nFocus on eating slowly",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: highlightColor,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Stack(
                children: [
                  CircleAvatar(
                      backgroundColor: highlightColor,
                      radius: (MediaQuery.of(context).size.width - 50) / 2),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius:
                              (MediaQuery.of(context).size.width - 110) / 2),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularCountDownTimer(
                        duration: _duration,
                        initialDuration: 0,
                        controller: _controller,
                        width: MediaQuery.of(context).size.width - 150,
                        height: MediaQuery.of(context).size.width - 150,
                        ringColor: Colors.white,
                        fillColor: primaryColor,
                        backgroundColor: secondaryColor,
                        strokeWidth: 8,
                        strokeCap: StrokeCap.square,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textFormat: CountdownTextFormat.MM_SS,
                        isReverse: true,
                        isReverseAnimation: true,
                        isTimerTextShown: true,
                        autoStart: false,
                        onStart: () {
                          print("started");
                        },
                        onComplete: () {
                          controller.isCompleted.value = true;
                          controller.isStarted.value = false;
                        },
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {
                            controller.audioPlayer.pause();
                            return "Completed";
                          } else {
                            if(duration.inSeconds < 6 && controller.isSoundOn.value){
                              controller.audioPlayer.setSpeed(0.3);
                               controller.audioPlayer.play();
                            }
                            return "${Function.apply(defaultFormatterFunction, [
                                  duration
                                ])}\nminutes remaining";
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.audioPlayer.playing ? controller.audioPlayer.pause() : controller.audioPlayer.play();
                  controller.isSoundOn.value =! controller.isSoundOn.value;
                },
                child: AnimatedContainer(
                  alignment: controller.isSoundOn.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeIn,
                  height: 30,
                  width: 50,
                  decoration: BoxDecoration(
                    color: controller.isSoundOn.value
                        ? primaryColor
                        : Colors.white10,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: controller.isSoundOn.value
                                ? const Offset(-4, 0)
                                : const Offset(4, 0),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: controller.isSoundOn.value
                            ? secondaryColor
                            : Colors.white,
                        radius: 14,
                      ),
                    ),
                  ),
                ),
              );
            }),
            Obx(
              () {
                return Text(
                  controller.isSoundOn.value ? "Sound On" : "Sound off",
                  style: const TextStyle(
                    color: Colors.white,
                    height: 2,
                    fontSize: 16,
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                if (controller.isStarted.value) {
                  controller.audioPlayer.pause();
                  _controller.pause();
                } else if (_controller.isStarted && _controller.isPaused) {
                  _controller.resume();
                } else if (_controller.isStarted &&
                    _controller.isPaused &&
                    controller.isCompleted.value) {
                  _controller.restart();
                } else {
                  _controller.start();
                }
                controller.isStarted.value = !controller.isStarted.value;
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 65,
                decoration: BoxDecoration(
                  color: buttonBgColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 65,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Obx(() {
                        return Text(
                          controller.isStarted.value ? "PAUSE" : "START",
                          style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: controller.isStarted.value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.audioPlayer.pause();
                      controller.isStarted.value = false;
                      _controller.restart();
                      _controller.pause();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: highlightColor, width: 1)),
                      child: Center(
                        child: Text(
                          "LET'S STOP I'M FULL NOW",
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
