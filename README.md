# Jogo da Velha · Flutter

Um jogo da velha para duas pessoas no mesmo dispositivo, com temas de cores e uma janela desktop personalizada. O projeto nasceu como um exercício de Flutter e está passando por uma modernização para tornar as regras mais seguras, o código mais claro e a interface mais independente do gerenciamento de estado.

A proposta é evoluir a implementação original com uma arquitetura proporcional ao aplicativo: separar responsabilidades sem acrescentar camadas que o jogo ainda não precisa.

## Funcionalidades

- Partidas locais entre X e O, com alternância automática de turnos.
- Detecção de vitória e empate.
- Destaque das casas vencedoras, inclusive quando uma jogada completa mais de uma linha.
- Reinício da partida.
- Validação de jogadas, impedindo alterar casas ocupadas ou continuar uma partida encerrada.
- Avisos sobre tentativas inválidas por meio de SnackBars.
- Seleção de cores para personalizar o tema durante a partida.
- Janela desktop transparente e sem moldura, com controles de minimizar, maximizar/restaurar e fechar.

## Modernização

A atualização começou pela migração do gerenciamento de janelas para a API do `window_manager` 0.6.0. Em seguida, a implementação do jogo foi reorganizada para separar regras, estado de apresentação e widgets.

As principais mudanças foram:

- Substituição de strings e mapas usados como resultados por enums e tipos explícitos.
- Encapsulamento do estado mutável da partida, com campos privados e acesso protegido ao tabuleiro.
- Centralização das validações no domínio: a integridade da partida não depende da interface.
- Representação das tentativas como jogadas válidas ou inválidas, com motivo obrigatório para a recusa.
- Definição única das oito combinações vencedoras, compartilhada pela avaliação e pelo destaque das casas.
- Extração das antigas funções de construção em widgets com responsabilidades próprias.
- Desacoplamento de `GameCell`, que recebe seu conteúdo, destaque e callback sem acessar o Provider.
- Separação entre renderizar o estado e reagir às notificações para apresentar avisos.
- Limitação do ViewModel da partida ao escopo da tela, mantendo o tema no escopo do aplicativo.

## Arquitetura

O projeto segue uma organização inspirada em MVVM, usando Provider e ChangeNotifier para conectar a apresentação ao estado.

| Componente | Responsabilidade |
| --- | --- |
| `GameState` | Mantém o tabuleiro, valida jogadas, alterna jogadores e determina o resultado e as posições vencedoras. |
| `GameViewModel` | Recebe ações da interface, delega as regras ao modelo e notifica os widgets sobre mudanças. |
| `MainPage` | Compõe a tela e disponibiliza uma instância do ViewModel para a partida. |
| `GameBoard` | Conecta os dados da partida aos componentes do tabuleiro. |
| `GameCell` | Desenha uma casa e comunica o toque pelo callback recebido. |
| `GameStatus` | Exibe turno e resultado, além de reagir às notificações de jogadas inválidas. |
| `ThemeProvider` | Gerencia a cor selecionada para o tema. |
| `DesktopWindowControls` | Reúne os controles da janela desktop. |

O núcleo das regras usa Dart puro. Cores, bordas e demais decisões visuais ficam nos widgets. O estado da partida é mutável e encapsulado; a interface altera a partida por meio das ações do ViewModel.

## Estrutura

```text
lib/
├── main.dart                    # Inicialização, janela e provider de tema
├── app.dart                     # MaterialApp e aplicação do tema
├── models/
│   └── game_entities.dart        # Estado, regras e tipos do jogo
├── providers/
│   ├── game.dart                 # GameViewModel
│   └── theme.dart                # Preferência de tema
├── pages/
│   └── main_page.dart            # Composição e escopo da partida
└── widgets/
    ├── desktop_window_controls.dart
    ├── game_board.dart
    ├── game_cell.dart
    ├── game_status.dart
    └── theme_picker.dart
```

## Tecnologias

- Flutter e Dart — interface e regras da partida.
- Provider — disponibilização do ViewModel e do estado de tema na árvore de widgets.
- ChangeNotifier — notificação de mudanças para a apresentação.
- window_manager 0.6.0 — integração com a janela desktop.

O repositório contém as estruturas de Android, iOS, web, Windows, Linux e macOS. O build de Windows foi validado durante a modernização; a presença das demais estruturas não representa validação em todas as plataformas.

## Próximos passos

- Ajustar o layout ao espaço disponível e ao redimensionamento da janela.
- Finalizar a experiência desktop, incluindo uma área para arrastar a janela sem moldura.
- Substituir o teste de exemplo por testes das regras e das interações do jogo após a consolidação da arquitetura.

A refatoração está em andamento. A suíte de testes ainda não representa o comportamento atual do aplicativo.
