import java.util.Calendar;
import joons.JoonsRenderer;
import peasy.*;
PeasyCam cam;

JoonsRenderer jr;

int usagi = 2; //usagi type 1 or 2
int pwidth, pheight, maxWidth, centerX, centerY;
float dist;
int onePixelLeft;
ArrayList<Ball> balls = new ArrayList<Ball> ();
int ux, uy, uz, bwidth, bheight, bdepth;

void setup() {
  size(800, 800, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("bucket"); //レンダリングモード、"ipr"または"bucket"
  jr.setSizeMultiplier(1); //.pngファイルのサイズをprocessingスケッチサイズの倍数として設定します
  jr.setAA(0, 2, 4); //アンチエイリアスを設定します, (最小, 最大, サンプル). -2 < min, max < 2, samples = 1,2,3,4..
  jr.setCaustics(20); //コースティックスを設定します。 1〜100は、ガラスを通して散乱する光の品質に影響します。
  //jr.setDOF(90, 0.1); //カメラの被写界深度を設定します（焦点距離、レンズ半径）。半径が大きい=>ぼやけている。
  //被写界深度を有効にしないと、すべてがデフォルトでフォーカスされます。
  //bucketサンプラーを使用し、setAAのサンプルを変更してレンダリング品質を制御します。 
  //FocalDistance（焦点距離）はカメラから測定されます。
  //lensRadius（レンズ半径）を大きくすると（0.1、0.5、1、2、5、10など）、イメージがぼやけます。

  //peasy cam
  cam = new PeasyCam(this, 220); // カメラワーク操作オブジェクト。親オブジェクトと距離?を指定  
  cam.rotateX(-HALF_PI);

  //うさぎの位置(ux, uy, uz)、うさぎのスケール(us)
  if (usagi == 1) {
    ux= 10;
    uy= 0; 
    uz= -50;
    bwidth = 200; //cornell_box
    bheight = 200;
    bdepth = 250;
  } else if (usagi == 2) {
    ux =0;
    uy = 30;
    uz = -50;
    bwidth = 350; //cornell_box
    bheight = 350;
    bdepth = 350;
  }

  setUsagi();
}

void draw() {
  jr.beginRecord(); //Make sure to include things you want rendered.

  jr.background(0, 255, 255); //background(gray), or (r, g, b), like Processing.
  jr.background("gi_instant"); //Global illumination, normal mode.

  pushMatrix();
  translate(0, 0, -50);
  jr.background("cornell_box", bwidth, bheight, bdepth); //cornellBox(width, height, depth);
  popMatrix();

  pushMatrix();
  translate(-width/4, -height/4);
  translate(ux, uy, uz);

  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    ball.draw();
  }
  popMatrix();

  jr.endRecord(); //Make sure to end record.
  jr.displayRendered(true); //Display rendered image if render is completed, and the argument is true.
}

CameraState state;

void keyReleased() {
  if (key == 's' || key == 'S')saveFrame(timestamp()+"_####.jpg");
  if (key=='r'||key=='R') jr.render(); //Press 'r' key to start rendering.
  if (key == '1') state = cam.getState(); //カメラの位置を保存
  if (key == '2') cam.setState(state, 1000); //保存したカメラ位置に移動
  if (key == CODED) {
    if (keyCode == LEFT) {
      ux -= 10; //うさぎのx位置
    } else if (keyCode == RIGHT) {
      ux+=10;
    } else if (keyCode == UP) {
      uy -= 10; //うさぎのy位置
    } else if (keyCode == DOWN) {
      uy+=10;
    }
  }
  if (key == 'z') uz-=10; //うさぎのz位置
  if (key == 'x') uz+=10;
  println("ux= "+ux);
  println("uy=" +uy);
  println("uz=" +uz);
}

