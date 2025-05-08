#!/data/data/com.termux/files/usr/bin/bash

# Nama file dan URL download
APK_NAME="absensi.apk"
APK_URL="https://github.com/vay-leen/absensi/releases/download/v1.0.0/$APK_NAME"
APK_PATH="$HOME/storage/downloads/$APK_NAME"

# Step 1: Unduh APK
echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_PATH" "$APK_URL"

# Step 2: Cek file ada
if [ -f "$APK_PATH" ]; then
    echo "✅ APK berhasil diunduh: $APK_PATH"
    
    # Step 3: Buka installer
    am start -a android.intent.action.VIEW -d "file://$APK_PATH" -t "application/vnd.android.package-archive"
    sleep 3
    
    echo "📱 Menunggu user untuk menginstall..."
    
    # Step 4: Monitoring file selama 60 detik
    timeout=60
    installed=0

    for ((i=1; i<=$timeout; i++)); do
        if [ ! -f "$APK_PATH" ]; then
            installed=1
            break
        fi
        sleep 1
    done

    # Step 5: Cek hasil
    if [ "$installed" -eq 1 ]; then
        echo "✅ Aplikasi berhasil diinstall. File dihapus otomatis."
    else
        echo "⚠️ Waktu habis. Anda mungkin belum menginstall aplikasi!"
        echo "File APK tetap tersimpan di: $APK_PATH"
        exit 1
    fi

else
    echo "❌ Gagal mengunduh APK."
    exit 1
fi

# Step 6: Bersihkan file APK
rm -f "$APK_PATH"
echo "🧹 File APK dihapus."

echo "✨ Proses selesai."
