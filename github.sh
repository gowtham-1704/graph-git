#!/bin/bash

# STEP 1: Create a new directory and Git repo
mkdir gowtham-graph
cd gowtham-graph
git init

# STEP 2: Define the starting Sunday (first column of GitHub graph)
# GitHub graph starts on Sunday. We'll begin on Jan 7, 2024 (a Sunday)
start_date="2024-01-07"

# STEP 3: Function to add a commit on a specific day offset from start date
add_commit() {
  offset=$1
  date=$(date -d "$start_date +$offset days" +"%Y-%m-%dT12:00:00")
  GIT_AUTHOR_DATE=$date GIT_COMMITTER_DATE=$date \
  git commit --allow-empty -m "Commit for $date" > /dev/null
}

# STEP 4: Define pixel map for the name "GOWTHAM"
# Each letter is 7x5 (rows x columns), 1 = commit, 0 = no commit
# This pattern creates each letter as 7 vertical dots, space = 2 cols
# Each '1' adds a green dot at that day
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

# STEP 5: Loop through the pattern and generate commits
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

# STEP 6: Finalize and push to GitHub
git branch -M main
echo "# GitHub graph art for name 'Gowtham'" > README.md
git add .
git commit -m "Add README"
echo "✅ Now run the following to push:"
echo "--------------------------------------------"
echo "git remote add origin https://github.com/YOUR-USERNAME/gowtham-graph.git"
echo "git push -u origin main"
echo "--------------------------------------------"
echo "📈 After pushing, your name 'Gowtham' will appear on your GitHub graph for 2024!"
