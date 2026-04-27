#!/bin/bash

# Update system
sudo pacman -Syu --noconfirm

# Core i3 + Xorg
sudo pacman -S --noconfirm \
i3-wm i3status i3lock dmenu \
xorg-server xorg-xinit xorg-xrandr xorg-xinput

# Terminal + file manager
sudo pacman -S --noconfirm \
alacritty thunar thunar-archive-plugin file-roller

# Networking
sudo pacman -S --noconfirm \
networkmanager network-manager-applet
sudo systemctl enable NetworkManager

# Audio (PipeWire)
sudo pacman -S --noconfirm \
pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol

# Display + compositor
sudo pacman -S --noconfirm \
picom feh nitrogen

# Fonts
sudo pacman -S --noconfirm \
ttf-dejavu noto-fonts ttf-font-awesome

# Utilities
sudo pacman -S --noconfirm \
brightnessctl playerctl neovim git unzip

# Browser
sudo pacman -S --noconfirm firefox

# Launcher + theming
sudo pacman -S --noconfirm rofi lxappearance

# LightDM (auto login setup)
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter

# Enable services
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm

# Configure LightDM for autologin
sudo mkdir -p /etc/lightdm/lightdm.conf.d

USER_NAME=$(whoami)

sudo bash -c "cat > /etc/lightdm/lightdm.conf.d/50-autologin.conf" <<EOF
[Seat:*]
autologin-user=$USER_NAME
autologin-session=i3
EOF

# Create config directories
mkdir -p ~/.config/i3
mkdir -p ~/.config/picom
mkdir -p ~/.config/alacritty

# Picom config
cat <<EOF > ~/.config/picom/picom.conf
backend = "glx";
vsync = true;

fading = true;
fade-in-step = 0.03;
fade-out-step = 0.03;

inactive-opacity = 0.85;
active-opacity = 1.0;
frame-opacity = 0.9;

blur-method = "dual_kawase";
blur-strength = 5;

shadow = true;
shadow-radius = 7;
shadow-opacity = 0.4;

opacity-rule = [
  "100:class_g = 'i3bar'",
  "100:class_g = 'Rofi'"
];
EOF

# Alacritty config
cat <<EOF > ~/.config/alacritty/alacritty.yml
window:
  opacity: 0.9
EOF

echo "Setup complete. Reboot your system."
