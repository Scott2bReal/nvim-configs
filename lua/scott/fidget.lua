local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
	vim.notify("Fidget.nvim couldn't load")
	return
end

-- fidget.setup({})
fidget.setup({
	text = {
		spinner = "bouncing_ball", -- animation shown when tasks are ongoing
		done = "✔", -- character shown when all tasks are complete
		commenced = "Started", -- message shown when task starts
		completed = "Completed", -- message shown when task completes
	},
})

-- The text.spinner option recognizes the following spinner pattern names:
-- dots
-- dots_negative
-- dots_snake
-- dots_footsteps
-- dots_hop
-- line
-- pipe
-- dots_ellipsis
-- dots_scrolling
-- star
-- flip
-- hamburger
-- grow_vertical
-- grow_horizontal
-- noise
-- dots_bounce
-- triangle
-- arc
-- circle
-- square_corners
-- circle_quarters
-- circle_halves
-- dots_toggle
-- box_toggle
-- arrow
-- zip
-- bouncing_bar
-- bouncing_ball
-- clock
-- earth
-- moon
-- dots_pulse
-- meter
