#!/data/data/com.termux/files/usr/bin/bash

# Nama file dan URL download
APK_NAME="absensi.apk"
APK_URL="https://github.com/vay-leen/absensi/releases/download/v1.0.0/$APK_NAME"
APK_PATH="$HOME/storage/downloads/$APK_NAME"
PACKAGE_NAME="com.pulsahandal.simpeg"

is_installed() {
pm list packages | grep -q "$PACKAGE_NAME"
}

if [ ! -d "$HOME/storage/downloads" ]; then
echo "📂 Mengatur akses penyimpanan Termux..."
termux-setup-storage
sleep 2
fi

if is_installed; then
echo "✅ Aplikasi $PACKAGE_NAME sudah terinstall."
if [ -f "$APK_PATH" ]; then
rm -f "$APK_PATH"
echo "🧹 File APK dihapus: $APK_PATH"
fi
echo "✨ Tidak perlu instalasi ulang."
exit 0
fi

# Step 1: Unduh APK
echo "⏳ Mengunduh aplikasi..."
curl -L -o "$APK_PATH" "$APK_URL"

if [ -f "$APK_PATH" ]; then
echo "✅ APK berhasil diunduh: $APK_PATH"

bash
Copy
Edit
# Step 2: Buka installer
echo "📱 Membuka installer APK..."
am start -a android.intent.action.VIEW -d "file://$APK_PATH" -t "application/vnd.android.package-archive"
sleep 3

echo "⏳ Menunggu instalasi selama 60 detik..."

# Step 3: Tunggu hingga package muncul (maks 60 detik)
timeout=60
for ((i = 1; i <= timeout; i++)); do
    if is_installed; then
        echo "✅ Aplikasi berhasil diinstall."
        break
    fi
    sleep 1
done

# Step 4: Hapus file APK jika sudah terinstall
if is_installed; then
    if [ -f "$APK_PATH" ]; then
        rm -f "$APK_PATH"
        echo "🧹 File APK dihapus."
    fi
    echo "🎉 Instalasi selesai."
else
    echo "⚠️ Timeout: Aplikasi belum terinstall."
    echo "💡 Silakan cek dan instal manual dari: $APK_PATH"
    exit 1
fi

else
    echo "❌ Gagal mengunduh APK."
    exit 1
fi

# Step 5: Bersihkan file APK
rm -f "$APK_PATH"
echo "🧹 File APK dihapus."

echo "✨ Proses selesai."
