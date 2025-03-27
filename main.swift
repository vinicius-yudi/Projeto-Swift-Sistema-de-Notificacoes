import Foundation

// Enum para tipos de mensagem
enum TipoMensagem {
    case promocao
    case lembrete
    case alerta
}

// Struct para representar uma mensagem
struct Mensagem {
    let tipo: TipoMensagem
    let conteudo: String
}

// Protocolo Notificavel
protocol Notificavel {
    var mensagem: Mensagem { get set }
    var prioridade: PrioridadeNotificacao { get set }

    func enviarNotificacao()
}

// Enum para prioridade de notificação (Desafio Adicional)
enum PrioridadeNotificacao {
    case baixa
    case media
    case alta
}

// Protocol Extension com implementação padrão
extension Notificavel {
    func enviarNotificacao() {
        print("Enviando notificação genérica...")
    }

    func prefixoPrioridade() -> String {
        switch prioridade {
        case .alta:
            return "URGENTE! "
        case .media:
            return "Importante: "
        case .baixa:
            return ""
        }
    }
}

// Struct para Email
struct Email: Notificavel {
    var mensagem: Mensagem
    var prioridade: PrioridadeNotificacao
    let enderecoEmail: String

    func enviarNotificacao() {
        let prefixo = prefixoPrioridade()
        print("\(prefixo)Enviando email para \(enderecoEmail): [\(mensagem.tipo)] \(mensagem.conteudo)")
    }
}

// Struct para SMS
struct SMS: Notificavel {
    var mensagem: Mensagem
    var prioridade: PrioridadeNotificacao
    let numeroTelefone: String

    func enviarNotificacao() {
        let prefixo = prefixoPrioridade()
        print("\(prefixo)Enviando SMS para \(numeroTelefone): [\(mensagem.tipo)] \(mensagem.conteudo)")
    }
}

// Struct para PushNotification
struct PushNotification: Notificavel {
    var mensagem: Mensagem
    var prioridade: PrioridadeNotificacao
    let tokenDispositivo: String

    func enviarNotificacao() {
        let prefixo = prefixoPrioridade()
        print("\(prefixo)Enviando push para dispositivo \(tokenDispositivo): [\(mensagem.tipo)] \(mensagem.conteudo)")
    }
}

// Função para filtrar canais (Desafio Adicional)
func filtrarCanais<T: Notificavel>(_ canais: [Notificavel], tipo: T.Type) -> [T] {
    return canais.compactMap { $0 as? T }
}


func main() {
    // Criando algumas mensagens
    let mensagemPromocao = Mensagem(tipo: .promocao, conteudo: "Oferta especial do Samsung S24 Ultra apenas hoje!")
    let mensagemLembrete = Mensagem(tipo: .lembrete, conteudo: "Não se esqueça da reunião às 15h")
    let mensagemAlerta = Mensagem(tipo: .alerta, conteudo: "Sua assinatura expira em 3 dias")
    let mensagemAlerta2 = Mensagem(tipo: .alerta, conteudo: "Sua conta foi bloqueada por excesso de tentativas de login")
    let mensagemAlerta3 = Mensagem(tipo: .alerta, conteudo: "Sua conto Google foi conectada com sucesso")

    // Criando canais de notificação
    let email1 = Email(mensagem: mensagemPromocao, prioridade: .media, enderecoEmail: "viniciusYudi@gmail.com")
    let email2 = Email(mensagem: mensagemAlerta, prioridade: .alta, enderecoEmail: "Giordano@gmail.com")
    let sms1 = SMS(mensagem: mensagemLembrete, prioridade: .baixa, numeroTelefone: "+5541987091400")
    let push1 = PushNotification(mensagem: mensagemAlerta2, prioridade: .alta, tokenDispositivo: "Iphone007")
    let push2 = PushNotification(mensagem: mensagemAlerta3, prioridade: .media, tokenDispositivo: "Motorola123")

    // Criando array de notificáveis
    let canaisNotificacao: [Notificavel] = [email1, email2, sms1, push1, push2]

    // Enviando notificações para todos os canais
    print("\n====== Enviando notificações para todos os canais ====== \n")
    for canal in canaisNotificacao {
        canal.enviarNotificacao()
    }

    // Filtrando apenas emails (Desafio Adicional)
    let emails = filtrarCanais(canaisNotificacao, tipo: Email.self)
    print("\n====== Filtrando apenas emails ====== \n")
    for email in emails {
        email.enviarNotificacao()
    }

    // Criando uma nova mensagem e atribuindo a um canal
    print("\n====== Criando e enviando nova mensagem ====== \n")
    let novaMensagem = Mensagem(tipo: .lembrete, conteudo: "Novo lembrete: Débito Automático da sua fatura será amanhã")
    let novoEmail = Email(mensagem: novaMensagem, prioridade: .media, enderecoEmail: "victor@gmail.com")
    novoEmail.enviarNotificacao()
}

// Executando o programa
main()