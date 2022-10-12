let app = new PIXI.Application({ width: 1280, height: 720 });
document.body.appendChild(app.view);

function person(x,y) {
  let sprite = PIXI.Sprite.from('/assets/office_worker.png');
  sprite.width = 128
  sprite.height = 128
  sprite.x = x
  sprite.y = y
  return sprite
}

function tokenslot(x,y, type) {
  const graphics = new PIXI.Graphics();
  // Circle + line style 1
  var lineColor = 0xf8ff00; // blue
  if (type == "demand") {
    lineColor = 0x4d73db;
  }
  if (type == "supply") {
    lineColor = 0xf43b3b;
  }
  graphics.lineStyle(4, lineColor, 1);
  graphics.beginFill(0xffffff, 1);
  graphics.drawCircle(0, 0, 30);
  graphics.endFill();
  graphics.x = x
  graphics.y = y
  return graphics
}

function basketball(x,y) {
  let sprite = PIXI.Sprite.from('/assets/basketball.png');
  sprite.width = 48
  sprite.height = 48
  sprite.x = x
  sprite.y = y
  return sprite
}

function salt(x,y) {
  let sprite = PIXI.Sprite.from('/assets/salt.png');
  sprite.width = 32
  sprite.height = 32
  sprite.x = x
  sprite.y = y
  return sprite
}

function cake(x,y) {
  let sprite = PIXI.Sprite.from('/assets/cake.png');
  sprite.width = 32
  sprite.height = 32
  sprite.x = x
  sprite.y = y
  return sprite
}

function potatoes(x,y) {
  let sprite = PIXI.Sprite.from('/assets/potatoes.png');
  sprite.width = 32
  sprite.height = 32
  sprite.x = x
  sprite.y = y
  return sprite
}

app.stage.addChild(person(200, 100));
app.stage.addChild(tokenslot(200, 100, "supply"));
app.stage.addChild(tokenslot(200 + 128, 100, "demand"));
app.stage.addChild(basketball(200 - 24, 100 - 24));
app.stage.addChild(salt(200 + 128 - 16, 100 - 16));
app.stage.addChild(person(600, 100));
app.stage.addChild(tokenslot(600, 100, "supply"));
app.stage.addChild(tokenslot(600 + 128, 100, "demand"));
app.stage.addChild(salt(600 - 16, 100 - 16));
app.stage.addChild(cake(600 + 128 - 16, 100 - 16));
app.stage.addChild(person(200, 500));
app.stage.addChild(tokenslot(200, 500, "supply"));
app.stage.addChild(tokenslot(200 + 128, 500, "demand"));
app.stage.addChild(cake(200 - 16, 500 - 16));
app.stage.addChild(potatoes(200 + 128 - 16, 500 - 16));
app.stage.addChild(person(600, 500));
app.stage.addChild(tokenslot(600, 500, "supply"));
app.stage.addChild(tokenslot(600 + 128, 500, "demand"));
app.stage.addChild(potatoes(600 - 16, 500 - 16));
app.stage.addChild(basketball(600 + 128 - 24, 500 - 24));

// Add a variable to count up the seconds our demo has been running
let elapsed = 0.0;
// Tell our application's ticker to run a new callback every frame, passing
// in the amount of time that has passed since the last tick
app.ticker.add((delta) => {
  // Add the time to our total elapsed time
  elapsed += delta;
  // Update the sprite's X position based on the cosine of our elapsed time.  We divide
  // by 50 to slow the animation down a bit...
});

// TODO
// show people
// randomly place people in a grid
// TODO connect neighboring people with lines