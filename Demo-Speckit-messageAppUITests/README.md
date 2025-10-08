# Demo-Speckit-messageApp

## Описание
iOS-приложение для чата с Mattermost: поддержка приватных и групповых чатов, каналов, push-уведомлений, локального хранения, поиска, профиля пользователя.

## Стек
- SwiftUI, Combine, CoreData
- MVVM
- Service Layer для Mattermost REST API
- XCTest (юнит- и интеграционные тесты)
- CI/CD через GitHub Actions

## Запуск
1. Откройте проект в Xcode (iOS 16+)
2. Соберите и запустите на симуляторе или устройстве
3. Для тестов используйте Product → Test (или `Cmd+U`)

## Структура
- Models/ — модели данных
- Services/ — сервисы API, push, storage
- ViewModels/ — логика экрана
- Views/ — SwiftUI-экраны
- CoreData/ — стек и сущности
- Tests/ — юнит- и интеграционные тесты
- .github/workflows/ci.yml — CI/CD

## TODO
- Реализовать реальные запросы к Mattermost API
- Доработать обработку ошибок и UX
- Добавить документацию по API и интеграции push
