#!/bin/bash
SCRIPTS_DIR="/app/scripts"

function menu() {
  echo "========================================="
  echo "  Biblioteca Digital - Menu DevOps Cloud"
  echo "  Aluno: Exemplo Aluno"
  echo "  Instituição: Unidavi"
  echo "  Tema: Biblioteca Digital"
  echo "========================================="
  echo "1 - Atualizar sistema"
  echo "2 - Instalar Apache"
  echo "3 - Criar estrutura do projeto"
  echo "4 - Realizar backup"
  echo "5 - Fazer deploy"
  echo "6 - Ver processos"
  echo "7 - Monitorar sistema"
  echo "8 - Configurar usuários e permissões"
  echo "9 - Gerar relatório"
  echo "0 - Sair"
  echo "========================================="
}

while true; do
  menu
  read -rp "Escolha uma opção: " opcao
  case "$opcao" in
    1)
      bash "$SCRIPTS_DIR/01_update.sh"
      ;;
    2)
      bash "$SCRIPTS_DIR/02_apache.sh"
      ;;
    3)
      bash "$SCRIPTS_DIR/03_estrutura.sh"
      ;;
    4)
      bash "$SCRIPTS_DIR/04_backup.sh"
      ;;
    5)
      bash "$SCRIPTS_DIR/05_deploy.sh"
      ;;
    6)
      echo "Sub-opções: listar | buscar <nome> | matar <PID>"
      read -rp "Digite o comando de processo: " comando valor
      bash "$SCRIPTS_DIR/06_processos.sh" "$comando" "$valor"
      ;;
    7)
      bash "$SCRIPTS_DIR/07_monitoramento.sh"
      ;;
    8)
      bash "$SCRIPTS_DIR/08_usuarios_permissoes.sh"
      ;;
    9)
      bash "$SCRIPTS_DIR/09_relatorio.sh"
      ;;
    0)
      echo "Saindo do menu."
      exit 0
      ;;
    *)
      echo "Opção inválida. Tente novamente."
      ;;
  esac
  echo
  read -rp "Pressione Enter para continuar..." dummy
done
