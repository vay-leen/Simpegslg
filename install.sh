#!/data/data/com.termux/files/usr/bin/bash

VERSION="v1.0.0"
BASE_URL="https://github.com/vay-leen/absensi/releases/download/$VERSION"
APK_LIST=("absensi.apk" "gps.apk")
DOWNLOAD_DIR="$HOME/storage/downloads"

if [ ! -d "$DOWNLOAD_DIR" ]; then
    echo "📂 Mengatur akses penyimpanan Termux..."
    termux-setup-storage
    sleep 2
fi

for APK_NAME in "${APK_LIST[@]}"; do
    APK_URL="$BASE_URL/$APK_NAME"
    APK_PATH="$DOWNLOAD_DIR/$APK_NAME"

    echo "⏳ Mengunduh $APK_NAME..."
    curl -# -L -o "$APK_PATH" "$APK_URL"
    
    if [ -f "$APK_PATH" ]; then
        echo "✅ $APK_NAME berhasil diunduh ke: $APK_PATH"
    else
        echo "❌ Gagal mengunduh $APK_NAME"
    fi
done

echo "✨ Proses selesai."
