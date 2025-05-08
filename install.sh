#!/data/data/com.termux/files/usr/bin/bash

# Nama file APK
APK_NAME="absensi.apk"

# URL file APK di GitHub
APK_URL="https://raw.githubusercontent.com/vay-leen/refs/heads/main/absensi/main/$APK_NAME"

echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_NAME" "$APK_URL"

if [ -f "$APK_NAME" ]; then
    echo "✅ Unduhan selesai."
    echo "📦 Menginstal aplikasi..."

    echo "📱 Membuka installer APK..."
    am start -a android.intent.action.VIEW -d "https://raw.githubusercontent.com/vay-leen/absensi/main/absensi.apk" -t "application/vnd.android.package-archive"

    if [ $? -eq 0 ]; then
        echo "✅ Instalasi berhasil."
        rm "$APK_NAME"
        echo "🧹 File APK dihapus."
    else
        echo "❌ Instalasi gagal."
        echo "File APK tetap disimpan: $APK_NAME"
    fi
else
    echo "❌ Gagal mengunduh APK."
fi

echo "✨ Selesai."
