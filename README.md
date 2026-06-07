# Trabalho 03 - Linux, Shell Script e Cloud Computing

## Aluno
Cristhian Machado

## Tema
Biblioteca Digital

## Descrição do Projeto
Este trabalho simula um ambiente de DevOps para uma Biblioteca Digital. O ambiente usa Linux Ubuntu containerizado com Docker, automatiza tarefas de manutenção e deploy de um site estático no Apache, e organiza a infraestrutura de dados, backups, logs e permissões em uma estrutura temática.

## Estrutura do Projeto
- `Dockerfile` - imagem Ubuntu configurada com Apache e scripts.
- `docker-compose.yml` - orquestra o container e mapeia volumes persistentes.
- `scripts/` - scripts Shell de automação e administração.
- `source/` - site estático da Biblioteca Digital.
- `backups/` - backups gerados pelo script `04_backup.sh`.
- `logs/` - arquivos de log das rotinas e relatório final.
- `evidencias/` - pasta dedicada para evidências de execução.

## Como Executar

1. Construa e inicie o container:

```bash
docker compose up -d --build
```

2. Entre no container:

```bash
docker exec -it trabalho03-linux bash
```

3. Os scripts estão em `/app/scripts`.

## Acessando o Apache
Abra no navegador:

http://localhost:8080

## Scripts Disponíveis

| Script | Descrição |
|---|---|
| `scripts/01_update.sh` | Atualiza pacotes do sistema Ubuntu | 
| `scripts/02_apache.sh` | Instala e valida o Apache | 
| `scripts/03_estrutura.sh` | Cria a estrutura temática da Biblioteca Digital | 
| `scripts/04_backup.sh` | Realiza backup compactado do diretório da Biblioteca | 
| `scripts/05_deploy.sh` | Publica o site estático em `/var/www/html` | 
| `scripts/06_processos.sh` | Lista, busca e encerra processos | 
| `scripts/07_monitoramento.sh` | Monitora CPU, memória, disco e Apache | 
| `scripts/08_usuarios_permissoes.sh` | Cria usuário/grupo e aplica permissões | 
| `scripts/09_relatorio.sh` | Gera relatório operacional em `logs/relatorio_execucao.txt` | 
| `scripts/menu.sh` | Menu principal interativo para executar rotinas | 

## Como Executar os Scripts

Dentro do container:

```bash
cd /app/scripts
chmod +x *.sh
./menu.sh
```

Ou executar individualmente:

```bash
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./04_backup.sh
./05_deploy.sh
./06_processos.sh listar
./07_monitoramento.sh
./08_usuarios_permissoes.sh
./09_relatorio.sh
```

## Evidências
A pasta `evidencias/` está pronta para receber prints e arquivos que comprovem:
- container em execução
- volume Docker configurado
- scripts com permissão de execução
- atualização do sistema
- Apache instalado e validado
- estrutura de diretórios criada
- backup `.tar.gz` gerado
- deploy realizado para `/var/www/html`
- site acessível no navegador
- monitoramento do sistema
- usuários e permissões configurados
- relatório gerado

## Dificuldades Encontradas
- Garantir que o Apache funcione corretamente em um container Ubuntu sem init system completo.
- Ajustar permissões seguras para a estrutura temática sem usar `chmod 777`.
- Criar logs e relatórios claros que ajudem a validar cada etapa.
