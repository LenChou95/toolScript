#!/bin/bash

# 检查是否安装了 imagemagick
if ! command -v convert &> /dev/null; then
    echo "ImageMagick 未安装，请先安装 ImageMagick。"
    exit 1
fi

# 函数：遍历目录并处理图片
process_directory() {
    local dir=$1
    local count=1

    # 遍历目录中的所有文件
    for file in "$dir"/*; do
        # 如果是目录，递归处理
        if [ -d "$file" ]; then
            process_directory "$file"
        # 如果是文件，且扩展名为 .webp 或 .png
        elif [ -f "$file" ]; then
            ext="${file##*.}"
            if [ "$ext" == "webp" ] || [ "$ext" == "png" ]; then
                # 获取文件名（不带扩展名）
                filename="${file%.*}"
                # 定义新的文件名
                newfile="$dir/$count.png"

                # 如果是 .webp 文件，转换为 .png
                if [ "$ext" == "webp" ]; then
                    convert "$file" "$newfile"
                    # 删除原 .webp 文件
                    rm "$file"
                else
                    # 如果是 .png 文件，直接重命名
                    mv "$file" "$newfile"
                fi

                echo "$file 已转换并重命名为 $newfile"
                count=$((count + 1))
            fi
        fi
    done
}

# 指定需要处理的目录，当前目录为示例
start_dir="."

# 开始处理目录
process_directory "$start_dir"

echo "所有图片已成功处理并重命名。"