
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var mensagem = ""
    @State private var destinatario = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NotificationView(tipo: .email)
                .tabItem {
                    Image(systemName: "envelope.fill")
                    Text("Email")
                }
                .tag(0)
            
            NotificationView(tipo: .sms)
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("SMS")
                }
                .tag(1)
            
            NotificationView(tipo: .push)
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Push")
                }
                .tag(2)
        }
    }
}

struct NotificationView: View {
    enum TipoNotificacao {
        case email, sms, push
    }
    
    let tipo: TipoNotificacao
    @State private var mensagem = ""
    @State private var destinatario = ""
    @State private var tipoMensagem: TipoMensagem = .promocao
    
    var body: some View {
        VStack(spacing: 20) {
            Text(titulo)
                .font(.largeTitle)
                .padding()
            
            Picker("Tipo de Mensagem", selection: $tipoMensagem) {
                Text("Promoção").tag(TipoMensagem.promocao)
                Text("Lembrete").tag(TipoMensagem.lembrete)
                Text("Alerta").tag(TipoMensagem.alerta)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TextField(placeholderDestinatario, text: $destinatario)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Mensagem", text: $mensagem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: enviarNotificacao) {
                Text("Enviar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
    }
    
    var titulo: String {
        switch tipo {
        case .email: return "Email"
        case .sms: return "SMS"
        case .push: return "Push"
        }
    }
    
    var placeholderDestinatario: String {
        switch tipo {
        case .email: return "Email"
        case .sms: return "Número de telefone"
        case .push: return "Token do dispositivo"
        }
    }
    
    func enviarNotificacao() {
        let mensagemObj = Mensagem(tipo: tipoMensagem, conteudo: mensagem)
        
        switch tipo {
        case .email:
            let email = Email(mensagem: mensagemObj, enderecoEmail: destinatario)
            email.enviarNotificacao()
        case .sms:
            let sms = SMS(mensagem: mensagemObj, numeroTelefone: destinatario)
            sms.enviarNotificacao()
        case .push:
            let push = PushNotification(mensagem: mensagemObj, tokenDispositivo: destinatario)
            push.enviarNotificacao()
        }
        
        // Limpar campos após envio
        mensagem = ""
        destinatario = ""
    }
}
