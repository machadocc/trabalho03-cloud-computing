#!/bin/bash
LOG_FILE="/app/logs/processos.log"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function listar_processos() {
  echo "[$DATA] Listando processos ativos" | tee -a "$LOG_FILE"
  ps -ef | head -40
}

function buscar_processo() {
  if [[ -z "$1" ]]; then
    echo "[ERRO] Informe o nome do processo. Ex: ./06_processos.sh buscar apache"
    exit 1
  fi
  echo "[$DATA] Buscando processo: $1" | tee -a "$LOG_FILE"
  pgrep -fl "$1" || echo "Nenhum processo encontrado para '$1'"
}

function matar_processo() {
  if [[ -z "$1" ]]; then
    echo "[ERRO] Informe o PID do processo. Ex: ./06_processos.sh matar 1234"
    exit 1
  fi
  if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "[ERRO] PID inválido: $1"
    exit 1
  fi
  echo "[$DATA] Tentando matar processo PID $1" | tee -a "$LOG_FILE"
  kill "$1" 2>/dev/null
  if [[ $? -eq 0 ]]; then
    echo "[OK] Processo $1 encerrado" | tee -a "$LOG_FILE"
  else
    echo "[ERRO] Falha ao encerrar processo $1" | tee -a "$LOG_FILE"
    exit 1
  fi
}

case "$1" in
  listar)
    listar_processos
    ;;
  buscar)
    buscar_processo "$2"
    ;;
  matar)
    matar_processo "$2"
    ;;
  *)
    echo "Uso: ./06_processos.sh {listar|buscar <nome>|matar <PID>}"
    exit 1
    ;;
esac
