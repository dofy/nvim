return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			log_level = vim.log.levels.ERROR,
			-- auto_session_suppress_dirs = { "~/", "~/Works" },
			auto_session_use_git_branch = false,
		})

		vim.keymap.set("n", "<Leader>s", require("auto-session.session-lens").search_session, {
			noremap = true,
		})
	end,
}