void setUsagi() {
  if (usagi == 1) {
    balls.add(new Ball(176, 236, 105, color(247, 207, 215, 255)));
    balls.add(new Ball(237, 170, 57, color(248, 208, 216, 255)));
    balls.add(new Ball(217, 128, 31, color(248, 208, 216, 255)));
    balls.add(new Ball(236, 211, 27, color(247, 207, 215, 255)));
    balls.add(new Ball(136, 283, 21, color(193, 202, 231, 255)));
    balls.add(new Ball(208, 289, 21, color(249, 208, 214, 255)));
    balls.add(new Ball(201, 179, 19, color(207, 237, 229, 255)));
    balls.add(new Ball(126, 268, 17, color(194, 203, 232, 255)));
    balls.add(new Ball(152, 291, 17, color(223, 206, 224, 255)));
    balls.add(new Ball(272, 169, 15, color(249, 255, 251, 255)));
    balls.add(new Ball(185, 179, 13, color(253, 255, 252, 255)));
    balls.add(new Ball(210, 190, 13, color(247, 227, 229, 255)));
    balls.add(new Ball(219, 198, 13, color(250, 225, 231, 255)));
    balls.add(new Ball(233, 229, 13, color(248, 207, 215, 255)));
    balls.add(new Ball(189, 292, 13, color(253, 255, 252, 255)));
    balls.add(new Ball(166, 293, 13, color(247, 207, 215, 255)));
    balls.add(new Ball(221, 106, 11, color(255, 255, 251, 255)));
    balls.add(new Ball(205, 110, 11, color(249, 208, 214, 255)));
    balls.add(new Ball(122, 253, 11, color(249, 208, 214, 255)));
    balls.add(new Ball(222, 292, 11, color(225, 207, 231, 255)));
    balls.add(new Ball(177, 293, 11, color(248, 208, 217, 255)));
    balls.add(new Ball(266, 158, 9, color(220, 241, 246, 255)));
    balls.add(new Ball(267, 179, 9, color(248, 208, 216, 255)));
    balls.add(new Ball(173, 180, 9, color(255, 255, 255, 255)));
    balls.add(new Ball(164, 182, 9, color(255, 255, 255, 255)));
    balls.add(new Ball(249, 199, 9, color(247, 207, 215, 255)));
    balls.add(new Ball(231, 238, 9, color(252, 255, 255, 255)));
    balls.add(new Ball(214, 276, 9, color(248, 225, 231, 255)));
    balls.add(new Ball(226, 112, 7, color(248, 208, 216, 255)));
    balls.add(new Ball(203, 117, 7, color(218, 243, 247, 255)));
    balls.add(new Ball(231, 139, 7, color(249, 226, 232, 255)));
    balls.add(new Ball(214, 145, 7, color(248, 208, 216, 255)));
    balls.add(new Ball(220, 145, 7, color(250, 207, 216, 255)));
    balls.add(new Ball(259, 149, 7, color(254, 255, 255, 255)));
    balls.add(new Ball(158, 184, 7, color(236, 228, 239, 255)));
    balls.add(new Ball(241, 226, 7, color(248, 208, 216, 255)));
    balls.add(new Ball(122, 243, 7, color(223, 238, 243, 255)));
    balls.add(new Ball(196, 287, 7, color(248, 208, 216, 255)));
    balls.add(new Ball(142, 294, 7, color(193, 204, 232, 255)));
    balls.add(new Ball(197, 295, 7, color(248, 208, 216, 255)));
    balls.add(new Ball(211, 112, 5, color(247, 207, 215, 255)));
    balls.add(new Ball(219, 112, 5, color(248, 217, 223, 255)));
    balls.add(new Ball(208, 142, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(226, 142, 5, color(248, 225, 231, 255)));
    balls.add(new Ball(254, 146, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(263, 152, 5, color(255, 255, 253, 255)));
    balls.add(new Ball(207, 168, 5, color(250, 207, 214, 255)));
    balls.add(new Ball(274, 177, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(178, 182, 5, color(253, 253, 253, 255)));
    balls.add(new Ball(191, 184, 5, color(249, 208, 216, 255)));
    balls.add(new Ball(153, 187, 5, color(255, 255, 253, 255)));
    balls.add(new Ball(253, 195, 5, color(254, 229, 145, 255)));
    balls.add(new Ball(227, 198, 5, color(249, 208, 216, 255)));
    balls.add(new Ball(251, 204, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(221, 205, 5, color(248, 225, 231, 255)));
    balls.add(new Ball(250, 208, 5, color(249, 208, 214, 255)));
    balls.add(new Ball(250, 213, 5, color(194, 203, 232, 255)));
    balls.add(new Ball(228, 223, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(123, 234, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(122, 238, 5, color(245, 208, 215, 255)));
    balls.add(new Ball(229, 243, 5, color(248, 207, 215, 255)));
    balls.add(new Ball(120, 247, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(127, 258, 5, color(194, 203, 232, 255)));
    balls.add(new Ball(119, 259, 5, color(249, 208, 214, 255)));
    balls.add(new Ball(135, 271, 5, color(194, 203, 232, 255)));
    balls.add(new Ball(123, 277, 5, color(194, 206, 230, 255)));
    balls.add(new Ball(125, 280, 5, color(221, 240, 246, 255)));
    balls.add(new Ball(147, 281, 5, color(194, 204, 231, 255)));
    balls.add(new Ball(136, 295, 5, color(194, 203, 232, 255)));
    balls.add(new Ball(183, 297, 5, color(252, 230, 233, 255)));
    balls.add(new Ball(159, 298, 5, color(247, 207, 215, 255)));
  } else if (usagi == 2) {
    balls.add(new Ball(139, 205, 67, color(255, 255, 253, 255)));
    balls.add(new Ball(219, 198, 65, color(248, 225, 231, 255)));
    balls.add(new Ball(271, 214, 47, color(248, 208, 216, 255)));
    balls.add(new Ball(103, 171, 35, color(249, 224, 230, 255)));
    balls.add(new Ball(124, 146, 31, color(250, 207, 214, 255)));
    balls.add(new Ball(85, 193, 25, color(250, 225, 231, 255)));
    balls.add(new Ball(181, 220, 25, color(192, 203, 231, 255)));
    balls.add(new Ball(178, 185, 23, color(226, 208, 232, 255)));
    balls.add(new Ball(301, 229, 23, color(254, 254, 254, 255)));
    balls.add(new Ball(295, 192, 21, color(249, 206, 215, 255)));
    balls.add(new Ball(104, 230, 21, color(255, 255, 255, 255)));
    balls.add(new Ball(112, 125, 19, color(194, 203, 232, 255)));
    balls.add(new Ball(345, 237, 19, color(245, 208, 215, 255)));
    balls.add(new Ball(256, 183, 17, color(194, 203, 232, 255)));
    balls.add(new Ball(319, 232, 17, color(248, 208, 216, 255)));
    balls.add(new Ball(80, 237, 17, color(248, 225, 231, 255)));
    balls.add(new Ball(137, 125, 15, color(194, 204, 231, 255)));
    balls.add(new Ball(99, 205, 15, color(254, 234, 122, 255)));
    balls.add(new Ball(296, 246, 15, color(255, 255, 255, 255)));
    balls.add(new Ball(125, 167, 13, color(248, 209, 214, 255)));
    balls.add(new Ball(181, 201, 13, color(248, 208, 217, 255)));
    balls.add(new Ball(299, 207, 13, color(249, 208, 214, 255)));
    balls.add(new Ball(244, 226, 13, color(247, 208, 213, 255)));
    balls.add(new Ball(167, 231, 13, color(252, 255, 255, 255)));
    balls.add(new Ball(286, 238, 13, color(255, 255, 255, 255)));
    balls.add(new Ball(102, 193, 11, color(203, 210, 236, 255)));
    balls.add(new Ball(196, 227, 11, color(219, 236, 230, 255)));
    balls.add(new Ball(332, 232, 11, color(225, 207, 231, 255)));
    balls.add(new Ball(139, 135, 9, color(250, 207, 214, 255)));
    balls.add(new Ball(194, 173, 9, color(224, 206, 232, 255)));
    balls.add(new Ball(244, 173, 9, color(250, 209, 215, 255)));
    balls.add(new Ball(83, 176, 9, color(254, 255, 253, 255)));
    balls.add(new Ball(267, 186, 9, color(194, 203, 232, 255)));
    balls.add(new Ball(254, 194, 9, color(197, 204, 232, 255)));
    balls.add(new Ball(90, 231, 9, color(250, 231, 235, 255)));
    balls.add(new Ball(117, 234, 9, color(255, 255, 255, 255)));
    balls.add(new Ball(358, 237, 9, color(248, 208, 216, 255)));
    balls.add(new Ball(92, 238, 9, color(247, 224, 232, 255)));
    balls.add(new Ball(109, 113, 7, color(194, 205, 235, 255)));
    balls.add(new Ball(107, 136, 7, color(197, 203, 229, 255)));
    balls.add(new Ball(133, 170, 7, color(221, 242, 247, 255)));
    balls.add(new Ball(187, 175, 7, color(249, 208, 214, 255)));
    balls.add(new Ball(163, 179, 7, color(225, 207, 231, 255)));
    balls.add(new Ball(273, 189, 7, color(248, 207, 215, 255)));
    balls.add(new Ball(306, 198, 7, color(247, 207, 215, 255)));
    balls.add(new Ball(174, 207, 7, color(254, 255, 255, 255)));
    balls.add(new Ball(297, 215, 7, color(253, 255, 252, 255)));
    balls.add(new Ball(236, 228, 7, color(248, 208, 216, 255)));
    balls.add(new Ball(203, 229, 7, color(207, 237, 229, 255)));
    balls.add(new Ball(251, 231, 7, color(254, 255, 253, 255)));
    balls.add(new Ball(159, 234, 7, color(252, 255, 251, 255)));
    balls.add(new Ball(255, 235, 7, color(250, 223, 230, 255)));
    balls.add(new Ball(123, 237, 7, color(225, 207, 229, 255)));
    balls.add(new Ball(327, 239, 7, color(250, 209, 215, 255)));
    balls.add(new Ball(334, 239, 7, color(248, 208, 216, 255)));
    balls.add(new Ball(305, 244, 7, color(255, 235, 123, 255)));
    balls.add(new Ball(305, 250, 7, color(252, 253, 255, 255)));
    balls.add(new Ball(129, 127, 5, color(221, 242, 247, 255)));
    balls.add(new Ball(127, 130, 5, color(194, 203, 232, 255)));
    balls.add(new Ball(131, 131, 5, color(191, 203, 229, 255)));
    balls.add(new Ball(143, 131, 5, color(224, 205, 224, 255)));
    balls.add(new Ball(141, 140, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(108, 141, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(140, 144, 5, color(249, 208, 214, 255)));
    balls.add(new Ball(107, 152, 5, color(248, 205, 212, 255)));
    balls.add(new Ball(131, 161, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(232, 167, 5, color(254, 255, 253, 255)));
    balls.add(new Ball(236, 169, 5, color(246, 210, 214, 255)));
    balls.add(new Ball(199, 170, 5, color(249, 208, 216, 255)));
    balls.add(new Ball(239, 171, 5, color(249, 208, 216, 255)));
    balls.add(new Ball(250, 173, 5, color(194, 203, 232, 255)));
    balls.add(new Ball(121, 174, 5, color(249, 208, 216, 255)));
    balls.add(new Ball(248, 177, 5, color(197, 204, 232, 255)));
    balls.add(new Ball(191, 178, 5, color(249, 208, 214, 255)));
    balls.add(new Ball(79, 180, 5, color(255, 255, 255, 255)));
    balls.add(new Ball(166, 183, 5, color(225, 207, 231, 255)));
    balls.add(new Ball(108, 189, 5, color(249, 224, 228, 255)));
    balls.add(new Ball(263, 190, 5, color(197, 204, 233, 255)));
    balls.add(new Ball(259, 192, 5, color(194, 203, 232, 255)));
    balls.add(new Ball(307, 193, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(186, 195, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(173, 197, 5, color(249, 208, 212, 255)));
    balls.add(new Ball(105, 199, 5, color(236, 241, 247, 255)));
    balls.add(new Ball(173, 201, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(306, 203, 5, color(255, 234, 125, 255)));
    balls.add(new Ball(186, 207, 5, color(248, 207, 213, 255)));
    balls.add(new Ball(105, 211, 5, color(254, 255, 255, 255)));
    balls.add(new Ball(247, 217, 5, color(251, 224, 229, 255)));
    balls.add(new Ball(106, 218, 5, color(255, 255, 255, 255)));
    balls.add(new Ball(313, 224, 5, color(248, 221, 226, 255)));
    balls.add(new Ball(327, 227, 5, color(248, 208, 216, 255)));
    balls.add(new Ball(190, 230, 5, color(246, 210, 214, 255)));
    balls.add(new Ball(208, 230, 5, color(245, 208, 216, 255)));
    balls.add(new Ball(353, 230, 5, color(249, 208, 212, 255)));
    balls.add(new Ball(289, 231, 5, color(192, 202, 229, 255)));
    balls.add(new Ball(175, 232, 5, color(254, 255, 255, 255)));
    balls.add(new Ball(356, 232, 5, color(248, 207, 213, 255)));
    balls.add(new Ball(154, 236, 5, color(255, 255, 255, 255)));
    balls.add(new Ball(260, 236, 5, color(254, 255, 253, 255)));
    balls.add(new Ball(311, 237, 5, color(255, 255, 255, 255)));
    balls.add(new Ball(113, 238, 5, color(255, 255, 255, 255)));
    balls.add(new Ball(128, 238, 5, color(222, 209, 227, 255)));
    balls.add(new Ball(275, 238, 5, color(222, 241, 247, 255)));
    balls.add(new Ball(71, 239, 5, color(254, 255, 255, 255)));
    balls.add(new Ball(119, 239, 5, color(255, 255, 255, 255)));
    balls.add(new Ball(355, 242, 5, color(248, 209, 214, 255)));
    balls.add(new Ball(72, 243, 5, color(254, 255, 253, 255)));
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
