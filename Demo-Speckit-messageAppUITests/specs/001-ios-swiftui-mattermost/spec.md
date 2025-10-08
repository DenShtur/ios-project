
# Feature Specification: iOS Chat Application (SwiftUI, Mattermost)

**Feature Branch**: `001-ios-swiftui-mattermost`  
**Created**: 6 октября 2025 г.  
**Status**: Draft  
**Input**: User description: "Сделать приложение чата на iOS (SwiftUI): — Пользователь видит список своих чатов и каналов Mattermost — Возможность открывать чат и читать сообщения, синхронизированные с Mattermost API — Поддержка отправки текста, стикеров и медиа (из галереи) — Состояние «прочитано/не прочитано» для сообщений — Push-уведомления о новых сообщениях (APNs) — Возможность создавать новые чаты и каналы — Интерфейс копирует UI Telegram: облако сообщений, аватары, пузырьки сообщений — Поддержка темной темы и разных размеров шрифтов — Локальное кеширование данных через CoreData — Профиль пользователя: аватар, имя, статус"

## Execution Flow (main)
```
1. Parse user description from Input
2. Extract key concepts: users, chats, channels, messages, media, notifications, UI, caching, profile
3. For each unclear aspect: Mark with [NEEDS CLARIFICATION: ...]
4. Fill User Scenarios & Testing section
5. Generate Functional Requirements
6. Identify Key Entities
7. Run Review Checklist
8. Return: SUCCESS (spec ready for planning)
```

---

## ⚡ Quick Guidelines
- Focus on WHAT users need and WHY
- Avoid HOW to implement (no tech stack, APIs, code structure)
- Written for business stakeholders, not developers

---

## User Scenarios & Testing *(mandatory)*

### Primary User Story
Пользователь открывает приложение, видит список своих чатов и каналов Mattermost, может открыть любой чат, читать и отправлять сообщения (текст, стикеры, медиа), получать push-уведомления о новых сообщениях, создавать новые чаты и каналы, просматривать и редактировать свой профиль.

### Acceptance Scenarios
1. **Given** пользователь авторизован, **When** открывает приложение, **Then** видит актуальный список чатов и каналов.
2. **Given** пользователь в чате, **When** отправляет текст, стикер или медиа, **Then** сообщение появляется в чате и синхронизируется с Mattermost.
3. **Given** новое сообщение, **When** пользователь его читает, **Then** статус меняется на «прочитано».
4. **Given** новое входящее сообщение, **When** приложение свернуто, **Then** приходит push-уведомление через APNs.
5. **Given** пользователь хочет создать чат или канал, **When** использует соответствующую функцию, **Then** новый чат/канал появляется в списке.
6. **Given** пользователь открывает профиль, **When** меняет аватар, имя или статус, **Then** изменения сохраняются.

### Edge Cases
- Что происходит при потере интернет-соединения?
- Как система обрабатывает ошибки синхронизации с Mattermost?
- Как отображаются сообщения, если медиа-файл не загрузился?
- Что если push-уведомления не доставлены?


## Clarifications
### Session 2025-10-06
- Q: Нужно ли поддерживать групповые чаты и каналы Mattermost, или только приватные чаты? → A: Приватные чаты, групповые чаты и каналы Mattermost
- Q: Стикеры и медиа: реализовать в первом релизе или позже? → A: Только текст в первом релизе
- Q: Аутентификация: токен пользователя Mattermost или OAuth? → A: Оба способа
- Q: Синхронизация истории сообщений при запуске приложения? → A: Всегда синхронизировать всю историю
- Q: Поиск по чатам и сообщениям нужен? → A: Да, поиск обязателен

## Requirements *(mandatory)*

### Functional Requirements
- **FR-001**: Система должна отображать список приватных чатов, групповых чатов и каналов пользователя Mattermost.
- **FR-002**: Система должна позволять открывать чат и читать сообщения, синхронизированные с Mattermost API.
- **FR-003**: Система должна поддерживать отправку только текста в чате в первом релизе. Стикеры и медиа — в будущих версиях.
- **FR-004**: Система должна отображать статус «прочитано/не прочитано» для сообщений.
- **FR-005**: Система должна отправлять push-уведомления о новых сообщениях через APNs.
- **FR-006**: Система должна позволять создавать новые чаты и каналы.
- **FR-007**: Интерфейс должен копировать UI Telegram: облако сообщений, аватары, пузырьки сообщений.
- **FR-008**: Система должна поддерживать темную тему и разные размеры шрифтов.
- **FR-009**: Система должна локально кешировать данные через CoreData.
- **FR-010**: Система должна предоставлять профиль пользователя: аватар, имя, статус.
- **FR-011**: Система должна всегда синхронизировать всю историю сообщений с Mattermost при запуске приложения.
- **FR-012**: Система должна обеспечивать поиск по чатам и сообщениям.
- **FR-013**: Система должна поддерживать оба способа аутентификации: токен пользователя Mattermost и OAuth.

### Key Entities
- **Пользователь**: id, имя, аватар, статус
- **Чат/Канал**: id, название, участники, тип (чат/канал)
- **Сообщение**: id, автор, текст, медиа, статус (прочитано/не прочитано), время
- **Медиа**: id, тип (изображение, видео, стикер), ссылка/данные

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [ ] No implementation details (languages, frameworks, APIs)
- [ ] Focused on user value and business needs
- [ ] Written for non-technical stakeholders
- [ ] All mandatory sections completed

### Requirement Completeness
- [ ] No [NEEDS CLARIFICATION] markers remain
- [ ] Requirements are testable and unambiguous
- [ ] Success criteria are measurable
- [ ] Scope is clearly bounded
- [ ] Dependencies and assumptions identified

---

## Execution Status
*Updated by main() during processing*

- [ ] User description parsed
- [ ] Key concepts extracted
- [ ] Ambiguities marked
- [ ] User scenarios defined
- [ ] Requirements generated
- [ ] Entities identified
- [ ] Review checklist passed

---
