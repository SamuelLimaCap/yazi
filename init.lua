-- Barra de atalhos no rodapé do yazi (F2 esconde/mostra)

local ATALHOS = {
	{ "~", "todos os atalhos" },
	{ "F2", "esconder barra" },
	{ "F3", "externos" },
	{ "q", "sair" },
	{ "hjkl", "navegar" },
	{ "Enter", "abrir" },
	{ "O", "abrir com…" },
	{ "et/es", "lvim aba/split" },
	{ "Espaço", "selecionar" },
	{ "v", "seleção visual" },
	{ "y", "copiar" },
	{ "x", "recortar" },
	{ "p", "colar" },
	{ "d", "lixeira" },
	{ "a", "criar (/ = pasta)" },
	{ "r", "renomear" },
	{ ".", "ocultos" },
	{ "f", "filtrar" },
	{ "/", "achar aqui" },
	{ "s", "buscar nome" },
	{ "S", "buscar conteúdo" },
	{ "z", "fzf" },
	{ "Z", "zoxide" },
	{ "gh", "home" },
	{ "cc", "copiar caminho" },
	{ ",", "ordenar…" },
	{ "tt", "nova aba" },
	{ "1-9", "trocar aba" },
	{ ";", "shell" },
	{ "w", "tarefas" },
}

local MAX_LINHAS = 4
local COR_TECLA = "#fab283"
local COR_DESC = "#808080"
local COR_FUNDO = "#101010"

local function linhas_atalhos(largura)
	local linhas, atual, usado = {}, {}, 0
	for _, a in ipairs(ATALHOS) do
		local tam = utf8.len(a[1]) + 1 + utf8.len(a[2]) + 3
		if usado > 0 and usado + tam > largura then
			linhas[#linhas + 1] = atual
			if #linhas >= MAX_LINHAS then
				return linhas
			end
			atual, usado = {}, 0
		end
		atual[#atual + 1] = ui.Span(" " .. a[1]):fg(COR_TECLA):bold()
		atual[#atual + 1] = ui.Span(" " .. a[2] .. "  "):fg(COR_DESC)
		usado = usado + tam
	end
	if #atual > 0 then
		linhas[#linhas + 1] = atual
	end
	return linhas
end

Atalhos = { _id = "atalhos" }

function Atalhos:new(area, linhas) return setmetatable({ _area = area, _linhas = linhas }, { __index = self }) end

function Atalhos:reflow() return {} end

function Atalhos:redraw()
	local t = {}
	for i, spans in ipairs(self._linhas) do
		t[i] = ui.Line(spans)
	end
	return { ui.Text(t):area(self._area):bg(COR_FUNDO) }
end

function Root:layout()
	self._atalhos = Root._atalhos_off and {} or linhas_atalhos(self._area.w)
	self._chunks = ui.Layout()
		:direction(ui.Layout.VERTICAL)
		:constraints({
			ui.Constraint.Length(1),
			ui.Constraint.Length(Tabs.height()),
			ui.Constraint.Fill(1),
			ui.Constraint.Length(1),
			ui.Constraint.Length(#self._atalhos),
		})
		:split(self._area)
end

local build_original = Root.build
function Root:build()
	build_original(self)
	-- antes do Modal (último), para os menus ficarem por cima
	table.insert(self._children, #self._children, Atalhos:new(self._chunks[5], self._atalhos))
end
