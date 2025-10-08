

# Implementation Plan: iOS Chat Application (SwiftUI, Mattermost)

**Branch**: `001-ios-swiftui-mattermost` | **Date**: 6 октября 2025 г. | **Spec**: [/specs/001-ios-swiftui-mattermost/spec.md]
**Input**: Feature specification from `/specs/001-ios-swiftui-mattermost/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from file system structure or context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Fill the Constitution Check section based on the content of the constitution document.
4. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
5. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
6. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file (e.g., `CLAUDE.md` for Claude Code, `.github/copilot-instructions.md` for GitHub Copilot, `GEMINI.md` for Gemini CLI, `QWEN.md` for Qwen Code, or `AGENTS.md` for all other agents).
7. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
9. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
Создать iOS-приложение для чата с Mattermost, поддерживающее приватные и групповые чаты, каналы, push-уведомления, локальное хранение, поиск, профиль пользователя. Технический стек: SwiftUI, Combine, CoreData, MVVM, Service Layer для Mattermost REST API, юнит- и интеграционные тесты, CI/CD через GitHub Actions.

## Technical Context
**Language/Version**: Swift 5.9
**Primary Dependencies**: SwiftUI, Combine, CoreData
**Storage**: CoreData (локально), Mattermost REST API (облако)
**Testing**: XCTest (юнит-тесты, интеграционные тесты)
**Target Platform**: iOS 16+
**Project Type**: mobile (iOS)
**Performance Goals**: UI отклик <200мс, синхронизация истории <5с при запуске
**Constraints**: offline-capable, поддержка темной темы, масштабируемость до 10k чатов/100k сообщений
**Scale/Scope**: MVP: 3-5 экранов, поддержка 1k пользователей

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Core Principles:**
- Test-First: Все функции покрываются тестами до реализации (TDD)
- CLI/Service Layer: Вся бизнес-логика вынесена в сервисный слой, UI только отображает состояние
- Integration Testing: Интеграционные тесты для синхронизации, API, push-уведомлений
- Simplicity: Минимально необходимый стек, без избыточных зависимостей
- Observability: Логирование ошибок и ключевых событий

**Gate Status:**
- [x] Initial Constitution Check: PASS

## Project Structure

### Documentation (this feature)
```
specs/[###-feature]/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

tests/
ios/ or android/
### Source Code (repository root)
```
Demo-Speckit-messageApp/
├── ContentView.swift
├── Demo_Speckit_messageAppApp.swift
├── Assets.xcassets/
├── Models/           # Модели данных (чат, сообщение, пользователь)
├── Services/         # Service Layer для Mattermost API, push, storage
├── ViewModels/       # MVVM слой
├── Views/            # SwiftUI экраны: список чатов, чат, профиль
├── Resources/        # Локализация, темы
├── CoreData/         # CoreData stack, схемы
├── Tests/
│   ├── Unit/
│   └── Integration/
└── ...
```

**Structure Decision**: Используется структура iOS-проекта с разделением на Models, Services, ViewModels, Views, Resources, CoreData и тесты.

## Phase 0: Outline & Research
1. Все критические вопросы спецификации уточнены.
2. Best practices:
   - MVVM для разделения UI и логики
   - Combine для реактивного состояния
   - CoreData для офлайн-хранения
   - Service Layer для Mattermost REST API
   - XCTest для тестов, GitHub Actions для CI/CD
3. Интеграция:
   - Push-уведомления через APNs
   - Синхронизация истории через Mattermost API
   - Локализация и поддержка тем
4. Решения и альтернативы будут зафиксированы в research.md

**Output**: research.md с best practices и решениями по стеку

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities from feature spec** → `data-model.md`:
   - Entity name, fields, relationships
   - Validation rules from requirements
   - State transitions if applicable

2. **Generate API contracts** from functional requirements:
   - For each user action → endpoint
   - Use standard REST/GraphQL patterns
   - Output OpenAPI/GraphQL schema to `/contracts/`

3. **Generate contract tests** from contracts:
   - One test file per endpoint
   - Assert request/response schemas
   - Tests must fail (no implementation yet)

4. **Extract test scenarios** from user stories:
   - Each story → integration test scenario
   - Quickstart test = story validation steps

5. **Update agent file incrementally** (O(1) operation):
   - Run `.specify/scripts/bash/update-agent-context.sh gemini`
     **IMPORTANT**: Execute it exactly as specified above. Do not add or remove any arguments.
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, failing tests, quickstart.md, agent-specific file

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Load `.specify/templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (contracts, data model, quickstart)
- Each contract → contract test task [P]
- Each entity → model creation task [P] 
- Each user story → integration test task
- Implementation tasks to make tests pass

**Ordering Strategy**:
- TDD order: Tests before implementation 
- Dependency order: Models before services before UI
- Mark [P] for parallel execution (independent files)

**Estimated Output**: 25-30 numbered, ordered tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (execute tasks.md following constitutional principles)  
**Phase 5**: Validation (run tests, execute quickstart.md, performance validation)

## Complexity Tracking
*Fill ONLY if Constitution Check has violations that must be justified*

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [ ] Phase 0: Research complete (/plan command)
- [ ] Phase 1: Design complete (/plan command)
- [ ] Phase 2: Task planning complete (/plan command - describe approach only)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [ ] Initial Constitution Check: PASS
- [ ] Post-Design Constitution Check: PASS
- [ ] All NEEDS CLARIFICATION resolved
- [ ] Complexity deviations documented

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
