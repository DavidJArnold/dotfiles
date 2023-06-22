#!/bin/bash


list () {
	echo "$REST"
	echo "  -> $TARGET"
}
export -f list

install () {
        echo "Checking $LINK"
	if [ -h "$LINK" ]; then
                echo "There is a symbolic link at $LINK already, skipping"
		return
	fi

	if [ -e "$LINK" ]; then
		echo "[collide] $REST"
		return
	fi

	echo "[link]    $REST"
	mkdir -p $REST
	ln -s "$TARGET" "$LINK"
}
export -f install

uninstall () {
    if [ -h "$LINK" ]; then
        # As a special case, don't uninstall the dotfiles script itself
        # unless you really ask for it by setting FULL=1.
        if [ "$REST" = "bin/dotfiles" ]; then
            if [ x$FULL != x1 ]; then
                return
            fi
        fi

        echo "[unlink]  $REST"
        rm "$LINK"
        # Try to remove the containing directory.  This will fail if
        # there's other stuff there, and that's totally fine.
        rmdir "$LINK_DIR" >/dev/null 2>&1
        return
    fi

    if [ -e "$LINK" ]; then
        echo "[collide] $REST"
        return
    fi
}
export -f uninstall

clean () {
    find $HOME -type l | while read LINK; do
        REST=`echo "$LINK" | sed -e 's|^'"$HOME"'/||'`
        TARGET=`readlink "$LINK"`
        if echo "$TARGET" | grep "^$HOME/\\.dotfiles" > /dev/null; then
            if [ ! -e "$TARGET" ]; then
                echo "[clean]   $REST"
                rm "$LINK"
            fi
        fi
    done
}
export -f clean

process () {
    TARGET="$2"
    COMMAND="$1"
    # For $HOME/dir1/dir2/file.symlink
    #   WITHIN_HOME:  dir1/dir2/file.symlink
    #   SECTION:      dir1
    #   REST:         dir2/file
    #   LINK:         $HOME/dir2/file
    #   LINK_DIR:     $HOME/dir2

    WITHIN_HOME=`echo "$TARGET" | sed -e 's|^'"$HOME"'/||'`
    SECTION=`echo "$WITHIN_HOME" | sed -e 's|/.*||'`
    REST=`echo "$WITHIN_HOME" | sed -e 's|[^/]*/||'`
    LINK="$HOME/$REST"
    LINK_DIR=`echo "$LINK" | sed -e 's|/[^/]*$||'`

    $COMMAND
}
export -f process

walk () {
    COMMAND="$1"
    dir="$HOME"/dotfiles
    fd -a -t f "^\.[a-z]+\.*" -H -E "\.git*" $dir -x bash -c "process $COMMAND {}"
    fd -a -t f -p "\..*/" -H -E "\.git*" $dir -x bash -c "process $COMMAND {}"
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
