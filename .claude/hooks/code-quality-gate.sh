#!/usr/bin/env bash
# Stop hook: 소스 코드 변경이 있을 때만 품질 점검 피드백 전달
# .md, .txt, .json 등 설정/문서만 변경된 경우 스킵
# exit 0 = 스킵, exit 2 = Claude에 피드백

set -euo pipefail

# 변경된 파일 확인 (staged + unstaged)
CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null || true)

if [[ -z "$CHANGED_FILES" ]]; then
  exit 0
fi

# 소스 코드 파일만 필터링
CODE_FILES=$(echo "$CHANGED_FILES" | grep -E '\.(ts|tsx|js|jsx|py|go|rs|java|kt|swift|dart|vue|svelte|css|scss|sh|sql)$' || true)

if [[ -z "$CODE_FILES" ]]; then
  exit 0
fi

FILE_COUNT=$(echo "$CODE_FILES" | wc -l | tr -d ' ')

{
  echo "[코드 품질 점검 권장] 소스 코드 ${FILE_COUNT}개 파일 변경 감지:"
  echo "$CODE_FILES" | head -5 | sed 's/^/  · /'
  if [[ "$FILE_COUNT" -gt 5 ]]; then
    echo "  ... 외 $((FILE_COUNT - 5))개"
  fi
  echo "중복 코드, 미사용 임포트, 명백한 로직 오류를 점검하세요."
} >&2
exit 2
