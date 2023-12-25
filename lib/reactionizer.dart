library reactionizer;

import 'package:flutter/material.dart';

class ReactionGenerator extends StatefulWidget {
  const ReactionGenerator({
    super.key,
    required this.onChange,
    required this.reactions,
    required this.placeHolder, this.defaultValue, this.iconHeight, this.iconWidth,
  });

  final Function(int id) onChange;
  final List<ReactionModel> reactions;
  final ReactionModel placeHolder;
  final int? defaultValue;
  final double? iconHeight;
  final double? iconWidth;

  @override
  State<StatefulWidget> createState() => ReactionGeneratorState();
}

class ReactionGeneratorState extends State<ReactionGenerator> with  SingleTickerProviderStateMixin {

  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();
  bool _checked = false;
  int? initialValue;
  final List<Interval> _itemSlideIntervals = [];
  late AnimationController _staggeredController;
  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  Duration?  _animationDuration;

  void _createAnimationIntervals() {
    // Calculate the maximum duration for all staggered animations
    final maxDuration = _staggerTime * widget.reactions.length;

    // Calculate the animation duration ensuring it doesn't exceed 1.0
    _animationDuration = maxDuration < const Duration(seconds: 1) ? maxDuration : const Duration(seconds: 1);

    for (var i = 0; i < widget.reactions.length; ++i) {
      // Adjust the start time to start from index 0 and increase progressively
      final startTime = _initialDelayTime + (_staggerTime * i);

      final endTime = startTime + _itemSlideTime;

      // Ensure the start and end times are within the valid range [0.0, 1.0]
      final adjustedStartTime = startTime.inMilliseconds / _animationDuration!.inMilliseconds;
      final adjustedEndTime = endTime.inMilliseconds / _animationDuration!.inMilliseconds;

      // Ensure the adjusted times are capped at 1.0
      final cappedStartTime = adjustedStartTime.clamp(0.0, 1.0);
      final cappedEndTime = adjustedEndTime.clamp(0.0, 1.0);

      _itemSlideIntervals.add(
        Interval(
          cappedStartTime,
          cappedEndTime,
        ),
      );
    }
  }
  @override
  void initState() {

    _animationDuration = _initialDelayTime +
        (_staggerTime * widget.reactions.length);
    _staggeredController = AnimationController(
        vsync: this,
        duration: _animationDuration
    );


    if(widget.defaultValue!=null){

      initialValue  = widget.defaultValue;
      if(initialValue==widget.placeHolder.id){
        _checked = false;
      }
      else {
        _checked = true;
      }
    }
    else{
      initialValue  = widget.placeHolder.id;
    }

    _createAnimationIntervals();
    super.initState();
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
          controller: _tooltipController,
          overlayChildBuilder: (BuildContext context) {
            return CompositedTransformFollower(
              link: _link,
              targetAnchor: const Alignment(-1, -4.751),
              child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.5,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemCount: widget.reactions.length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (context, index) {
                              return AnimatedBuilder(
                                animation: _staggeredController,
                                builder: (context,child){
                                  final animationPercent = Curves.easeOut.transform(
                                    _itemSlideIntervals[index].transform(_staggeredController.value),
                                  );
                                  final opacity = animationPercent;
                                  // final slideDistance =(1- animationPercent) * 150;
                                  final scale = 0.5 + (0.5 * animationPercent);
                                  return Opacity(
                                    opacity: opacity,
                                    child: Transform.scale(
                                      scale: scale,
                                      child: child,
                                    ),
                                  );
                                },
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        _tooltipController.hide();
                                        initialValue = widget.reactions[index].id;
                                        widget
                                            .onChange(widget.reactions[index].id);
                                        _checked = true;
                                        setState(() {});
                                      },
                                      child: Image.asset(
                                          widget.reactions[index].image)),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 0,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            );
          },
          child: GestureDetector(
              onTap: () {
                _checked = !_checked;
                if (!_checked) {
                  _tooltipController.hide();
                  initialValue = widget.placeHolder.id;
                  widget.onChange(widget.placeHolder.id);
                } else {
                  initialValue = widget.reactions.first.id;
                  widget.onChange(widget.reactions.first.id);
                }
                setState(() {});
              },
              onLongPress: onTap,
              child: Image.asset(
                initialValue != widget.placeHolder.id
                    ? widget.reactions
                    .firstWhere((book) => book.id == initialValue)
                    .image
                    : widget.placeHolder.image,
                height: widget.iconHeight?? 30,
                width: widget.iconWidth?? 30,
              ))),
    );
  }

  void onTap() {
    _staggeredController.reset();
    _staggeredController.forward();
    _tooltipController.toggle();
  }
}

class ReactionModel {
  String image;
  int id;

  ReactionModel({required this.image, required this.id});
}
