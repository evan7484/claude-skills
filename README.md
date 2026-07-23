# claude-skills

개인 Claude Code 스킬 모음. `skills/`는 유저 레벨 스킬(모든 프로젝트에서 자동 로드),
`templates/`는 새 프로젝트에 복사해 채워 쓰는 프로젝트 결합형 스킬 골격.

## 설치 (새 머신)

```sh
git clone git@github.com:evan7484/claude-skills.git ~/Developer/personal/claude-skills
ln -s ~/Developer/personal/claude-skills/skills ~/.claude/skills
```

`~/.claude/skills`가 이미 실제 폴더면 내용물을 `skills/`로 옮겨 커밋한 뒤 심링크로 교체.

## 구성

- `skills/align-first` — 기능 지시 → 재진술·질문·합의 루프 후 구현. 완전 범용.
- `templates/design-sync` — claude.ai/design 왕복 동기화 골격. 새 프로젝트의
  `.claude/skills/design-sync/`로 복사한 뒤 상단 주석의 플레이스홀더
  (프로젝트 ID·토큰 경로·generate.js)를 채워서 사용.

## 규칙

- 같은 이름 스킬이 프로젝트 레벨(`.claude/skills/`)에 있으면 그쪽이 우선한다 —
  스킬을 여기로 옮겼으면 프로젝트 쪽 사본은 지워 이중 관리를 피할 것.
- 프로젝트 고유 결합(스크립트·ID·셀렉터)이 강한 스킬은 억지로 범용화하지 말고
  프로젝트에 남기거나 templates/로만 골격을 추출한다.
