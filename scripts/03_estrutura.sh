#!/bin/bash
BASE_DIR="/app/biblioteca-digital"
LOG_FILE="/app/logs/estrutura.log"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function verificar_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "[ERRO] Execute este script como root: sudo ./03_estrutura.sh"
    exit 1
  fi
}

function criar_estrutura() {
  echo "[$DATA] Criando estrutura de diretórios da Biblioteca Digital" | tee -a "$LOG_FILE"
  mkdir -p "$BASE_DIR"
  rm -rf "$BASE_DIR"/*
  mkdir -p "$BASE_DIR/acervo"
  mkdir -p "$BASE_DIR/usuarios"
  mkdir -p "$BASE_DIR/emprestimos"
  mkdir -p "$BASE_DIR/logs"
  mkdir -p "$BASE_DIR/backups"
  mkdir -p "$BASE_DIR/publicacao"
  echo "Biblioteca Digital - Estrutura inicial criada em $BASE_DIR" > "$BASE_DIR/README_BIBLIOTECA.txt"
  echo "Acesse /app/biblioteca-digital para ver a estrutura" >> "$BASE_DIR/README_BIBLIOTECA.txt"
  echo "[OK] Estrutura temática criada em $BASE_DIR" | tee -a "$LOG_FILE"
}

verificar_root
criar_estrutura
