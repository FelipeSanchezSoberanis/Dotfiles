file=$1

case "$file" in
    *.zip)
        unzip $file;;
    *.gz)
        gzip -dk $file;;
esac

