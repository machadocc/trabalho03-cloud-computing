#!/bin/bash
ORIGEM="/app/source"
DESTINO="/var/www/html"
LOG_FILE="/app/logs/deploy.log"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function verificar_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "[ERRO] Execute este script como root: sudo ./05_deploy.sh"
    exit 1
  fi
}

function executar_deploy() {
  echo "[$DATA] Iniciando deploy do site estático" | tee -a "$LOG_FILE"
  if [[ ! -d "$ORIGEM" ]]; then
    echo "[ERRO] Diretório source não encontrado: $ORIGEM" | tee -a "$LOG_FILE"
    exit 1
  fi
  rm -rf "$DESTINO"/*
  cp -r "$ORIGEM"/* "$DESTINO"/ >> "$LOG_FILE" 2>&1
  chown -R www-data:www-data "$DESTINO"
  if [[ -f "$DESTINO/index.html" ]]; then
    echo "[OK] Deploy finalizado. Arquivos publicados em $DESTINO" | tee -a "$LOG_FILE"
    echo "Arquivos publicados:"
    ls -1 "$DESTINO" | tee -a "$LOG_FILE"
  else
    echo "[ERRO] index.html não foi encontrado após o deploy" | tee -a "$LOG_FILE"
    exit 1
  fi
}

verificar_root
executar_deploy
