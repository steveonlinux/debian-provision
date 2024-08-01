#!/bin/bash

install_apt_packages(){
apt update -y; apt upgrade -y;
xargs -a apt-get install -y packages.txt 
}

crates=(
    "bat"
    "choose"
    "exa"
    "lsd"
    "git-delta"
    "du-dust"
    "duf"
    "broot"
    "fd-find"
    "ripgrep"
    "sd"
    "bottom"
    "gping"
    "procs"
    "zoxide"
    "dns-doge"
    "mcfly"
    "xh"
    "hyperfine"
    "mdbook"
    "mdbook mdbook-image-size"
)

install_rust_crates() {
    for package in "${crates[@]}"; do
        cargo install --locked "$package"
    done
}

depends(){
  apt update -y; apt upgrade wget -y; apt install wget curl apt fasttrack-archive-keyring
  cp sources.list /etc/apt/sources.list
  apt update -y; apt upgrade wget -y; apt install wget curl apt fasttrack-archive-keyring
  dpkg --add-architecture i386
  curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
  echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/mullvad.list
  distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)
  wget -O- https://deb.librewolf.net/keyring.gpg | gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
  tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list

}

cp_bashrc(){
  cp bashrc "$HOME/.bashrc"
}

install_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  PATH="$HOME/.cargo/bin:$PATH"
}


install_neovim() {
cd /tmp || exit
git clone https://github.com/neovim/neovim && cd neovim || exit
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && dpkg -i nvim-linux64.deb
}

#Inside LunarVim :LvimUpdate
#Inside LunarVim :LvimSyncCorePlugins
install_lunarvim() {
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
}

install_nerdfonts(){
  cd /tmp || exit
  git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
  ./nerd-fonts/install.sh
}

install_vbox(){
  cd /tmp || exit
  wget 'https://download.virtualbox.org/virtualbox/7.0.20/virtualbox-7.0_7.0.20-163906~Debian~bookworm_amd64.deb'
  dpkg -i  ./*virtualbox*
}

main() {
    depends
    install_apt_packages
    install_rust
    install_rust_crates
    install_neovim
    install_lunarvim
    install_nerdfonts
    install_vbox
    cp_bashrc
}

main
