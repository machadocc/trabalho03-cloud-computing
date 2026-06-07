#!/bin/bash
REPORT="/app/logs/relatorio_execucao.txt"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function status_apache() {
  if service apache2 status >/dev/null 2>&1; then
    echo "Apache: em execução"
  else
    echo "Apache: não está em execução"
  fi
}

function listar_arquivos_publicados() {
  if [[ -d "/var/www/html" ]]; then
    find /var/www/html -maxdepth 2 -type f | sort | sed 's|^/var/www/html|/var/www/html|' | head -25
  else
    echo "Diretório de publicação não encontrado"
  fi
}

function listar_usuarios() {
  getent passwd | grep -E 'biblioteca_user|root' || true
}

{
  echo "Relatório Operacional"
  echo "Data: $DATA"
  echo "Projeto: Biblioteca Digital"
  echo "Tema: Infraestrutura de Biblioteca Digital"
  echo ""
  echo "Espaço em disco (raiz):"
  df -h / | head -2
  echo ""
  echo "Uso do diretório de tema (/app/biblioteca-digital):"
  du -sh /app/biblioteca-digital 2>/dev/null || echo "Diretório não encontrado"
  echo ""
  echo "Status do Apache:"
  status_apache
  echo ""
  echo "Últimos backups gerados:"
  ls -1t /app/backups 2>/dev/null | head -5 || echo "Nenhum backup encontrado"
  echo ""
  echo "Últimos logs gerados:"
  ls -1t /app/logs 2>/dev/null | head -5 || echo "Nenhum log encontrado"
  echo ""
  echo "Arquivos publicados em /var/www/html:"
  listar_arquivos_publicados
  echo ""
  echo "Usuários e grupos principais:"
  echo "Grupo biblioteca_ops:"
  getent group biblioteca_ops || echo "Grupo biblioteca_ops não encontrado"
  echo ""
  echo "Usuário biblioteca_user:"
  getent passwd biblioteca_user || echo "Usuário biblioteca_user não encontrado"
  echo ""
  echo "Permissões principais do diretório de tema:"
  ls -ld /app/biblioteca-digital 2>/dev/null || echo "Diretório não encontrado"
} > "$REPORT"

echo "[OK] Relatório salvo em $REPORT"
