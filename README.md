# Projeto Swift Essencial: Sistema de Notificações (Console com POP)

## Objetivo:
Desenvolver um sistema de notificações em Swift utilizando o paradigma Protocol-Oriented Programming (POP).

## Detalhes:
- Equipe de até 5 pessoas
- Vale: 10% da média final
- Data de entrega: 30/03/2025
- Pode ser feito com compilador online (como o https://replit.com/) ou xcode

## Equipe:
* Giordano Serafini
* Victor Gabriel
* Vinicius Yudi

## Descrição
Este projeto implementa um sistema de notificações utilizando Swift e o paradigma Protocol-Oriented Programming (POP). O sistema permite enviar diferentes tipos de notificações (Email, SMS e Push Notifications) com diferentes níveis de prioridade.

## Estrutura do Código

### Tipos Básicos

#### `TipoMensagem` (Enum)
- `promocao`: Para mensagens promocionais
- `lembrete`: Para lembretes
- `alerta`: Para alertas importantes

#### `Mensagem` (Struct)
- `tipo`: Tipo da mensagem (TipoMensagem)
- `conteudo`: Conteúdo da mensagem

#### `PrioridadeNotificacao` (Enum)
- `baixa`: Prioridade baixa
- `media`: Prioridade média
- `alta`: Prioridade alta

### Protocolos

#### `Notificavel`
Protocolo base que define o comportamento para todos os tipos de notificação.

Propriedades:
- `mensagem`: A mensagem a ser enviada
- `prioridade`: Nível de prioridade da notificação

Métodos:
- `enviarNotificacao()`: Método para enviar a notificação
- `prefixoPrioridade()`: Retorna um prefixo baseado na prioridade

### Implementações

#### `Email` (Struct)
Implementa `Notificavel` para envio de emails.
- Propriedade adicional: `enderecoEmail`

#### `SMS` (Struct)
Implementa `Notificavel` para envio de SMS.
- Propriedade adicional: `numeroTelefone`

#### `PushNotification` (Struct)
Implementa `Notificavel` para envio de notificações push.
- Propriedade adicional: `tokenDispositivo`

### Funcionalidades Adicionais

#### `filtrarCanais<T: Notificavel>`
Função genérica que filtra canais de notificação por tipo.

## Execução
Para executar o projeto, utilize o comando:
```bash
swift main.swift