# homebrew-tap

Кран Homebrew для [SecretShield](https://github.com/hr4ng9j9nq-ctrl/SecretShield) —
фонового агента macOS, который не даёт случайно отправить API-ключ в
мессенджер или облако.

## Установка

```bash
brew tap hr4ng9j9nq-ctrl/tap
brew trust hr4ng9j9nq-ctrl/tap
brew install --cask secretshield
xattr -dr com.apple.quarantine /Applications/SecretShield.app
```

Вторая строка обязательна: с шестой версии Homebrew не ставит каски из
сторонних кранов, пока их не доверят явно. Без неё установка вернёт
`Refusing to load cask … from untrusted tap`. Доверие выдаётся один раз.

Четвёртая — тоже. Homebrew ставит каски с меткой карантина, а флага
`--no-quarantine` в шестой версии больше нет. Пока метка на месте, macOS не
даёт запустить приложение напрямую, а значит не работает автозапуск при
входе в систему.

Обновления приходят обычным `brew upgrade` — само приложение в сеть не
ходит.

Приложению нужен Универсальный доступ (Accessibility): без него нельзя
остановить вставку. При первом запуске оно само откроет нужный раздел
настроек.

## Обновление формулы

Файл `Casks/secretshield.rb` собирается скриптом из основного репозитория —
править руками не нужно:

```bash
cd ../SecretShield
./scripts/build-universal.sh && ./scripts/package-dmg.sh
gh release upload vX.Y.Z target/release/SecretShield-X.Y.Z.dmg --clobber
SECRETSHIELD_REPO=hr4ng9j9nq-ctrl/SecretShield ./scripts/update-cask.sh
cp Casks/secretshield.rb ../homebrew-tap/Casks/
```

Порядок важен: контрольная сумма в формуле считается по тому файлу, который
уже лежит в релизе. Если выложить .dmg после обновления формулы, суммы
разойдутся и `brew install` откажется ставить.
