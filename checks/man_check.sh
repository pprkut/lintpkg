#!/bin/sh

check() {
  DIRECTORIES="/usr/share/man /usr/local/man /usr/local/share/man"

  for i in $DIRECTORIES; do
    if [ -e "$WORKING_DIR/$i" ]; then
      log_error "incorrect-man-dir" "$i"
    fi
  done

  for i in $(find "$WORKING_DIR" -type d -name "man"); do
    for manpage in $(find "$i" -type f ! -name "*.gz"); do
      file=$(echo $manpage | sed "s|^$WORKING_DIR||")
      log_warning "uncompressed-man-page" "$file"
    done
  done

}

info() {
  if [ "$1" = "incorrect-man-dir" ]; then
    echo "Man-pages should be put under /usr/man"
    echo
  elif [ "$1" = "uncompressed-man-page" ]; then
    echo "Man-pages should be gzip-compressed"
    echo
  fi
}
