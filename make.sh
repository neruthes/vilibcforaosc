#!/bin/bash

BASEDIR="$(realpath "$(dirname "$0")")"


function pandoc_gateway() {
    pandoc -i "$1" -f gfm -o "$1".pdf -N -H "$H" --pdf-engine=xelatex --shift-heading-level-by=-1 -V fontsize:$fontsize $EXTRA_PANDOC_ARGS
}



case $1 in
    deps | dependencies-pull)
        mkdir -p deps
        cd deps || exit 1
        gitdeps=('LOGO https://github.com/AOSC-Dev/LOGO')
        for dep in "${gitdeps[@]}"; do
            repo_name="$(cut -d' ' -f1 <<< "$dep")"
            if [[ ! -d "$repo_name" ]]; then
                git clone "$(cut -d' ' -f2 <<< "$dep")"
            else
                cd "$repo_name" || exit 1
                git pull
                cd "$BASEDIR/deps" || exit 1
            fi
        done        
        ;;
    deps/LOGO)
        for i in deps/LOGO/*.svg; do
            rsvg-convert "$i" -z2 -o "$i.png"
        done
        ;;
    metadocs/*.md | examples/*.md)
        echo "Producing ... $(realpath "$1.pdf")"
        type="$(head -n5 "$1" | grep '^type:' | cut -d' ' -f2-)"
        [[ -z $type ]] && type=article
        export H="real/latex/aosc-$type.H.tex"
        export fontsize='12pt'
        case $type in
            article)
                export papersize=A4
                pentex "$1" || echo "Something happened."
                ;;
            slides)
                pandoc "$1" -o "$1.pdf" -H "$HOME/.local/share/vilibforaosc/$dir/real/latex/aosc-slides.H.tex" --pdf-engine=xelatex --pdf-engine-opt=-shell-escape
                ;;
        esac
        ;;
    oss)
        cfoss */*.md.pdf
        ;;
    update)
        git pull
        bash make.sh deps
        bash make.sh ins
        ;;
    ins | install)
        for dir in real deps; do
            rsync -av --delete --mkpath "$dir/" "$HOME/.local/share/vilibforaosc/$dir/"
        done
        for helper in helpers/*.sh; do
            dest="$HOME/.local/bin/$(basename "$helper")"
            ln -svf "$(realpath "$helper")" "$dest"
            chmod +x "$dest"
        done
        echo "Installation completed."
        echo "To uninstall, delete the following directory:"
        echo "    $HOME/.local/share/vilibforaosc"
        ;;
    '')
        echo "No target is specified"
        ;;
    *)
        echo "Unknown target"
        ;;
esac
