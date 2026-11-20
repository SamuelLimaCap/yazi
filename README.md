# yazi

Config do gerenciador de arquivos [yazi](https://yazi-rs.github.io) (versão 26.x). Mudanças em relação ao
padrão:

- **XML abre no [lvim-react](https://github.com/SamuelLimaCap/lvim-react)**: `Enter` abre numa aba nova
  do kitty; `O` mostra as outras opções (split ao lado, no próprio terminal, editor padrão).
- **Barra de atalhos no rodapé** (`F2` esconde/mostra).
- **Tema "lofi"** escuro, inspirado no tema padrão do opencode (`theme.toml`).
- `F3` mostra os arquivos fora do `~/.config/yazi` que esta config usa.

## Instalação

```bash
sudo snap install yazi --classic       # ou outro jeito de instalar o yazi 26.x
git clone git@github.com:SamuelLimaCap/yazi.git ~/nvim-configs/yazi
ln -s ~/nvim-configs/yazi ~/.config/yazi
```

Se já houver um `~/.config/yazi`, renomeie antes (`mv ~/.config/yazi ~/.config/yazi.bak`).

## Arquivos fora do repositório

| Caminho | Para quê | Como obter |
|---|---|---|
| `/snap/bin/nvim` | Neovim usado para abrir os arquivos | `sudo snap install nvim --classic` |
| `~/.config/lvim-react` | config do Neovim que abre `.md`/`.xml` | [lvim-react](https://github.com/SamuelLimaCap/lvim-react) |
| kitty + `kitten` | abrir numa aba nova / split | `allow_remote_control yes` no `kitty.conf` |

### Neovim fora do snap

O caminho `/snap/bin/nvim` está fixo em 3 lugares: `yazi.toml`, `keymap.toml` e `abrir-kitty.sh`. Se o
Neovim estiver em outro lugar (ex.: `/usr/bin/nvim`), troque nos três:

```bash
cd ~/.config/yazi
sed -i "s|/snap/bin/nvim|$(command -v nvim)|g" yazi.toml keymap.toml abrir-kitty.sh
```

### kitty

Para abrir em aba/split, o kitty precisa aceitar comandos remotos. No `~/.config/kitty/kitty.conf`:

```conf
allow_remote_control yes
```

Reinicie o kitty depois. Fora do kitty (ou por SSH), o `abrir-kitty.sh` abre o arquivo no próprio
terminal.

## Arquivos

| Arquivo | O quê |
|---|---|
| `yazi.toml` | openers do lvim-react e a regra que manda `*.xml`, `*.xsd`, `*.pom`... para eles |
| `keymap.toml` | `F2`, `F3` e `e t` / `e s` / `e e` (lvim-react em aba / split / aqui) |
| `abrir-kitty.sh` | abre no kitty via `kitten @ launch` |
| `init.lua` | barra de atalhos do rodapé (lista `ATALHOS`) |
| `plugins/atalhos.yazi` | liga/desliga a barra (`F2`) |
| `plugins/externos.yazi` | aviso com os arquivos externos (`F3`) |
| `theme.toml` | tema lofi |

O padrão embutido do yazi (para comparar ou copiar) dá para ler com
`strings -n 4 /snap/yazi/current/yazi` (presets em TOML e componentes Lua `Root`, `Status`, `Header`).
