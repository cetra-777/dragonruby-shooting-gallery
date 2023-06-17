$FPS = 60

def tick(args)
  pos = args.inputs.mouse.position # stores coordinates of mouse's position

  # Replace cursor with custom graphic

  # Hide cursor using gtk

  args.gtk.hide_cursor

  # Draw crosshair

  args.state.crosshair = { x: pos.x - 20, y: pos.y - 20, w: 40, h: 40, path: 'sprites/crosshair.png' }

  # Score keeping

  args.state.score ||= 0

  args.state.score_label = { x: 50, y: args.grid.h - 50, text: args.state.score, font: 'fonts/Adventurer.ttf',

                             size_enum: 10 }

  # Timer stuff

  args.state.timer ||= 10

  args.state.timer_label = { x: args.grid.w - 180, y: args.grid.h - 50, text: args.state.timer.round, font: 'fonts/Adventurer.ttf',

                             size_enum: 10 }

  if args.state.timer.positive?

    args.state.timer -= 1 / $FPS

  else

    args.state.timer = 0

  end

  # Draw coins

  args.state.target ||= { x: 200, y: 200, w: 100, h: 100, path: 'sprites/coin.png' }

  args.outputs.sprites << [args.state.target, args.state.crosshair]

  args.outputs.labels << [args.state.score_label, args.state.timer_label]

  handle_click(pos, args)
end

def handle_click(pos, args)
  return unless args.inputs.mouse.click # if the user clicks the mouse

  pos = args.inputs.mouse.click.point # pos's value is point where user clicked (coordinates)

  return unless pos.inside_rect? args.state.target # if the click occurred inside the target

  args.state.score += 1

  args.state.target.x = rand(args.grid.w - 50)

  args.state.target.y = rand(args.grid.h - 50)
end

$gtk.reset
