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

## 설치

### 스크립트로 설치

```bash
git clone https://github.com/Siul49/skill-pack.git
bash skill-pack/scripts/install.sh /path/to/your-project --with-claude-md
```

### 수동 설치

```bash
cp -r skill-pack/.claude/skills/ your-project/.claude/skills/
cp skill-pack/CLAUDE.md your-project/CLAUDE.md
```

### 설치 후 할 일

1. `CLAUDE.md`를 프로젝트에 맞게 수정
   - `사용자 환경`: 호칭, 문체, 시간대
   - `커밋 규칙`: Co-Authored-By 이메일
   - 불필요한 스킬 디렉토리 삭제 (예: 모바일 미사용 시 `mobile/` 삭제)
2. `manage-skills` 스킬로 프로젝트에 맞는 `verify-*` 스킬 생성

## 업데이트

```bash
cd skill-pack && git pull
bash scripts/install.sh /path/to/your-project
```

스킬만 덮어쓰고 `CLAUDE.md`는 건드리지 않습니다.

## 스킬 동작 방식

- **도메인 스킬** (backend, frontend 등): 맥락에 따라 자동 활성화
- **검증 스킬** (verify-implementation, manage-skills): 수동 호출 시 실행
- 각 스킬은 `SKILL.md`(규칙)와 `resources/`(상세 리소스)로 구성
