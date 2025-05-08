#!/data/data/com.termux/files/usr/bin/bash

# Nama file dan URL download
APK_NAME="absensi.apk"
APK_URL="https://github.com/vay-leen/absensi/releases/download/v1.0.0/$APK_NAME"
APK_PATH="$HOME/storage/downloads/$APK_NAME"

# Cek akses storage
if [ ! -d "$HOME/storage/downloads" ]; then
    echo "📂 Mengatur akses penyimpanan Termux..."
    termux-setup-storage
    sleep 2
fi

# Download APK dengan progress bar
echo "⏳ Mengunduh aplikasi dengan progress bar..."
wget --show-progress -O "$APK_PATH" "$APK_URL"

# Verifikasi hasil download
if [ -f "$APK_PATH" ]; then
    echo "✅ APK berhasil diunduh ke: $APK_PATH"
    echo "📢 Silakan instalasi manual lewat file manager."
else
    echo "❌ Gagal mengunduh APK."
    exit 1
fi

echo "✨ Proses selesai."
