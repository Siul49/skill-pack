# skill-pack

Claude Code 기반 재사용 가능한 에이전트 스킬 번들.

## 구조

```
.claude/skills/          # 스킬 정의 (SKILL.md + resources/)
├── backend/             # API, DB, 서버 로직
├── frontend/            # UI, 컴포넌트, 스타일링
├── mobile/              # iOS, Android, Flutter
├── debug/               # 버그 진단, 에러 추적
├── qa/                  # 보안/성능/접근성 감사
├── pm/                  # 기획, 태스크 분해
├── commit/              # Conventional Commits
├── review/              # 코드 리뷰
├── verify-implementation/  # 통합 검증 파이프라인
├── manage-skills/       # 검증 스킬 자동 생성/관리
└── _shared/resources/   # 공유 리소스
CLAUDE.md                # 프로젝트 설정
```

## 사용 방법

이 레포를 클론하고 대상 프로젝트에 `.claude/` 디렉토리와 `CLAUDE.md`를 복사합니다.

```bash
git clone https://github.com/your-org/skill-pack.git
cp -r skill-pack/.claude/ your-project/.claude/
cp skill-pack/CLAUDE.md your-project/CLAUDE.md
```

`CLAUDE.md`를 프로젝트에 맞게 수정합니다.

## 스킬 동작 방식

- **도메인 스킬** (backend, frontend 등): 맥락에 따라 자동 활성화
- **검증 스킬** (verify-implementation, manage-skills): 수동 호출 시 실행
- 각 스킬은 `SKILL.md`(규칙)와 `resources/`(상세 리소스)로 구성
