#!/bin/bash
LOG_FILE="/app/logs/update.log"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function verificar_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "[ERRO] Execute este script como root: sudo ./01_update.sh"
    exit 1
  fi
}

function atualizar_sistema() {
  echo "[$DATA] Iniciando atualização do sistema" | tee -a "$LOG_FILE"
  apt-get update >> "$LOG_FILE" 2>&1
  if [[ $? -ne 0 ]]; then
    echo "[ERRO] Falha ao executar apt-get update" | tee -a "$LOG_FILE"
    exit 1
  fi
  apt-get upgrade -y >> "$LOG_FILE" 2>&1
  if [[ $? -eq 0 ]]; then
    echo "[OK] Sistema atualizado com sucesso" | tee -a "$LOG_FILE"
  else
    echo "[ERRO] Falha ao atualizar pacotes" | tee -a "$LOG_FILE"
    exit 1
  fi
}

verificar_root
atualizar_sistema
