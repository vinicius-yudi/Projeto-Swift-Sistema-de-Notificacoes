
# Sistema de Notificações em Swift

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

## Exemplo de Uso

```swift
// Criar uma mensagem
let mensagem = Mensagem(tipo: .alerta, conteudo: "Teste")

// Criar um canal de notificação
let email = Email(
    mensagem: mensagem,
    prioridade: .alta,
    enderecoEmail: "exemplo@email.com"
)

// Enviar notificação
email.enviarNotificacao()
```

## Equipe
- Projeto desenvolvido para a disciplina Swift Essencial
- Data de entrega: 30/03/2025
- Valor: 10% da média final

## Execução
Para executar o projeto, utilize o comando:
```bash
swift main.swift
```
