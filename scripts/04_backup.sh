#!/bin/bash
ORIGEM="/app/biblioteca-digital"
DESTINO="/app/backups"
LOG_FILE="/app/logs/backup.log"
DATA="$(date '+%Y-%m-%d_%H-%M-%S')"
NOME_ARQUIVO="biblioteca_backup_${DATA}.tar.gz"

function verificar_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "[ERRO] Execute como root: sudo ./04_backup.sh"
    exit 1
  fi
}

function criar_backup() {
  mkdir -p "$DESTINO"
  if [[ ! -d "$ORIGEM" ]]; then
    echo "[ERRO] Diretório de origem não encontrado: $ORIGEM" | tee -a "$LOG_FILE"
    exit 1
  fi
  tar -czf "$DESTINO/$NOME_ARQUIVO" -C "$ORIGEM" . >> "$LOG_FILE" 2>&1
  if [[ $? -eq 0 ]]; then
    echo "[OK] Backup criado em $DESTINO/$NOME_ARQUIVO" | tee -a "$LOG_FILE"
  else
    echo "[ERRO] Falha ao criar backup" | tee -a "$LOG_FILE"
    exit 1
  fi
}

verificar_root
criar_backup
