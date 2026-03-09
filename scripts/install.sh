#!/usr/bin/env bash
set -euo pipefail

# skill-pack 설치 스크립트
# 사용법: bash scripts/install.sh /path/to/target-project [--with-claude-md]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACK_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

TARGET="${1:-}"
WITH_CLAUDE_MD="${2:-}"

if [[ -z "$TARGET" ]]; then
  echo "사용법: bash scripts/install.sh <target-project-path> [--with-claude-md]"
  echo ""
  echo "옵션:"
  echo "  --with-claude-md    CLAUDE.md 템플릿도 함께 복사 (기존 파일 덮어쓰지 않음)"
  echo ""
  echo "예시:"
  echo "  bash scripts/install.sh ~/Dev/my-project"
  echo "  bash scripts/install.sh ~/Dev/my-project --with-claude-md"
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  echo "[error] 대상 경로가 존재하지 않습니다: $TARGET"
  exit 1
fi

# 1. .claude/skills/ 복사
echo "[install] 스킬 복사 중..."
mkdir -p "$TARGET/.claude/skills"
cp -r "$PACK_ROOT/.claude/skills/"* "$TARGET/.claude/skills/"
echo "[install] .claude/skills/ → 완료 ($(find "$TARGET/.claude/skills" -name 'SKILL.md' | wc -l | tr -d ' ')개 스킬)"

# 2. 한국어 스타일 가이드 복사
if [[ -f "$PACK_ROOT/.claude/korean-docs-style-guide.md" ]]; then
  cp "$PACK_ROOT/.claude/korean-docs-style-guide.md" "$TARGET/.claude/"
  echo "[install] korean-docs-style-guide.md → 완료"
fi

# 3. CLAUDE.md 템플릿 (선택)
if [[ "$WITH_CLAUDE_MD" == "--with-claude-md" ]]; then
  if [[ -f "$TARGET/CLAUDE.md" ]]; then
    echo "[install] CLAUDE.md가 이미 존재합니다. 덮어쓰지 않습니다."
    echo "[install] 템플릿을 CLAUDE.md.skill-pack-template로 저장합니다."
    cp "$PACK_ROOT/CLAUDE.md" "$TARGET/CLAUDE.md.skill-pack-template"
  else
    cp "$PACK_ROOT/CLAUDE.md" "$TARGET/CLAUDE.md"
    echo "[install] CLAUDE.md → 완료 (프로젝트에 맞게 수정하세요)"
  fi
fi

# 4. .claude/context/ 초기화 (복합 작업 문서 저장소)
mkdir -p "$TARGET/.claude/context"
echo "[install] .claude/context/ → 초기화 완료"

# 5. .gitignore에 런타임 파일 추가
if [[ -f "$TARGET/.gitignore" ]]; then
  if ! grep -q '.claude/context/' "$TARGET/.gitignore" 2>/dev/null; then
    echo "" >> "$TARGET/.gitignore"
    echo "# skill-pack runtime" >> "$TARGET/.gitignore"
    echo ".claude/context/" >> "$TARGET/.gitignore"
    echo ".claude/settings.local.json" >> "$TARGET/.gitignore"
    echo "[install] .gitignore 업데이트 → 완료"
  fi
fi

echo ""
echo "[install] 설치 완료!"
echo ""
echo "다음 단계:"
echo "  1. CLAUDE.md를 프로젝트에 맞게 수정하세요"
echo "     - '사용자 환경' 섹션의 호칭, 문체 등"
echo "     - '커밋 규칙'의 Co-Authored-By"
echo "     - 프로젝트에 불필요한 스킬이 있으면 해당 디렉토리 삭제"
echo "  2. manage-skills 스킬로 프로젝트별 verify 스킬을 생성하세요"
echo "  3. 복합 작업 시 .claude/context/에 계획서가 자동 생성됩니다"
