# 🚀 Повний комплект портів та скриптів для збірки postmarketOS (Samsung Galaxy A52 `samsung-a52q`)

Усі роботи виконано безпосередньо у вашій папці:
📁 **[samsunga52postmarketos](file:///C:/Users/Maksim/.gemini/antigravity/scratch/samsunga52postmarketos)**

---

## 📦 Вміст папки

1. 📂 **`restored_packages/`** — Повністю відновлені пакети з історії Git postmarketOS:
   - `device-samsung-a52q/` (Сценарій збірки та файл специфікацій завантажувача/розділів `deviceinfo`)
   - `firmware-samsung-a52q/` (Сценарій викачування фірмварей для Modem, Wi-Fi, Bluetooth, GPU Adreno, Audio ADSP)
   - `alsa-ucm-conf-samsung-sm7125/` (Конфігурації звукових карт та аудіопрофілів HiFi)

2. 📂 **`pmaports/`** — Локальна копія офіційного дерева пакетів postmarketOS із підключеними та індексованими пакетами `samsung-a52q`.

3. 📜 **`build_pmos_a52.sh`** — Автоматизований Bash-скрипт збірки під Linux/WSL2.

4. 📄 **`README.md`** — Документація з точними командами та параметрами.

---

## 🛠️ Як запустити збірку образу postmarketOS

Оскільки комбіляція ядра Linux (`aarch64`) та створення `boot.img` вимагає Linux-середовища (`pmbootstrap`), виконайте ці дії у **WSL2 (Ubuntu/Debian)** або на Linux-машині:

1. Відкрийте термінал WSL / Linux і перейдіть у папку:
   ```bash
   cd /mnt/c/Users/Maksim/.gemini/antigravity/scratch/samsunga52postmarketos
   ```

2. Зробіть скрипт виконуваним та запустіть його:
   ```bash
   chmod +x build_pmos_a52.sh
   ./build_pmos_a52.sh
   ```

Скрипт автоматично:
- Встановити `pmbootstrap`
- Збере відновлені пакети для `samsung-a52q` у дерева пакетів `pmaports`
- Скомпілює ядро Linux `6.9.2` для Snapdragon 720G
- Зенерує прошивальний `boot.img` та системний `rootfs` з інтерфейсом Phosh (або іншим на ваш вибір) у папку `output/`

---

## ⚡ Як прошити на Samsung Galaxy A52 (SM-A525F)

1. Переведіть телефон у **Download Mode**:
   - Вимкніть смартфон.
   - Затисніть одночасно кнопки **Гучність -** та **Гучність +**, після чого підключіть USB-кабель до ПК.
   - Натисніть **Гучність +** для підтвердження входу в режим Download.
2. Прошийте ядро через Heimdall або `pmbootstrap`:
   ```bash
   pmbootstrap flasher flash_kernel
   ```
