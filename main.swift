
// Protocolo Notificavel definindo uma estrutura padrão para os canais de notificação
protocol Notificavel {
    var mensagem: Mensagem { get set }
    func enviarNotificacao()
}

// Enum representando as mensagens que podem ser enviadas por um canal de notificação
enum TipoMensagem {
    case promocao, lembrete, alerta
}

// Struct para a mensagem que representa 
struct Mensagem {
    var tipo: TipoMensagem
    var conteudo: String
}

// Implementação padrão para o protocolo
extension Notificavel {
    func enviarNotificacao() {
        print("Enviando notificação...")
    }
}

// Struct para cada canal de notificação
struct Email: Notificavel {
    var mensagem: Mensagem
    var enderecoEmail: String

    func enviarNotificacao() {
        print("Enviando email para \(enderecoEmail): \(mensagem.conteudo)")
    }
}

// Struct que representa o canal de notificação via SMS.
struct SMS: Notificavel {
    var mensagem: Mensagem
    var numeroTelefone: String

    func enviarNotificacao() {
        print("Enviando SMS para \(numeroTelefone): \(mensagem.conteudo)")
    }
}

//Struct que representa o canal de notificação via Push Notification.
struct PushNotification: Notificavel {
    var mensagem: Mensagem
    var tokenDispositivo: String

    func enviarNotificacao() {
        print("Enviando push para token \(tokenDispositivo): \(mensagem.conteudo)")
    }
}

// Exemplo de uso
let mensagemPromocao = Mensagem(tipo: .promocao, conteudo: "50% de desconto!")

let email = Email(mensagem: mensagemPromocao, enderecoEmail: "usuario@exemplo.com")
let sms = SMS(mensagem: mensagemPromocao, numeroTelefone: "123456789")
let push = PushNotification(mensagem: mensagemPromocao, tokenDispositivo: "token123")

email.enviarNotificacao()
sms.enviarNotificacao()
push.enviarNotificacao()
