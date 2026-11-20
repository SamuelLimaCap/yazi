--- @sync entry
-- Liga e desliga a barra de atalhos (F2)
return {
	entry = function()
		Root._atalhos_off = not Root._atalhos_off
		ui.render()
	end,
}
