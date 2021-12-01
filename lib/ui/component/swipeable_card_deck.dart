import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

typedef SwipeHandler = void Function(AxisDirection direction, Card card);
typedef CardBuilder = Card Function();

/// Based on https://github.com/jushutch/swiping_card_deck
class SwipeableCardDeck extends StatefulWidget {
  final CardBuilder _cardBuilder;
  final SwipeHandler _swipeHandler;
  final double? _swipeThreshold;
  final double _minVelocity;
  final double? _cardWidth;

  const SwipeableCardDeck(
      {Key? key,
      required CardBuilder cardBuilder,
      required SwipeHandler swipeHandler,
      double minVelocity = 1000,
      double? swipeThreshold,
      double? cardWidth})
      : assert(cardWidth == null || cardWidth > 1),
        _cardBuilder = cardBuilder,
        _swipeHandler = swipeHandler,
        _minVelocity = minVelocity,
        _swipeThreshold = swipeThreshold,
        _cardWidth = cardWidth,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SwipeableCardDeckState();
}

class _SwipeableCardDeckState extends State<SwipeableCardDeck>
    with TickerProviderStateMixin {
  final Queue<Card> _cards = Queue();

  late Size _screenSize;
  late double _cardWidth;
  late double _swipeThreshold;

  late final AnimationController _springController;
  late Animation<Alignment> _springAnimation;

  late final AnimationController _swipeController;
  late Animation<Alignment> _swipeAnimation;

  Alignment _dragAlignment = Alignment.center;
  bool _animationActive = false;

  @override
  void initState() {
    super.initState();

    _springController = AnimationController(vsync: this);
    _springController.addListener(() {
      setState(() {
        _dragAlignment = _springAnimation.value;
      });
    });

    _swipeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _swipeController.addListener(() {
      setState(() {
        _dragAlignment = _swipeAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _springController.dispose();
    _swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _cardWidth = widget._cardWidth ?? _screenSize.width * 0.8;
    _swipeThreshold = widget._swipeThreshold ?? _screenSize.width / 4;

    int cardsToCreate = 2 - _cards.length;
    for (int i = 0; i < cardsToCreate; i++) {
      _cards.addFirst(widget._cardBuilder());
    }

    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          _dragAlignment += Alignment(
              details.delta.dx * 20 / MediaQuery.of(context).size.width,
              details.delta.dy * 30 / MediaQuery.of(context).size.height);
        });
      },
      onPanStart: (DragStartDetails details) async {
        if (_animationActive) {
          _springController.stop();
        }
      },
      onPanEnd: (DragEndDetails details) async {
        double vx = details.velocity.pixelsPerSecond.dx;

        final minVelocity = widget._minVelocity;
        final x = _dragAlignment.x;
        log('vs: $vx, minVelocity: $minVelocity, x: $x, swipeThreshold: $_swipeThreshold');

        if (vx >= widget._minVelocity || _dragAlignment.x >= _swipeThreshold) {
          await _swipeCard(AxisDirection.right);
        } else if (vx <= -widget._minVelocity ||
            _dragAlignment.x <= -_swipeThreshold) {
          await _swipeCard(AxisDirection.left);
        } else {
          animateBackToDeck(details.velocity.pixelsPerSecond, _screenSize);
        }
        setState(() {
          _dragAlignment = Alignment.center;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: _getCards(),
      ),
    );
  }

  List<Widget> _getCards() {
    List<Widget> cards = [];
    var lastCard = _cards.last;
    _cards.removeLast();
    cards.addAll(_cards);
    cards.add(Align(alignment: _dragAlignment, child: lastCard));
    _cards.add(lastCard);
    return cards;
  }

  Future<void> _swipeCard(AxisDirection direction) async {
    if (_animationActive) return;

    double swipeEnd = _screenSize.width / 2 + _cardWidth;
    _swipeAnimation = AlignmentTween(
      begin: _dragAlignment,
      end: Alignment(direction == AxisDirection.left ? -swipeEnd : swipeEnd,
          _dragAlignment.x),
    ).animate(
      CurvedAnimation(
        parent: _swipeController,
        curve: Curves.ease,
      ),
    );
    _animationActive = true;
    await _swipeController.forward();
    _swipeController.reset();
    _animationActive = false;

    widget._swipeHandler(direction, _cards.last);
    _cards.removeLast();
  }

  void animateBackToDeck(Offset pixelsPerSecond, Size size) async {
    _springAnimation = _springController.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const springProps = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(springProps, 0, 1, -unitVelocity);
    _animationActive = true;
    await _springController.animateWith(simulation);
    _animationActive = false;
  }
}
