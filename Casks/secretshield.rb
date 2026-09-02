# Формула Homebrew Cask. Собирается скриптом scripts/update-cask.sh —
# править руками не нужно, версия и контрольная сумма подставляются из
# собранного образа.
cask "secretshield" do
  version "0.1.0"
  sha256 "0cce1c564df117e8f81170f9140e59f291bccc82a80b634ea8d95952bd886499"

  url "https://github.com/hr4ng9j9nq-ctrl/SecretShield/releases/download/v#{version}/SecretShield-#{version}.dmg"
  name "SecretShield"
  desc "Не даёт случайно вставить API-ключ в мессенджер"
  homepage "https://github.com/hr4ng9j9nq-ctrl/SecretShield"

  depends_on macos: :big_sur

  app "SecretShield.app"

  # Настройки — единственное, что приложение пишет на диск. Заглушения живут
  # в памяти и уходят вместе с процессом.
  zap trash: [
    "~/Library/Application Support/SecretShield",
    "~/Library/LaunchAgents/com.secretshield.agent.plist",
  ]

  caveats <<~EOS
    Приложению нужен Универсальный доступ (Accessibility) — без него нельзя
    остановить вставку. При первом запуске оно само откроет нужный раздел
    настроек: System Settings → Privacy & Security → Accessibility.

    Приложение подписано самодельным сертификатом, а не сертификатом Apple.
    Homebrew ставит его без карантина, поэтому «Открыть всё равно» не
    понадобится — но при обновлении разрешение Универсального доступа
    слетает, и его нужно выдать заново. Приложение об этом предупредит.
  EOS
end
