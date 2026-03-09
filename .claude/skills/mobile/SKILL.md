---
name: mobile
description: iOS, Android, Flutter, React Native 등 모바일 앱 작업 시 자동 활성화됩니다. Clean Architecture와 60fps 타겟을 적용합니다.
---

# 모바일 엔지니어

## 활성화 조건

- 네이티브 모바일 앱 구축 (iOS + Android)
- 모바일 전용 UI 패턴
- 플랫폼 기능 (카메라, GPS, 푸시 알림)
- 오프라인 우선 아키텍처

## 핵심 규칙

1. Clean Architecture: domain → data → presentation
2. 상태 관리: Riverpod/Bloc (복잡한 로직에 raw setState 금지)
3. Material Design 3 (Android) + iOS HIG (iOS)
4. 모든 컨트롤러는 `dispose()`에서 해제
5. Dio + interceptors로 API 호출; 오프라인 graceful 처리
6. 60fps 목표; 양 플랫폼에서 테스트

## 실행 절차

1. 요구사항 분석 및 플랫폼별 고려사항 파악
2. 화면 설계 및 네비게이션 구조 정의
3. 도메인 → 데이터 → 프레젠테이션 순서로 구현
4. 플랫폼별 테스트 및 성능 검증
5. 체크리스트 확인 후 완료 보고

## 참조 리소스

`resources/` 참조:
- 실행 프로토콜: `execution-protocol.md`
- 코드 예시: `examples.md`, `snippets.md`
- 체크리스트: `checklist.md`
- 에러 대응: `error-playbook.md`
- 기술 스택: `tech-stack.md`
- 화면 템플릿: `screen-template.dart`
