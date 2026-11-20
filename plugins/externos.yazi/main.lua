--- @sync entry
-- Arquivos fora de ~/.config/yazi que esta config usa (F3; nas configs do Neovim é <leader>fx)
return {
	entry = function()
		ya.notify({
			title = "Arquivos externos (fora do ~/.config/yazi)",
			content = table.concat({
				"/snap/bin/nvim  -> abre os arquivos (e e/e t/e s)",
				"~/.config/lvim-react  -> config usada para ler .md/.xml",
				"kitty (kitten @)  -> nova aba/split (abrir-kitty.sh)",
			}, "\n"),
			timeout = 10,
		})
	end,
}
