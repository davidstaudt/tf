#!/bin/bash
VPK_LINUX=$(find "${HOME}/.steam/steam" -type f -iname "vpk_linux32" -print | head -n 1)
VALVE_LIB_DIR=$(dirname "${VPK_LINUX}")
LD_LIBRARY_PATH="${VALVE_LIB_DIR}:${LD_LIBRARY_PATH}" "${VPK_LINUX}" "${@}"