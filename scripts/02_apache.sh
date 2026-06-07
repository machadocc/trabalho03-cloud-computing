#!/bin/bash
LOG_FILE="/app/logs/apache.log"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function verificar_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "[ERRO] Execute este script como root: sudo ./02_apache.sh"
    exit 1
  fi
}

function instalar_apache() {
  echo "[$DATA] Iniciando instalação do Apache" | tee -a "$LOG_FILE"
  apt-get update >> "$LOG_FILE" 2>&1
  apt-get install -y apache2 >> "$LOG_FILE" 2>&1
  if [[ $? -ne 0 ]]; then
    echo "[ERRO] Falha ao instalar o Apache" | tee -a "$LOG_FILE"
    exit 1
  fi
  service apache2 restart >> "$LOG_FILE" 2>&1
}

function verificar_apache() {
  if command -v apache2 >/dev/null 2>&1; then
    echo "[OK] Apache está instalado" | tee -a "$LOG_FILE"
  else
    echo "[ERRO] Apache não está instalado" | tee -a "$LOG_FILE"
    exit 1
  fi
}

function versao_apache() {
  if command -v apache2 >/dev/null 2>&1; then
    apache2 -v | tee -a "$LOG_FILE"
  fi
}

verificar_root
instalar_apache
verificar_apache
versao_apache
