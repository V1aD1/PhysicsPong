function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 7*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

  screen = {}
  screen.height = 600
  screen.width = 800

  objects = {} -- table to hold all our physical objects
  
  --let's create the ground
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, screen.width/2, screen.height) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  objects.ground.shape = love.physics.newRectangleShape(1000, 50) --make a rectangle with a width of 1000 and a height of 100
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body

  --let's create the borders

  --left wall
  objects.leftWall = {}
  objects.leftWall.body = love.physics.newBody(world, 0, screen.height/2)
  objects.leftWall.shape = love.physics.newRectangleShape(50, screen.height)
  objects.leftWall.fixture = love.physics.newFixture(objects.leftWall.body, objects.leftWall.shape)

  --right wall
  objects.rightWall = {}
  objects.rightWall.body = love.physics.newBody(world, screen.width, screen.height/2)
  objects.rightWall.shape = love.physics.newRectangleShape(50, screen.height)
  objects.rightWall.fixture = love.physics.newFixture(objects.rightWall.body, objects.rightWall.shape)

  --top wall
  objects.topWall = {}
  objects.topWall.body = love.physics.newBody(world, screen.width/2, 0)
  objects.topWall.shape = love.physics.newRectangleShape(1000, 50)
  objects.topWall.fixture = love.physics.newFixture(objects.topWall.body, objects.topWall.shape)

  --let's create a ball
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 0.8) -- Attach fixture to body and give it a density of 1.
  objects.ball.fixture:setRestitution(1) --let the ball bounce

  --let's create a couple blocks to play around with
  objects.block1 = {}
  objects.block1.speedFactor = 1
  objects.block1.body = love.physics.newBody(world, 100, 550, "dynamic")
  objects.block1.shape = love.physics.newRectangleShape(25, 100)
  objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 1) -- A higher density gives it more mass.

  objects.block2 = {}
  objects.block2.speedFactor = 1
  objects.block2.body = love.physics.newBody(world, 600, 550, "dynamic")
  objects.block2.shape = love.physics.newRectangleShape(25, 100)
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 1)

  --initial graphics setup
  love.graphics.setBackgroundColor(104, 136, 248) --set the background color to a nice blue
  --love.window.setMode(650, 650) --set the window dimensions to 650 by 650
end


function love.update(dt)
  world:update(dt) --this puts the world into motion
  
  --here we are going to create some keyboard events

  --controls for right player
  if love.keyboard.isDown("m") then --press the right arrow key to push the ball to the right
    objects.block2.speedFactor = 1.8
  else
    objects.block2.speedFactor = 1
  end

  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
    objects.block2.body:applyForce(1000*objects.block2.speedFactor, 0)
  end
  if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
    objects.block2.body:applyForce(-1000*objects.block2.speedFactor, 0)
  end
  if love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
    objects.block2.body:applyForce(0, -1000*objects.block2.speedFactor)
  end
  if love.keyboard.isDown("down") then --press the up arrow key to set the ball in the air
    objects.block2.body:applyForce(0, 800*objects.block2.speedFactor)
  end

  --controls for left player

  if love.keyboard.isDown("c") then --press the right arrow key to push the ball to the right
    objects.block1.speedFactor = 1.8
  else
    objects.block1.speedFactor = 1
  end

  if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
    objects.block1.body:applyForce(1000*objects.block1.speedFactor, 0)
  end
  if love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
    objects.block1.body:applyForce(-1000*objects.block1.speedFactor, 0)
  end
  if love.keyboard.isDown("w") then --press the up arrow key to set the ball in the air
    objects.block1.body:applyForce(0, -1000*objects.block1.speedFactor)
  end
  if love.keyboard.isDown("s") then --press the up arrow key to set the ball in the air
    objects.block1.body:applyForce(0, 800*objects.block1.speedFactor)
  end



  if love.keyboard.isDown("y") then --press the y key to set the ball in the air
    objects.ball.body:setPosition(650/2, 650/2)
  end
  if love.keyboard.isDown(" ") then --press space to move ball to the right a bit
    objects.ball.body:applyForce(-400, 0)
  end
end

function love.draw()
  --ground
  love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

  --left wall
  love.graphics.setColor(50, 50, 100) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objects.leftWall.body:getWorldPoints(objects.leftWall.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

  --right wall
  love.graphics.setColor(50, 50, 100) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objects.rightWall.body:getWorldPoints(objects.rightWall.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

  --top wall
  love.graphics.setColor(50, 50, 100) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objects.topWall.body:getWorldPoints(objects.topWall.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

  love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

  love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
  love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
end
