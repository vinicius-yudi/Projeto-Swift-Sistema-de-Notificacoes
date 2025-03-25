
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

