#!/data/data/com.termux/files/usr/bin/bash

APK_NAME="absensi.apk"
APK_URL="https://github.com/vay-leen/absensi/releases/download/v1.0.0/$APK_NAME"
APK_PATH="$HOME/storage/downloads/$APK_NAME"

echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_PATH" "$APK_URL"

# Cek apakah file berhasil
if [ -f "$APK_PATH" ]; then
    FILE_SIZE=$(stat -c%s "$APK_PATH")
    echo "📦 Ukuran file: $FILE_SIZE bytes"

    if [ "$FILE_SIZE" -ge "$MIN_SIZE" ]; then
        echo "✅ Ukuran file cukup, lanjut install."

        echo "📱 Membuka installer APK..."
        # Gunakan termux-share untuk menghasilkan content:// URL
        termux-share -a send -c "application/vnd.android.package-archive" "$APK_PATH"

        echo "✨ Silakan klik aplikasi installer yang muncul."
    else
        echo "❌ File terlalu kecil, download gagal!"
        rm "$APK_PATH"
    fi
else
    echo "❌ Gagal mengunduh file APK."
fi
