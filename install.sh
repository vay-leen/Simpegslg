#!/data/data/com.termux/files/usr/bin/bash

# Nama file APK
APK_NAME="absensi.apk"

# URL APK
APK_URL="https://drive.google.com/uc?export=download&id=1ehCBzC7ACBmm7ib0ZhlDWwphPOya5NKu"

# Path tujuan
APK_PATH="$HOME/storage/downloads/$APK_NAME"

# Batas ukuran minimal (dalam bytes), misal 1 MB = 1048576 bytes
MIN_SIZE=1048576

echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_PATH" "$APK_URL"

# Cek kalau file ada
if [ -f "$APK_PATH" ]; then
    # Cek ukuran file
    FILE_SIZE=$(stat -c%s "$APK_PATH")
    echo "📦 Ukuran file: $FILE_SIZE bytes"

    if [ "$FILE_SIZE" -ge "$MIN_SIZE" ]; then
        echo "✅ Ukuran file cukup, lanjut install."

        echo "📱 Membuka installer APK..."
        am start -a android.intent.action.VIEW -d "file:///storage/emulated/0/Download/$APK_NAME" -t "application/vnd.android.package-archive"

        echo "⏳ Menunggu instalasi manual..."
        sleep 10

        # (Opsional) hapus APK setelah install
        # rm "$APK_PATH"

        echo "✨ Selesai."
    else
        echo "❌ File terlalu kecil! (Download gagal atau tidak lengkap)"
        echo "🧹 Menghapus file rusak..."
        rm "$APK_PATH"
    fi
else
    echo "❌ Gagal mengunduh APK."
fi
