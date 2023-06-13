#!/bin/sh

walk () {
    COMMAND="$1"
    dir="$HOME"/dotfiles
    find $dir \
	    \( -path $dir'/.git' -prune \) -o \
	    \( -not -name '.gitignore' -name '.*' \) -print | while read TARGET; do
        # For $HOME/dir1/dir2/file.symlink
        #   WITHIN_HOME:  dir1/dir2/file.symlink
        #   SECTION:      dir1
        #   REST:         dir2/file.symlink
        #   BASE_REST:    dir2/file
        #   LINK:         $HOME/dir2/file
        #   LINK_DIR:     $HOME/dir2

        WITHIN_HOME=`echo "$TARGET" | sed -e 's|^'"$HOME"'/||'`
        SECTION=`echo "$WITHIN_HOME" | sed -e 's|/.*||'`
        REST=`echo "$WITHIN_HOME" | sed -e 's|[^/]*/||'`
        BASE_REST=`echo "$REST" | sed -e 's|.symlink$||'`
        LINK="$HOME/$BASE_REST"
        LINK_DIR=`echo "$LINK" | sed -e 's|/[^/]*$||'`

        $COMMAND
    done
}

list () {
	echo "$BASE_DEST"
	echo "  -> $TARGET"
}

install () {
        echo "Checking $LINK"
	if [ -h "$LINK" ]; then
                echo "There is a symbolic link at $LINK already, skipping"
		return
	fi

	if [ -e "$LINK" ]; then
		echo "[collide] $BASE_REST"
		return
	fi

	echo "[link]    $BASE_REST"
	mkdir -p $BASE_REST
	ln -s "$TARGET" "$LINK"
}

uninstall () {
    if [ -h "$LINK" ]; then
        # As a special case, don't uninstall the dotfiles script itself
        # unless you really ask for it by setting FULL=1.
        if [ "$BASE_REST" = "bin/dotfiles" ]; then
            if [ x$FULL != x1 ]; then
                return
            fi
        fi

        echo "[unlink]  $BASE_REST"
        rm "$LINK"
        # Try to remove the containing directory.  This will fail if
        # there's other stuff there, and that's totally fine.
        rmdir "$LINK_DIR" >/dev/null 2>&1
        return
    fi

    if [ -e "$LINK" ]; then
        echo "[collide] $BASE_REST"
        return
    fi
}

clean () {
    find $HOME -type l | while read LINK; do
        BASE_REST=`echo "$LINK" | sed -e 's|^'"$HOME"'/||'`
        TARGET=`readlink "$LINK"`
        if echo "$TARGET" | grep "^$HOME/\\.dotfiles" > /dev/null; then
            if [ ! -e "$TARGET" ]; then
                echo "[clean]   $BASE_REST"
                rm "$LINK"
            fi
        fi
    done
}

print_opts () {
	echo "Usage: dotfiles install"
	echo "       dotfiles uninstall"
	echo "       dotfiles list"
	echo "       dotfiles clean"
	exit 1
}

COMMAND="$1"
if [ -z "$COMMAND" ]; then
	print_opts
fi

case "$COMMAND" in
	list)           walk list;;
	install)        walk install;;
	uninstall)      walk uninstall;;
	clean)          clean;;
	*) echo "Unknown command $COMMAND"
		print_opts
		exit 1
		;;
esac
