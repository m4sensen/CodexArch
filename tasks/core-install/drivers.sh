set -e

echo "🔍 Detecting CPU vendor..."
CPU_VENDOR=$(lscpu | grep "Vendor ID" | awk '{print $3}')

echo "🔍 Detecting GPU vendor..."
GPU_VENDOR=$(lspci | grep -E "VGA|3D" | grep -E "Intel|AMD|ATI" | awk '{print $5}' | head -n 1)

echo "📦 Installing microcode..."
case "$CPU_VENDOR" in
    GenuineIntel)
        sudo pacman -S --needed intel-ucode
        ;;
    AuthenticAMD)
        sudo pacman -S --needed amd-ucode
        ;;
    *)
        echo "⚠️ Unknown CPU vendor: $CPU_VENDOR"
        ;;
esac

echo "📦 Installing graphics drivers..."
sudo pacman -S --needed mesa vulkan-icd-loader libva-mesa-driver vulkan-mesa-layers mesa-vdpau

case "$GPU_VENDOR" in
    Intel)
        sudo pacman -S --needed xf86-video-intel vulkan-intel intel-media-driver
        ;;
    AMD|ATI)
        # Check for newer AMD GPU (assume newer if amdgpu module is supported)
        if lspci -nn | grep -E "VGA.*AMD" | grep -q " [6789a-f][0-9a-f]{3}:"; then
            sudo pacman -S --needed xf86-video-amdgpu vulkan-radeon
        else
            sudo pacman -S --needed xf86-video-ati
        fi
        ;;
    *)
        echo "⚠️ Unknown GPU vendor: $GPU_VENDOR"
        ;;
esac

echo "🔊 Installing audio stack..."
sudo pacman -S --needed pipewire pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack wireplumber

echo "🔗 Enabling PipeWire services..."
systemctl --user enable --now pipewire pipewire-pulse || echo "ℹ️ Skipped user services (you may need to log in first)"

echo "🌐 Installing network support..."
sudo pacman -S --needed networkmanager
sudo systemctl enable --now NetworkManager

echo "🖥️ Installing X11 and fonts..."
sudo pacman -S --needed xorg xorg-xinit noto-fonts ttf-dejavu

echo "✅ All open source drivers and essentials are installed."
