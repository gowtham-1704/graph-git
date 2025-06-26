#!/bin/bash

# STEP 1: Create a new directory and Git repo
mkdir gowtham-graph-2025
cd gowtham-graph-2025
git init

# STEP 2: Define the starting Sunday of GitHub graph in 2025
start_date="2025-01-05"

# STEP 3: Function to create a backdated commit
add_commit() {
  offset=$1
  date=$(date -d "$start_date +$offset days" +"%Y-%m-%dT12:00:00")
  GIT_AUTHOR_DATE=$date GIT_COMMITTER_DATE=$date \
  git commit --allow-empty -m "Commit for $date" > /dev/null
}

# STEP 4: Commit pattern to draw "GOWTHAM"
declare -a pattern=(
  # G
  "01110"
  "10000"
  "10011"
  "10001"
  "10001"
  "10001"
  "01110"
  "00" # space

  # O
  "01110"
  "10001"
  "10001"
  "10001"
  "10001"
  "10001"
  "01110"
  "00" # space

  # W
  "10001"
  "10001"
  "10001"
  "10101"
  "10101"
  "10101"
  "01010"
  "00" # space

  # T
  "11111"
  "00100"
  "00100"
  "00100"
  "00100"
  "00100"
  "00100"
  "00" # space

  # H
  "10001"
  "10001"
  "10001"
  "11111"
  "10001"
  "10001"
  "10001"
  "00" # space

  # A
  "01110"
  "10001"
  "10001"
  "11111"
  "10001"
  "10001"
  "10001"
  "00" # space

  # M
  "10001"
  "11011"
  "10101"
  "10001"
  "10001"
  "10001"
  "10001"
)

# STEP 5: Loop through pattern and make commits
col=0
for letter in "${pattern[@]}"; do
  for ((row=0; row<${#letter}; row++)); do
    if [[ ${letter:$row:1} == "1" ]]; then
      day_offset=$((col * 7 + row))
      add_commit $day_offset
    fi
  done
  ((col++))
done

# STEP 6: Final commit and push instructions
git branch -M main
echo "# GitHub graph art for 'Gowtham' (2025)" > README.md
git add .
git commit -m "Add README"

echo ""
echo "✅ Your commits for 2025 are ready!"
echo "👉 Now create a new PUBLIC repo on GitHub (e.g., gowtham-graph-2025)"
echo "👉 Then run these commands:"
echo ""
echo "git remote add origin https://github.com/YOUR-USERNAME/gowtham-graph-2025.git"
echo "git push -u origin main"
echo ""
echo "📈 After pushing, check your GitHub profile — you'll see 'Gowtham' drawn in 2025!"
