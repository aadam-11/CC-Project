int[][] timeTaken = {
  {1, 12, 17, 10, 3}, {1, 2, 5, 5}, {2, 7, 12, 15}, {5, 15, 20}
};

String[] locations = {"Kitchen", "Bedroom", "Living Room", "Outside"};
int barWidth = 40;
int margin = 100;
int maxBarHeight = 300;
int maxTime = 35;
int groupSpacing = 100;

color kitchenColor = color(255, 0, 0);
color livingRoomColor = color(0, 0, 255);
color bedroomColor = color(0, 255, 0);
color outsideColor = color(255, 165, 0);

void setup() {
  size(1300, 600);
  background(173, 216, 230);

  textAlign(CENTER);
  textSize(25);
  fill(0);
  text("Time taken to make decisions", width / 2, 190);

  drawYAxis();

  int totalWidth = calculateTotalWidth();

  drawXAxis(totalWidth);

  int currentX = margin;

  for (int i = 0; i < locations.length; i++) {
    drawLocationBars(currentX, timeTaken[i], locations[i], i);
    currentX += (timeTaken[i].length * barWidth) + groupSpacing;
  }
}

int calculateTotalWidth() {
  int totalWidth = 0;

  for (int i = 0; i < timeTaken.length; i++) {
    totalWidth += timeTaken[i].length * barWidth + (timeTaken[i].length - 1) * 5;
  }

  totalWidth += (timeTaken.length - 1) * groupSpacing;

  return totalWidth;
}

void drawLocationBars(int startX, int[] times, String location, int locationIndex) {
  color locationColor;
  if (locationIndex == 0) locationColor = kitchenColor;
  else if (locationIndex == 1) locationColor = bedroomColor;
  else if (locationIndex == 2) locationColor = livingRoomColor;
  else locationColor = outsideColor;

  for (int i = 0; i < times.length; i++) {
    float barHeight = map(times[i], 0, maxTime, 0, maxBarHeight);
    int x = startX + i * (barWidth + 5);
    int y = height - 100 - (int)barHeight;

    fill(locationColor);
    stroke(0);
    rect(x, y, barWidth, (int)barHeight);
  }

  fill(0);
  textSize(16);
  textAlign(CENTER);
  text(location, startX + (times.length * (barWidth + 5)) / 2, height - 30);
}

void drawYAxis() {
  stroke(0);
  line(margin - 20, height - 100, margin - 20, height - 400);

  textAlign(CENTER);
  textSize(16);
  fill(0);
  pushMatrix();
  translate(margin - 50, height / 2);
  rotate(-HALF_PI);
  text("Minutes Taken", 0, 0);
  popMatrix();

  for (int i = 0; i <= maxTime; i += 5) {
    float yPos = map(i, 0, maxTime, height - 100, height - 400);
    textAlign(RIGHT);
    textSize(14);
    text(i, margin - 25, (int)yPos);
  }
}

void drawXAxis(int totalWidth) {
  stroke(1);
  line(margin - 20, height - 100, margin + totalWidth, height - 100);

  textAlign(CENTER);
  textSize(16);
  fill(0);
  text("Location of Decision", margin + totalWidth / 2, height - 7);
}
