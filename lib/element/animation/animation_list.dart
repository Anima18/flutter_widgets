
import 'package:flutter/material.dart';
import 'package:flutter_widgets/element/animation/example/number_roll_card.dart';
import 'package:flutter_widgets/element/animation/example/steps_widget_animation.dart';

import 'animatedbuilder/system_explicit_animated_page.dart';
import 'animatedfoo/animated_foo.dart';
import 'animation/custom_animated_page2.dart';
import 'example/478_animation.dart';
import 'example/snowman_animated_page.dart';
import 'hero/hero_page.dart';

class CustomAnimatedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation List"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("内置隐式动画控件",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AnimationFooPage()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("自定义隐式动画",),
                onPressed: () {
                  Navigator.pushNamed(context, "animation_page");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("自定义隐式动画2",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AnimationPage2()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("内置显式动画",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ExplicitAnimationPage()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("自定义显式动画",),
                onPressed: () {
                  Navigator.pushNamed(context, "animated_widget");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("自定义显式动画2",),
                onPressed: () {
                  Navigator.pushNamed(context, "animated_builder");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("翻滚数字卡片",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NumberRollCard()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("交错动画",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>StepsAnimationPage()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("478呼吸动画",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BreatheAnimationPage()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("堆雪人动画",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SnowmanAnimatedPage()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("Hero",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HeroPage1()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}