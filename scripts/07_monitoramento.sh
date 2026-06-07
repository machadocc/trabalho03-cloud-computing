#!/bin/bash
LOG_FILE="/app/logs/monitoramento.log"
DATA="$(date '+%Y-%m-%d %H:%M:%S')"

function verificar_apache() {
  if service apache2 status >/dev/null 2>&1; then
    echo "[OK] Apache em execução"
    APACHE_STATUS="OK"
  else
    echo "[ALERTA] Apache não está em execução"
    APACHE_STATUS="ALERTA"
  fi
}

function coletar_cpu() {
  local cpu_idle cpu_uso
  cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' '{print $1}' | awk '{print $NF}')
  cpu_uso=$(awk "BEGIN {printf \"%.1f\", 100 - $cpu_idle}")
  echo "Uso de CPU: $cpu_uso%"
  if (( $(echo "$cpu_uso > 80" | bc -l) )); then
    echo "[ALERTA] Uso de CPU acima de 80%"
  fi
}

function coletar_memoria() {
  local mem_total mem_usada mem_perc
  mem_total=$(free -m | awk '/Mem:/ {print $2}')
  mem_usada=$(free -m | awk '/Mem:/ {print $3}')
  mem_perc=$(awk "BEGIN {printf \"%.0f\", $mem_usada / $mem_total * 100}")
  echo "Uso de memória: ${mem_usada}MB / ${mem_total}MB (${mem_perc}%)"
  if (( mem_perc > 80 )); then
    echo "[ALERTA] Uso de memória acima de 80%"
  fi
}

function coletar_disco() {
  local disco_perc
  disco_perc=$(df -h / | awk 'NR==2 {gsub("%", "", $5); print $5}')
  echo "Uso de disco na raiz: ${disco_perc}%"
  if (( disco_perc > 80 )); then
    echo "[ALERTA] Uso de disco acima de 80%"
  fi
}

function gerar_relatorio() {
  echo "[$DATA] Coleta de monitoramento" | tee -a "$LOG_FILE"
  coletar_cpu | tee -a "$LOG_FILE"
  coletar_memoria | tee -a "$LOG_FILE"
  coletar_disco | tee -a "$LOG_FILE"
  verificar_apache | tee -a "$LOG_FILE"
}

gerar_relatorio
