#!/bin/bash

# list archives in current dir
#
# MESSAGES
#
currentDir=$(pwd)
unpacking="Unpacking"
not_found="No archives found in $currentDir"
searching_dir="Searching for .zip, .tar, .tar.gz, .tar.bz2 files in $currentDir"
archive_404="No archives found in $currentDir, please try again."
select_archive="Please select an archive"
invalid_arch="Invalid choice, please try again"
unsupported="Error, file type not supported"
untar_done="$files extracted successfully"

echo $searching_dir
archive_files=($(ls *.zip *.tar *.tar.gz *.tar.bz2 2>/dev/null))

if [ ${#archive_files[@]} -eq 0 ]; then
    echo $archive_404
    exit 1
fi

echo $select_archive
select file in "${archive_files[@]}"; do
    if [ -n "$file" ]; then
        echo "$file Selected"
        break
    else
        echo $invalid_arch
    fi
done
extract_dir="${file%.*}"

counter=1
while [ -e "$extract_dir" ]; do
    extract_dir="${extract_dir}-$counter"
    counter=$((counter + 1))
done

mkdir "$extract_dir"

case "$file" in
    *.zip)
        echo "$unpacking $file into $extract_dir"
        unzip -d "$extract_dir" "$file"
        ;;
    *.tar)
        echo "$unpacking $file into $extract_dir"
        tar -xvf "$file" -C "$extract_dir"
        ;;
    *.tar.gz)
        echo "$unpacking $file into $extract_dir"
        tar -xvzf "$file" -C "$extract_dir"
        ;;
    *.tar.bz2)
        echo "$unpacking $file into $extract_dir"
        tar -xvjf "$file" -C "$extract_dir"
        ;;
    *)
        echo $unsupported
        exit 1
        ;;
esac

echo $untar_done

