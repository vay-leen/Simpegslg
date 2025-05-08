#!/data/data/com.termux/files/usr/bin/bash

# ID file Google Drive (ambil dari link sharing)
FILE_ID="1ehCBzC7ACBmm7ib0ZhlDWwphPOya5NKu"

# Nama file yang ingin disimpan
APK_NAME="absensi.apk"
APK_PATH="$HOME/storage/downloads/$APK_NAME"

# Ukuran minimal file (misal 1MB)
MIN_SIZE=1048576

# URL download
CONFIRM_URL="https://drive.google.com/uc?export=download&id=${FILE_ID}"

echo "⏳ Mendapatkan token konfirmasi dari Google Drive..."

# Ambil halaman pertama untuk dapat token confirm
CONFIRM_TOKEN=$(curl -sc /tmp/cookie "${CONFIRM_URL}" | grep -o 'confirm=[^&]*' | sed 's/confirm=//')

echo "⏳ Mulai mengunduh file APK..."

# Download file menggunakan token konfirmasi
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM_TOKEN}&id=${FILE_ID}" -o "$APK_PATH"

# Cek apakah file berhasil diunduh
if [ -f "$APK_PATH" ]; then
    FILE_SIZE=$(stat -c%s "$APK_PATH")
    echo "📦 Ukuran file: $FILE_SIZE bytes"

    if [ "$FILE_SIZE" -ge "$MIN_SIZE" ]; then
        echo "✅ Ukuran file cukup, lanjut install."

        echo "📱 Membuka installer APK..."
        am start -a android.intent.action.VIEW -d "file:///storage/emulated/0/Download/$APK_NAME" -t "application/vnd.android.package-archive"

        sleep 10

        echo "✨ Selesai."
    else
        echo "❌ File terlalu kecil, download gagal!"
        rm "$APK_PATH"
    fi
else
    echo "❌ Gagal mengunduh file APK."
fi
