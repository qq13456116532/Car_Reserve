import os

# 指定要处理的目录
folders = ['Components', 'Data', 'Models', 'Services']
output_file = 'merge.txt'

with open(output_file, 'w', encoding='utf-8') as outfile:
    for base_folder in folders:
        for root, dirs, files in os.walk(base_folder):
            for file in files:
                file_path = os.path.join(root, file)
                rel_path = os.path.relpath(file_path)  # 获取相对路径

                try:
                    with open(file_path, 'r', encoding='utf-8') as infile:
                        content = infile.read()
                except Exception as e:
                    content = f"[读取文件失败: {e}]"

                outfile.write(f"{rel_path}：【{content}】\n\n")

print(f"所有文件内容已写入 {output_file}")
