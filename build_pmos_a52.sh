#!/bin/bash
# ==============================================================================
# Скрипт автоматичної збірки postmarketOS для Samsung Galaxy A52 (samsung-a52q)
# Виконувати в папці: samsunga52postmarketos
# ==============================================================================

set -e

echo "=== 1. Перевірка наявності pmbootstrap ==="
if ! command -v pmbootstrap &> /dev/null; then
    echo "[!] pmbootstrap не знайдено. Встановлюємо через pip..."
    python3 -m pip install --user pmbootstrap
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "=== 2. Підготовка репозиторію pmaports з відновленим портом ==="
CDIR="$(pwd)"
PMAPORTS_DIR="$CDIR/pmaports"

if [ ! -d "$PMAPORTS_DIR" ]; then
    echo "[!] Клонуємо pmaports..."
    git clone https://gitlab.com/postmarketOS/pmaports.git "$PMAPORTS_DIR"
fi

cd "$PMAPORTS_DIR"

echo "[+] Копіюємо відновлені пакети в структуру pmaports..."
cp -r "$CDIR/restored_packages/device-samsung-a52q" device/testing/
cp -r "$CDIR/restored_packages/firmware-samsung-a52q" device/testing/
cp -r "$CDIR/restored_packages/alsa-ucm-conf-samsung-sm7125" device/testing/

echo "=== 3. Ініціалізація pmbootstrap ==="
pmbootstrap init --device=samsung-a52q --ui=phosh --aports="$PMAPORTS_DIR"

echo "=== 4. Збірка порту device-samsung-a52q ==="
pmbootstrap build device-samsung-a52q --force

echo "=== 5. Генерація установочного образу postmarketOS ==="
pmbootstrap install

echo "=== 6. Експорт готових файлів прошивки (boot.img та rootfs) ==="
pmbootstrap export "$CDIR/output"

echo "=============================================================================="
echo "✅ УСПІХ! Образ postmarketOS для Samsung Galaxy A52 зібрано!"
echo "Файли для прошивки знаходяться у папці: $CDIR/output"
echo "Для прошивки підключіть пристрій у Download Mode та виконайте:"
echo "  pmbootstrap flasher flash_kernel"
echo "=============================================================================="
