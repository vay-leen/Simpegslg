#!/data/data/com.termux/files/usr/bin/bash

FILE_ID="1ehCBzC7ACBmm7ib0ZhlDWwphPOya5NKu"
APK_NAME="absensi.apk"
APK_PATH="$HOME/storage/downloads/$APK_NAME"
MIN_SIZE=1048576

# Download file APK
echo "⏳ Mengunduh aplikasi..."
CONFIRM_URL="https://drive.google.com/uc?export=download&id=${FILE_ID}"
CONFIRM_TOKEN=$(curl -sc /tmp/cookie "${CONFIRM_URL}" | grep -o 'confirm=[^&]*' | sed 's/confirm=//')
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM_TOKEN}&id=${FILE_ID}" -o "$APK_PATH"

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
