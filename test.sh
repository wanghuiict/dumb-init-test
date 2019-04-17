#!/bin/bash
sh -c "exec /usr/local/bin/mysleep" &
exec /usr/local/bin/mysleep
