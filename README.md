# claude-skills

개인 Claude Code 스킬 모음.

- `skills/` — 유저 레벨 스킬. `~/.claude/skills`가 이 폴더의 심링크라 모든 프로젝트에서 자동 로드된다.
- `projects/<레포>/` — 프로젝트 결합형 스킬의 보관본. **자동 로드되지 않는다** — 원본은 각 레포의
  `.claude/skills/`이고, 여기는 모아 보기·새 프로젝트로 옮겨 쓰기용 사본이다.
- `templates/` — 새 프로젝트에 복사해 채워 쓰는 골격.

## 설치 (새 머신)

```sh
git clone git@github.com:evan7484/claude-skills.git ~/Developer/personal/claude-skills
ln -s ~/Developer/personal/claude-skills/skills ~/.claude/skills
~/Developer/personal/claude-skills/third-party.sh   # 외부 스킬 5종
```

`~/.claude/skills`가 이미 실제 폴더면 내용물을 `skills/`로 옮겨 커밋한 뒤 심링크로 교체.

## 구성

### 내 스킬 (`skills/`)

| 스킬 | 용도 |
| --- | --- |
| `diagnosing-bugs` | 어려운 버그·성능 회귀 진단 루프 |
| `grill-me` | 계획·설계를 집요한 질문으로 다듬기 |
| `resolving-merge-conflicts` | 진행 중인 merge/rebase 충돌 해결 |
| `writing-great-skills` | 스킬 작성·편집 원칙 레퍼런스 |

### 외부 스킬 (`third-party.sh`로 설치, 저장소엔 안 실음)

용량(합계 50MB 남짓) 때문에 `.gitignore`하고 고정 커밋으로 받는다. 갱신은 스크립트의 커밋을 바꿔 다시 실행 —
받은 SKILL.md·scripts는 설치 전에 훑어볼 것(스킬 본문은 그대로 Claude에게 지시가 된다).

| 설치 이름 | 출처 | 비고 |
| --- | --- | --- |
| `frontend-design` | anthropics/skills | 지시문만 |
| `ui-ux-pro-max` | nextlevelbuilder/ui-ux-pro-max-skill | Python 검색 스크립트 + CSV 데이터 |
| `design-taste-frontend` | Leonxlnx/taste-skill | 스킬 사용 중 Stop 훅으로 `gate.mjs` 실행(Node 22+·Chrome) |
| `impeccable` | pbakaus/impeccable | 엔진 바이너리를 처음 실행 때 `~/.impeccable/bin/`에 받음(체크섬 검증). 편집 훅은 `npx impeccable install`로만 — 안 깔았음 |
| `hallmark` | Nutlope/hallmark | 편집 훅 `scripts/install-hook.mjs`는 안 깔았음 |

`skills/synced/`는 Claude 앱이 자동 동기화하는 공식 스킬(일부 독점 라이선스)이라 저장소에 싣지 않는다.

### 루게더 (`projects/`)

| 레포 | 스킬 |
| --- | --- |
| `rougether-mobile` | `design-sync`(claude.ai/design 왕복) · `refactor-batch`(리팩토링 장부 한 묶음) · `spec-compare`(스펙·구현·스웨거 3자 비교) · `store-release`(dev→main 승격·스토어 발행) |
| `rougether-server` | `plan` → `run-plan` → `sync-spec` → `walkthrough`(스펙 기반 구현 루프) · `commit` · `pr` · `add-swagger` · `routinevillage-asset-add`(Figma 에셋 생성) |

원본이 바뀌면 다시 복사한다(git에 올라간 파일만 — `design-sync/out/` 같은 생성물 제외):

```sh
for r in rougether-mobile rougether-server; do
  (cd ~/Developer/personal/$r && git ls-files .claude/skills | while read f; do
    d=~/Developer/personal/claude-skills/projects/$r/${f#.claude/skills/}; mkdir -p "$(dirname "$d")"; cp "$f" "$d"; done)
done
```

### 템플릿 (`templates/`)

- `design-sync` — claude.ai/design 왕복 동기화 골격. 새 프로젝트의 `.claude/skills/design-sync/`로 복사한 뒤
  상단 주석의 플레이스홀더(프로젝트 ID·토큰 경로·generate.js)를 채워서 사용.

## 규칙

- 같은 이름 스킬이 프로젝트 레벨(`.claude/skills/`)에 있으면 그쪽이 우선한다 —
  스킬을 `skills/`로 옮겼으면 프로젝트 쪽 사본은 지워 이중 관리를 피할 것.
- 프로젝트 고유 결합(스크립트·ID·셀렉터)이 강한 스킬은 억지로 범용화하지 말고
  `projects/`에 보관하거나 `templates/`로 골격만 추출한다.
- `align-first`는 2026-11-04 은퇴(superpowers:brainstorming으로 대체).
