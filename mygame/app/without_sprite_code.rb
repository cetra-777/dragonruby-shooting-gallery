$FPS = 60

def tick(args)
  pos = args.inputs.mouse.position # stores coordinates of mouse's position

  args.state.score ||= 0

  args.state.score_label = { x: 50, y: args.grid.h - 50, text: args.state.score, font: 'fonts/Adventurer.ttf',

                             size_enum: 10 }

  args.state.timer ||= 10

  args.state.timer_label = { x: args.grid.w - 180, y: args.grid.h - 50, text: args.state.timer.round, font: 'fonts/Adventurer.ttf',

                             size_enum: 10 }

  if args.state.timer.positive?

    args.state.timer -= 1 / $FPS

  else

    args.state.timer = 0

  end

  args.state.target ||= { x: 200, y: 200, w: 50, h: 50, r: 255, g: 0, b: 0 }

  args.outputs.solids << args.state.target

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
