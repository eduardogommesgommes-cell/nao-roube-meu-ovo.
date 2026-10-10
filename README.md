# Não Roube Meu Ovo — Versão Memes BR
Protótipo inicial para Roblox Studio (Luau).

## O que este protótipo faz
- Gera uma pista reta com cinco zonas de dificuldade coloridas.
- Cria uma área inicial e uma área de incubadora/coleção, usando pods de exposição em vez de cercados de madeira.
- Cria 10 personagens-tema como placeholders visuais (modelos simples, não personagens de meme copiados).
- Adiciona um menu básico com Solo e Multiplayer como escolhas de intenção.
- Inclui um protótipo de roubar um ovo e ser perseguido por um personagem placeholder na zona fácil.

## Limitação importante
O botão Solo/Multiplayer deste primeiro protótipo é uma escolha de interface; não cria servidores privados nem separa jogadores automaticamente. Isso exige uma implementação de matchmaking/teleporte e testes no Roblox Studio. Os personagens são placeholders simples e precisam ser substituídos por modelos próprios/importados com permissões adequadas.

## Como instalar no Roblox Studio
É necessário Windows ou macOS com Roblox Studio:
1. Crie um projeto Baseplate.
2. Em `ServerScriptService`, crie um Script chamado `GameBootstrap` e cole o conteúdo de `src/GameBootstrap.server.lua`.
3. Em `StarterPlayer > StarterPlayerScripts`, crie um LocalScript chamado `GameUI` e cole o conteúdo de `src/GameUI.client.lua`.
4. Pressione Play para testar.
5. Para publicar, use File > Publish to Roblox As... no Studio.

## Controles do protótipo
- Aproximar-se do ovo dourado na zona Fácil e pressionar E (PC) ou usar o prompt na tela.
- O personagem placeholder vai perseguir o jogador enquanto ele carrega o ovo.
- Chegar ao ponto de entrega inicial para marcar uma entrega.

## Nota sobre celular
O Roblox Studio oficial não roda no Android. Não instale aplicativos desconhecidos que prometam ser o Roblox Studio móvel.
