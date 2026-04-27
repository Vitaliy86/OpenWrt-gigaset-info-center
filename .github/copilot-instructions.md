# Copilot Instructions — OpenWrt Gigaset Info Center

## Задача проекта
Пакет OpenWrt (.apk) — локальная замена облачного сервиса info.gigaset.net.
Предоставляет прогноз погоды Gigaset IP-телефонам через локальный HTTP CGI.

## Репозиторий
https://github.com/Vitaliy86/OpenWrt-gigaset-info-center

## Структура пакета
gigaset-info-center/
├── Makefile
└── files/
├── etc/config/gigaset-info-center   # UCI конфиг (git mode: 100644)
├── etc/init.d/gigaset-info-center   # init-скрипт  (git mode: 100755)
├── usr/bin/gigaset-weather          # логика погоды (git mode: 100755)
└── www/cgi-bin/
├── menu.jsp                     # XHTML-GP меню (git mode: 100755)
└── request.do                   # бегущая строка(git mode: 100755)
## Критические правила OpenWrt Makefile
- ОБЯЗАТЕЛЬНО: `Build/Prepare` с `mkdir -p $(PKG_BUILD_DIR)` — без него SDK ищет тарбол
- НЕ включать `+uhttpd` в DEPENDS — SDK попытается его пересобрать и упадёт
- НЕ использовать PHP — рекурсивная зависимость `php8→PHP8_DOM→php8` в kconfig 25.12
- Только shell CGI: зависимости `+uclient-fetch +jsonfilter`

## Правила GitHub Actions
- ARCH формат: `aarch64_generic-25.12.2`
- ARCH_SHORT (для пути артефактов): `sed 's/-[0-9][0-9]*\..*//'`
- Путь APK: `bin/packages/{ARCH_SHORT}/gigaset/*.apk`
- `if: always()` для upload артефактов — иначе логи теряются при ошибке
- НЕ использовать `IGNORE_ERRORS: 1` — маскирует ошибки

## Типичные ошибки и решения
| Ошибка | Решение |
|--------|---------|
| `cannot stat './files/...'` | Файл не добавлен в git |
| `exit code 2` без деталей | Нет `Build/Prepare` в Makefile |
| `uhttpd compile` | Убрать `+uhttpd` из DEPENDS |
| APK не найден при upload | Неверный ARCH_SHORT, проверить `sed` |
| `recursive dependency php8` | Убрать PHP, использовать shell |

## CGI эндпоинты
- `menu.jsp` → XHTML-GP, многодневный прогноз, Content-Type: text/html
- `request.do` → одна строка текущей погоды, Content-Type: text/plain
- Конфиг: `uci -q get gigaset-info-center.settings.<key>`
- API: OpenWeatherMap v2.5 (uclient-fetch + jsonfilter)
