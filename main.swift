
import Foundation

// MARK: - Enums e Structs Básicos

/// Enum que define os diferentes tipos de mensagens que podem ser enviadas
enum TipoMensagem {
    case promocao    // Mensagens promocionais
    case lembrete    // Mensagens de lembrete
    case alerta      // Mensagens de alerta
}

/// Struct que representa uma mensagem no sistema
struct Mensagem {
    let tipo: TipoMensagem      // Tipo da mensagem
    let conteudo: String        // Conteúdo textual da mensagem
}

// MARK: - Protocolos

/// Protocolo base que define o comportamento para todos os tipos de notificação
protocol Notificavel {
    var mensagem: Mensagem { get set }                // Mensagem a ser enviada
    var prioridade: PrioridadeNotificacao { get set } // Prioridade da notificação

    func enviarNotificacao()    // Método para enviar a notificação
}

/// Enum que define os níveis de prioridade das notificações
enum PrioridadeNotificacao {
    case baixa      // Prioridade baixa
    case media      // Prioridade média
    case alta       // Prioridade alta
}

// MARK: - Extensões

/// Implementação padrão para o protocolo Notificavel
extension Notificavel {
    /// Implementação padrão do método de envio
    func enviarNotificacao() {
        print("Enviando notificação genérica...")
    }
    
    /// Retorna um prefixo baseado na prioridade da notificação
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

// MARK: - Implementações de Canais de Notificação

/// Implementação de notificação por email
struct Email: Notificavel {
    var mensagem: Mensagem
    var prioridade: PrioridadeNotificacao
    let enderecoEmail: String   // Endereço de email do destinatário
    
    func enviarNotificacao() {
        let prefixo = prefixoPrioridade()
        print("\(prefixo)Enviando email para \(enderecoEmail): [\(mensagem.tipo)] \(mensagem.conteudo)")
    }
}

/// Implementação de notificação por SMS
struct SMS: Notificavel {
    var mensagem: Mensagem
    var prioridade: PrioridadeNotificacao
    let numeroTelefone: String  // Número de telefone do destinatário
    
    func enviarNotificacao() {
        let prefixo = prefixoPrioridade()
        print("\(prefixo)Enviando SMS para \(numeroTelefone): [\(mensagem.tipo)] \(mensagem.conteudo)")
    }
}

/// Implementação de notificação push
struct PushNotification: Notificavel {
    var mensagem: Mensagem
    var prioridade: PrioridadeNotificacao
    let tokenDispositivo: String    // Token único do dispositivo
    
    func enviarNotificacao() {
        let prefixo = prefixoPrioridade()
        print("\(prefixo)Enviando push para dispositivo \(tokenDispositivo): [\(mensagem.tipo)] \(mensagem.conteudo)")
    }
}

// MARK: - Funções Auxiliares

/// Função genérica para filtrar canais de notificação por tipo
func filtrarCanais<T: Notificavel>(_ canais: [Notificavel], tipo: T.Type) -> [T] {
    return canais.compactMap { $0 as? T }
}

// MARK: - Função Principal

/// Função principal que demonstra o uso do sistema
func main() {
    // Criando mensagens de exemplo
    let mensagemPromocao = Mensagem(tipo: .promocao, conteudo: "Oferta especial do Samsung S24 Ultra apenas hoje!")
    let mensagemLembrete = Mensagem(tipo: .lembrete, conteudo: "Não se esqueça da reunião às 15h")
    let mensagemAlerta = Mensagem(tipo: .alerta, conteudo: "Sua assinatura expira em 3 dias")
    let mensagemAlerta2 = Mensagem(tipo: .alerta, conteudo: "Sua conta foi bloqueada por excesso de tentativas de login")
    let mensagemAlerta3 = Mensagem(tipo: .alerta, conteudo: "Sua conto Google foi conectada com sucesso")

    // Criando diferentes canais de notificação
    let email1 = Email(mensagem: mensagemPromocao, prioridade: .media, enderecoEmail: "viniciusYudi@gmail.com")
    let email2 = Email(mensagem: mensagemAlerta, prioridade: .alta, enderecoEmail: "Giordano@gmail.com")
    let sms1 = SMS(mensagem: mensagemLembrete, prioridade: .baixa, numeroTelefone: "+5541987091400")
    let push1 = PushNotification(mensagem: mensagemAlerta2, prioridade: .alta, tokenDispositivo: "Iphone007")
    let push2 = PushNotification(mensagem: mensagemAlerta3, prioridade: .media, tokenDispositivo: "Motorola123")

    // Array com todos os canais de notificação
    let canaisNotificacao: [Notificavel] = [email1, email2, sms1, push1, push2]

    // Demonstração 1: Enviando todas as notificações
    print("\n====== Enviando notificações para todos os canais ====== \n")
    for canal in canaisNotificacao {
        canal.enviarNotificacao()
    }

    // Demonstração 2: Filtrando e enviando apenas emails
    let emails = filtrarCanais(canaisNotificacao, tipo: Email.self)
    print("\n====== Filtrando apenas emails ====== \n")
    for email in emails {
        email.enviarNotificacao()
    }

    // Demonstração 3: Criando e enviando uma nova notificação
    print("\n====== Criando e enviando nova mensagem ====== \n")
    let novaMensagem = Mensagem(tipo: .lembrete, conteudo: "Novo lembrete: Débito Automático da sua fatura será amanhã")
    let novoEmail = Email(mensagem: novaMensagem, prioridade: .media, enderecoEmail: "victor@gmail.com")
    novoEmail.enviarNotificacao()
}

// Execução do programa
main()
