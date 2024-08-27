# SRE DevOps - Melhoria de Performance e Resiliência da API de Transações Financeiras

## Visão Geral

Este repositório contém a implementação de melhorias para uma API de transações financeiras que enfrentava problemas de lentidão, falhas de conexão e instabilidade. As melhorias foram focadas em escalabilidade, resiliência, monitoramento e otimização de desempenho, com o objetivo de garantir uma experiência de usuário satisfatória e uma infraestrutura robusta.

## Arquitetura Original

### Problemas Identificados
- **Escalabilidade Limitada:** A aplicação era executada em um único pod, o que criava gargalos e limitava a capacidade de escalonamento automático.
- **Falta de Redundância:** A ausência de replicação e failover para o Ingress Controller e o banco de dados resultava em downtime durante falhas.
- **Monitoramento Insuficiente:** A infraestrutura não possuía ferramentas adequadas para monitoramento em tempo real e análise centralizada de logs.
- **Desempenho Degradado:** Conexões ao banco de dados PostgreSQL não otimizadas, resultando em lentidão e falhas de conexão.

## Arquitetura Melhorada

### Melhoria 1: Escalabilidade e Redundância
- **Solução Implementada:** Múltiplos pods foram introduzidos para a aplicação, com escalonamento automático via Horizontal Pod Autoscaler (HPA) e balanceamento de carga.
- **Benefícios:** A aplicação agora pode escalar horizontalmente para lidar com aumentos de demanda, além de oferecer redundância para evitar pontos de falha únicos.

### Melhoria 2: Resiliência e Tolerância a Falhas
- **Solução Implementada:** Réplicas foram configuradas para o Ingress Controller e o banco de dados PostgreSQL, com replicação assíncrona e uma réplica de leitura.
- **Benefícios:** Maior resiliência e disponibilidade, com failover automático em caso de falha e distribuição da carga de leitura para reduzir a latência.

### Melhoria 3: Monitoramento e Observabilidade
- **Solução Implementada:** Integração de Prometheus e Grafana para monitoramento em tempo real e stack ELK (Elasticsearch, Logstash, Kibana) para centralização de logs.
- **Benefícios:** Visibilidade total sobre a performance da aplicação, facilitando a identificação proativa de problemas e permitindo uma resolução mais rápida.

### Melhoria 4: Otimização de Conexão e Desempenho
- **Solução Implementada:** Otimização das conexões de banco de dados e implementação de cache Redis para acelerar as respostas das consultas SQL.
- **Benefícios:** Melhoria significativa nos tempos de resposta da aplicação, reduzindo a latência e melhorando a experiência do usuário.

### Melhoria 5: Load Balancers para Alta Disponibilidade
- **Solução Implementada:** Introdução de Load Balancers externos para gerenciar o tráfego de entrada, distribuindo-o entre os pods e zonas de disponibilidade.
- **Benefícios:** Garantia de alta disponibilidade e operação eficiente da aplicação, mesmo sob alta demanda ou em caso de falha em uma zona de disponibilidade.
