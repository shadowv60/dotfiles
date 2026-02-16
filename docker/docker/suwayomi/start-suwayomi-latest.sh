#!/bin/sh

COMPOSE_FILE="/home/shadow/docker/suwayomi/docker-compose.yml"
URL="http://localhost:4568"

echo "🔄 Pulling latest images..."
docker compose -f "$COMPOSE_FILE" pull

echo "🛑 Stopping existing containers..."
docker compose -f "$COMPOSE_FILE" down

echo "🚀 Starting Suwayomi..."
docker compose -f "$COMPOSE_FILE" up -d

echo "⏳ Waiting for Suwayomi to be ready..."
until curl -s -o /dev/null -w "%{http_code}" "$URL" | grep -q 200; do
  sleep 1
done

echo "✅ Suwayomi is up!"

# Open browser only if NOT running over SSH
if [ -z "$SSH_CONNECTION" ]; then
  librewolf "$URL" >/dev/null 2>&1 &
fi

echo "🧹 Cleaning unused Docker images..."
docker image prune -f

exit 0
