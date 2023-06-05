# fish

fish is a smart and user-friendly command line
shell for Linux, macOS, and the rest of the family.

website: [fishshell.com](https://fishshell.com)

## install

for macos:

```fish
brew install fish
```


for Ubuntu:

```fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
```

## fisher

installation

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

> please enter fish shell first

## theme(sheller)

use [shellder](https://github.com/simnalamburt/shellder) as fish theme

```fish
fisher install simnalamburt/shellder
```
weak the fish colour scheme

```fish
fish_config
```

# reference

1. [My Fishshell workflow for coding](https://www.youtube.com/watch?v=KKxhf50FIPI&vl=en)
2. [Awesome prompts with fish](https://tobywf.com/2016/03/awesome-prompts-howto/)
