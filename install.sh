#!/data/data/com.termux/files/usr/bin/bash

# Nama file APK
APK_NAME="absensi.apk"

# URL APK dari Google Drive
APK_URL="https://drive.google.com/uc?export=download&id=1ehCBzC7ACBmm7ib0ZhlDWwphPOya5NKu"

echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_NAME" "$APK_URL"

if [ -f "$APK_NAME" ]; then
    echo "✅ Unduhan selesai."

    echo "📂 Memindahkan ke Download folder..."
    cp "$APK_NAME" "$HOME/storage/downloads/"

    if [ $? -eq 0 ]; then
        echo "✅ Berhasil dipindahkan."

        echo "📱 Membuka installer APK..."
        am start -a android.intent.action.VIEW -d "file:///storage/emulated/0/Download/$APK_NAME" -t "application/vnd.android.package-archive"

        echo "⏳ Menunggu instalasi manual..."
        sleep 10

        # (Opsional) Hapus dari Termux
        rm "$APK_NAME"

        echo "✨ Selesai."
    else
        echo "❌ Gagal memindahkan file APK."
    fi
else
    echo "❌ Gagal mengunduh APK."
fi
