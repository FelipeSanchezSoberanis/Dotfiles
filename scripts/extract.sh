file=$1

case "$file" in
    *.zip)
        unzip $file;;
    *.tar.gz)
        tar -xvf $file;;
    *.gz)
        gzip -dk $file;;
esac

