#!/bin/bash
GRUPO="biblioteca_ops"
USUARIO="biblioteca_user"
DIR_TEMA="/app/biblioteca-digital"
LOG_FILE="/app/logs/usuarios_permissoes.log"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function verificar_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "[ERRO] Execute este script como root: sudo ./08_usuarios_permissoes.sh"
    exit 1
  fi
}

function criar_grupo() {
  if getent group "$GRUPO" >/dev/null 2>&1; then
    echo "[INFO] Grupo $GRUPO já existe" | tee -a "$LOG_FILE"
  else
    groupadd "$GRUPO" | tee -a "$LOG_FILE"
    echo "[OK] Grupo $GRUPO criado" | tee -a "$LOG_FILE"
  fi
}

function criar_usuario() {
  if id -u "$USUARIO" >/dev/null 2>&1; then
    echo "[INFO] Usuário $USUARIO já existe" | tee -a "$LOG_FILE"
  else
    useradd -m -g "$GRUPO" -s /bin/bash "$USUARIO" | tee -a "$LOG_FILE"
    echo "[OK] Usuário $USUARIO criado" | tee -a "$LOG_FILE"
  fi
}

function aplicar_permissoes() {
  mkdir -p "$DIR_TEMA"
  chown -R "$USUARIO:$GRUPO" "$DIR_TEMA"
  chmod -R 750 "$DIR_TEMA"
  find "$DIR_TEMA" -type f -exec chmod 640 {} \;
  echo "[OK] Permissões aplicadas em $DIR_TEMA" | tee -a "$LOG_FILE"
}

verificar_root
criar_grupo
criar_usuario
aplicar_permissoes
