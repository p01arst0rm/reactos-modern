# make script for ReactOS Modern theme
# ---------------------------------------------------------

_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
_gimp="C:\Program Files\GIMP 2\bin\gimp-2.10.exe"

mkdir() {
    rm -rf bin/
    mkdir bin/
    mkdir bin/media
}

main() {
    cd $_dir
    mkdir
}

main
