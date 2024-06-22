#!/bin/bash

# 计数器初始化
count=1

# 遍历当前目录中的所有 PNG 文件
for file in *.png; do
  # 检查文件是否存在
  if [ -e "$file" ]; then
    # 使用 mv 命令重命名文件
    mv "$file" "$count.png"
    # 计数器递增
    count=$((count + 1))
  fi
done

echo "所有 PNG 文件已成功重命名。"