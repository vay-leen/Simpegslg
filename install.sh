#!/data/data/com.termux/files/usr/bin/bash

# Nama file APK
APK_NAME="absensi.apk"

# URL APK dari Google Drive
APK_URL="https://drive.google.com/uc?export=download&id=1ehCBzC7ACBmm7ib0ZhlDWwphPOya5NKu"

# Path Download
APK_PATH="$HOME/storage/downloads/$APK_NAME"

echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_PATH" "$APK_URL"

if [ -f "$APK_PATH" ]; then
    echo "✅ Unduhan selesai."

    echo "📱 Membuka installer APK..."
    am start -a android.intent.action.VIEW -d "file:///storage/emulated/0/Download/$APK_NAME" -t "application/vnd.android.package-archive"

    echo "⏳ Menunggu instalasi manual..."
    sleep 10

    # (Opsional) Hapus file setelah install
    # rm "$APK_PATH"

    echo "✨ Selesai."
else
    echo "❌ Gagal mengunduh APK."
fi
