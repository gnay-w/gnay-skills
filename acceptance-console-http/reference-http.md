# Acceptance console HTTP — endpoint map

Companion to `SKILL.md`. Use **only after product work is done and pushed**.

Paths under `ACCEPT_BASE_URL`. Auth: `Authorization: Bearer $ACCEPT_API_TOKEN`
(when console sets the token). `GET /api/health` is public.

Console runtime env lives in **`deploy/.env`** on the console host (not in the product repo).
Default origin: **`https://tsa.tidun.cn`** (browser UI + Bearer API). Trace Viewer needs HTTPS or localhost.

| Method | Path | Role | Notes |
|---|---|---|---|
| GET | `/api/health` | public | `{ ok, db, objectStorage, trace_id }` |
| GET | `/api/projects` | authenticated | `{ projects: [...] }` |
| POST | `/api/projects` | admin | create; 409 → use ensure |
| POST | `/api/projects/ensure` | admin | get-or-create by `repo_url` |
| GET | `/api/jobs` | authenticated | `{ jobs, batches }`（同列） |
| POST | `/api/jobs` | admin | `{ project_id, baseline_branch, stories[]\|items[], parallelism? }` |
| GET | `/api/jobs/:id` | authenticated | detail + steps/stories/events/… |
| POST | `/api/jobs/:id/stop` | admin | `{ mode?: "soft"\|"force" }` |
| POST | `/api/jobs/:id/push-campaign` | admin | push `campaign/<jobId>` |
| POST | `/api/jobs/:id/merge-baseline` | admin | `{ confirm: true }` required |
| GET/POST | `/api/batches`… | 同上 | **别名**，行为与 `/api/jobs` 相同 |
| GET | `/api/reviews` | authenticated | `?projectId=` / `?repo=` |
| GET | `/api/reviews/:storyId` | authenticated | 故事 id 或执行项 id；`?run=` 选取证次 |
| PATCH | `/api/reviews/:storyId` | reviewer/admin | review payload；可选 `run`/`runId` |
| POST | `/api/projects/:id/organize` | admin | 故事聚类整理 |
| GET | `/api/projects/:id/identities/:identityId/runs` | authenticated | 故事下取证次列表 |

执行项输入：`stories[]` 或 `items[]` 的 `story` / `doc_path`（API 至少一个；Agent **尽量都带**，`story` 按 SKILL「写 story 正文」填槽）。  
Legacy: `design_anchor` / `designAnchor`。

词表：故事 / 批次 / 执行项 / 取证次（见 SKILL.md）。

Body field aliases: `repo_url`/`repoUrl`, `local_path`/`localPath`,
`default_baseline`/`defaultBaseline`, `project_id`/`projectId`,
`baseline_branch`/`baselineBranch`, `doc_path`/`docPath`.
