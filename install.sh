#!/data/data/com.termux/files/usr/bin/bash

# Nama file APK
APK_NAME="absensi.apk"

# URL file APK di GitHub
APK_URL="https://drive.google.com/uc?export=download&id=1ehCBzC7ACBmm7ib0ZhlDWwphPOya5NKu"

echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_NAME" "$APK_URL"

if [ -f "$APK_NAME" ]; then
    echo "✅ Unduhan selesai."

    echo "📂 Memindahkan ke /sdcard..."
    cp "$APK_NAME" /sdcard/

    if [ $? -eq 0 ]; then
        echo "✅ Berhasil dipindahkan."

        echo "📱 Membuka installer APK..."
        am start -a android.intent.action.VIEW -d "file:///sdcard/$APK_NAME" -t "application/vnd.android.package-archive"

        echo "⏳ Menunggu instalasi manual..."
        sleep 20

        # Setelah install bisa hapus file APK dari sdcard jika mau
        rm /sdcard/$APK_NAME
        echo "✨ Selesai."
    else
        echo "❌ Gagal memindahkan file APK ke /sdcard."
    fi

    # Hapus file dari Termux internal
    rm "$APK_NAME"

else
    echo "❌ Gagal mengunduh APK."
fi
