import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class BottomNavigationItem {
  const BottomNavigationItem({
    @required this.icon,
    this.title,
    Widget activeIcon,
  })  : activeIcon = activeIcon ?? icon,
        assert(icon != null);

  final Widget icon;
  final Widget activeIcon;
  final Widget title;
}

class BottomNavigationView extends StatefulWidget {
  BottomNavigationView({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.activeColor,
    this.backgroundColor,
    this.iconSize = 32.0,
  })  : assert(items != null),
        assert(items.length >= 2),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        super(key: key);

  final List<BottomNavigationItem> items;

  final ValueChanged<int> onTap;

  final int currentIndex;

  final Color activeColor;

  final Color backgroundColor;

  final double iconSize;

  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(
    this.item,
    this.title,
    this.animation,
    this.iconSize, {
    this.onTap,
    this.colorTween,
    this.selected = false,
    this.indexLabel,
  }) : assert(selected != null);

  final BottomNavigationItem item;
  final Widget title;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback onTap;
  final ColorTween colorTween;
  final bool selected;
  final String indexLabel;

  Widget _buildIcon() {
    Color iconColor = colorTween.evaluate(animation);

    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: Container(
//        margin: EdgeInsets.all((kBottomNavigationBarHeight - iconSize) / 2),
        margin: EdgeInsets.only(
          top: 10.0,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: iconSize,
          ),
          child: selected ? item.activeIcon : item.icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int size = 1;

    return Expanded(
      flex: size,
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        child: Stack(
          children: <Widget>[
            InkResponse(
              splashFactory: InkRipple.splashFactory,
              highlightColor: Colors.transparent,
              radius: 58.0,
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildIcon(),
                  title ?? Container(),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            Semantics(
              label: indexLabel,
            )
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationViewState extends State<BottomNavigationView>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  List<CurvedAnimation> _animations;

  void _resetState() {
    for (AnimationController controller in _controllers) controller.dispose();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {
      // Rebuilding when any of the controllers tick, i.e. when the items are
      // animated.
    });
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BottomNavigationView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // No animated segue if the length of the items list changes.
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  List<Widget> _createTiles() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    assert(localizations != null);
    final List<Widget> children = <Widget>[];
    final ThemeData themeData = Theme.of(context);
    Color themeColor;
    switch (themeData.brightness) {
      case Brightness.light:
        themeColor = themeData.primaryColor;
        break;
      case Brightness.dark:
        themeColor = themeData.accentColor;
        break;
    }
    final ColorTween colorTween = ColorTween(
      begin: Colors.black54,
      end: widget.activeColor ?? themeColor,
    );
    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(
        _BottomNavigationTile(
          widget.items[i],
          widget.items[i].title,
          _animations[i],
          widget.iconSize,
          onTap: () {
            if (widget.onTap != null) widget.onTap(i);
          },
          colorTween: colorTween,
          selected: i == widget.currentIndex,
          indexLabel: localizations.tabLabel(
              tabIndex: i + 1, tabCount: widget.items.length),
        ),
      );
    }
    return children;
  }

  Widget _createContainer(List<Widget> tiles) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));

    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Material(
              // Casts shadow.
              elevation: 16.0,
              color: widget.backgroundColor,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: kBottomNavigationBarHeight),
            child: Material(
              // Splashes.
              type: MaterialType.transparency,
              child: _createContainer(_createTiles()),
            ),
          ),
        ],
      ),
    );
  }
}
