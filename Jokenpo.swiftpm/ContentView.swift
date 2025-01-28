import SwiftUI

enum Opcao: String, CaseIterable {
    case pedra = "🪨"
    case papel = "📄"
    case tesoura = "✂️"
}

func determinarVencedor(jogador: Opcao, computador: Opcao) -> (String, Color) {
    if jogador == computador {
        return ("Empate!", .white)
    } else if (jogador == .pedra && computador == .tesoura) ||
              (jogador == .papel && computador == .pedra) ||
              (jogador == .tesoura && computador == .papel) {
        return ("Você venceu!", .green)
    } else {
        return ("O computador venceu!", .red)
    }
}

struct ContentView: View {
    @State private var escolhaDoJogador: Opcao? = nil
    @State private var escolhaDoComputador: Opcao? = nil
    @State private var resultado: String = ""
    @State private var corResultado: Color = .white

    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea() // Fundo roxo em toda a tela
            
            VStack {
                Text("Jokenpô")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()

                HStack {
                    ForEach(Opcao.allCases, id: \.self) { opcao in
                        Button(action: {
                            escolhaDoJogador = opcao
                            escolhaDoComputador = Opcao.allCases.randomElement()!
                            let (mensagem, cor) = determinarVencedor(jogador: escolhaDoJogador!, computador: escolhaDoComputador!)
                            resultado = mensagem
                            corResultado = cor
                        }) {
                            Text(opcao.rawValue)
                                .font(.system(size: 50))
                                .frame(width: 90, height: 90)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding()

                if let jogador = escolhaDoJogador, let computador = escolhaDoComputador {
                    VStack {
                        Text("O jogador escolheu \(jogador.rawValue), e o computador \(computador.rawValue).")
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)

                        Text(resultado)
                            .font(.headline)
                            .foregroundColor(corResultado)
                            .padding()
                    }
                    .padding()
                }
            }
        }
    }
}
