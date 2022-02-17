#!/bin/sh

if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0151515
  \e]P1fb9fb1
  \e]P2acc267
  \e]P3ddb26f
  \e]P46fc2ef
  \e]P5e1a3ee
  \e]P612cfc0
  \e]P7d0d0d0
  \e]P8505050
  \e]P9fb9fb1
  \e]PAacc267
  \e]PBddb26f
  \e]PC6fc2ef
  \e]PDe1a3ee
  \e]PE12cfc0
  \e]PFf5f5f5
  "
  # get rid of artifacts
  clear
fi
