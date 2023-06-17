$FPS = 60

def tick(args)
  pos = args.inputs.mouse.position # stores coordinates of mouse's position

  # Define background music

  if args.state.tick_count == 0

    args.audio[:bg_music] = {

      input: 'sounds/bg_music.ogg',

      gain: 0.8,

      looping: true

    }

  end

  args.state.game_state ||= 1

  # Replace cursor with custom graphic

  # Hide cursor using gtk

  args.gtk.hide_cursor

  # Score keeping

  args.state.score ||= 0

  args.state.score_label = { x: 50, y: args.grid.h - 50, text: "Score: #{args.state.score}", font: 'fonts/Adventurer.ttf',

                             size_enum: 10, alignment_enum: 0 }

  # Timer stuff

  args.state.timer ||= 10

  args.state.timer_label = { x: args.grid.w / 2 - 50, y: args.grid.h - 50, text: "Timer: #{args.state.timer.round}", font: 'fonts/Adventurer.ttf',

                             size_enum: 10, alignment_enum: 0 }

  if args.state.timer.positive?

    args.state.timer -= 1 / $FPS

  else

    args.state.timer = 0

    args.state.game_state = 1

  end

  # Create background

  args.state.background = { x: 0, y: 0, w: args.grid.w, h: args.grid.h, path: 'sprites/bg.png' }

  # Create crosshair

  args.state.crosshair = { x: pos.x - 20, y: pos.y - 20, w: 40, h: 40, path: 'sprites/crosshair.png' }

  # Create coin

  args.state.target ||= { x: 200, y: 200, w: 100, h: 100, path: 'sprites/coin.png' }

  handle_click(pos, args)

  # Draw things

  args.outputs.sprites << [args.state.background, args.state.crosshair]

  args.outputs.labels << [args.state.score_label, args.state.timer_label]

  if args.state.game_state == 1

    args.audio[:bg_music].paused = true

    args.state.timer = 0

    args.outputs.labels << [{ x: args.grid.w / 2, y: args.grid.h / 2 + 100, text: 'Click to play!',

                              font: 'fonts/Adventurer.ttf', size_enum: 40, alignment_enum: 1 }]

  end

  return unless args.state.game_state == 2

  args.outputs.sprites << [args.state.target, args.state.crosshair]
end

def handle_click(pos, args)
  return unless args.inputs.mouse.click # if the user clicks the mouse

  if args.state.game_state == 1

    args.state.timer = 10

    args.state.score = 0

    args.state.game_state = 2

  end

  return unless args.state.game_state == 2

  args.audio[:bg_music].paused = false

  pos = args.inputs.mouse.click.point # pos's value is point where user clicked (coordinates)

  args.outputs.sounds << 'sounds/shoot.wav'

  return unless pos.inside_rect? args.state.target # if the click occurred inside the target

  args.state.score += 1

  args.state.target.x = rand(args.grid.w - 100)

  args.state.target.y = rand(args.grid.h - 100)
end

$gtk.reset
