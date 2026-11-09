#!/usr/bin/env bash
# 외부 스킬을 고정 커밋으로 skills/에 설치한다(용량 때문에 저장소엔 안 싣고 .gitignore).
# 갱신: 아래 커밋을 바꾸고 다시 실행. 받은 내용은 설치 전에 SKILL.md·scripts를 훑어볼 것.
set -euo pipefail
cd "$(dirname "$0")"

# 설치 이름 | 저장소 | 커밋 | 저장소 안 스킬 경로
SKILLS=(
  "ui-ux-pro-max|nextlevelbuilder/ui-ux-pro-max-skill|4f2dbb67e64969a9a30ab00742f2d55d66ddec2b|.claude/skills/ui-ux-pro-max"
  "design-taste-frontend|Leonxlnx/taste-skill|f6b76575f949707b4e3c37cd86cb44b0b98643e8|skills/taste-skill"
  "impeccable|pbakaus/impeccable|613fbf88e0ef08709eaf238653285f430250c0ea|.claude/skills/impeccable"
  "hallmark|Nutlope/hallmark|407fa689f4a276f2fd389208d271d0fef08f5058|skills/hallmark"
)

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

for entry in "${SKILLS[@]}"; do
  IFS='|' read -r name repo sha path <<<"$entry"
  src="$tmp/$name"
  git init -q "$src"
  git -C "$src" fetch -q --depth 1 "https://github.com/$repo.git" "$sha"
  git -C "$src" checkout -q FETCH_HEAD
  rm -rf "skills/$name"
  rsync -a --exclude tests "$src/$path/" "skills/$name/"
  for lic in "$src"/LICENSE*; do [ -f "$lic" ] && [ ! -e "skills/$name/$(basename "$lic")" ] && cp "$lic" "skills/$name/"; done
  echo "installed $name ($repo@${sha:0:12})"
done
