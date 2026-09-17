#!/usr/bin/env bash
# 建立 GitHub repo、推上去，並開啟 GitHub Pages。
# 需要已安裝並登入 gh CLI（gh auth login）。
set -euo pipefail

REPO="english-learning-system"
OWNER="$(gh api user --jq .login)"

gh repo create "$REPO" \
  --public \
  --source=. \
  --remote=origin \
  --push \
  --description "一套以通過條件而非日期推進的英語學習系統：五關框架、經歷語料庫、考試軌道，以及三個 AI 教練 skill。"

# 開啟 GitHub Pages（main 分支根目錄）
gh api -X POST "repos/$OWNER/$REPO/pages" \
  -H "Accept: application/vnd.github+json" \
  -f "source[branch]=main" -f "source[path]=/" || \
  echo "Pages 可能已啟用，或需到 Settings → Pages 手動開啟。"

echo
echo "完成： https://github.com/$OWNER/$REPO"
echo "網站（約 1 分鐘後生效）： https://${OWNER,,}.github.io/$REPO/"
