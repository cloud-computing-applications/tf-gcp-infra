#!/bin/bash

env_file="/opt/webapp/.env"

if [[ ! -f "$env_file" ]]; then

cat <<EOF > "$env_file"
PORT="${PORT}"
DB_USERNAME="${DB_USERNAME}"
DB_PASSWORD="${DB_PASSWORD}"
DB_DATABASE="${DB_DATABASE}"
DB_HOST="${DB_HOST}"
ENVIRONMENT="${ENVIRONMENT}"
LOG_FILE_PATH="${LOG_FILE_PATH}"
EOF

fi