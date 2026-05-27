# Cowgame Didatico

Aplicativo HTML/CSS/JS autocontido inspirado no Cowgame original para ensino de melhoramento genetico de bovinos de corte.

## Como abrir

Abra `index.html` diretamente no navegador, ou rode um servidor local temporario:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\dev-server.ps1"
```

Depois acesse:

```text
http://127.0.0.1:4173/
```

## Como indicar acasalamentos

1. Entre em `Rebanho` e marque touros e vacas clicando na linha ou nas caixas da primeira coluna. O botao `Selecionar candidatos` faz uma selecao inicial por indice.
2. Entre em `Acasalamentos`.
3. Use uma destas opcoes:
   - Escolha um criterio e uma estrategia, depois clique em `Gerar pares`.
   - `Aleatorio` distribui as vacas entre os touros selecionados sem ordenar.
   - `Assortativo` acasala melhores machos com melhores femeas pelo criterio escolhido.
   - `Disassortativo` acasala melhores machos com femeas de menor valor pelo criterio escolhido.
   - Para testar uma combinacao especifica, escolha um touro e uma vaca nos menus e clique em `Adicionar`.
4. Confira a lista de pares e clique em `Gerar proxima safra`.

Use `Limpar selecao` para refazer a escolha de reprodutores e `Limpar pares` para refazer apenas a lista de acasalamentos.

## Como exportar resultados

Use os botoes no topo da interface:

- `Exportar JSON`: baixa o estado completo da simulacao, incluindo resumo, historico, eventos, feedback, pares pendentes, animais ativos e todos os animais gerados.
- `Exportar CSV`: baixa uma tabela dos animais ativos, com fenotipos, EPDs, acuracias, indice, consanguinidade e valores geneticos verdadeiros.

Para coleta com alunos, peça que enviem o JSON ao final do teste. O CSV e melhor para abrir rapidamente em Excel, Google Sheets ou R.

## Publicacao no GitHub Pages

Este projeto esta pronto para GitHub Pages porque e um app estatico.

1. Crie um repositorio chamado `cowgame-sim` no GitHub.
2. Envie os arquivos desta pasta para o repositorio.
3. No GitHub, abra `Settings` > `Pages`.
4. Em `Build and deployment`, escolha `Deploy from a branch`.
5. Selecione a branch `main` e a pasta `/root`.
6. Salve. O link ficara parecido com:

```text
https://SEU-USUARIO.github.io/cowgame-sim/
```

## Modulos implementados

- Rebanho fundador com 5 touros e 50 vacas.
- Caracteristicas quantitativas correlacionadas: peso ao nascer, peso a desmama, peso ao ano, altura de quadril e marmoreio.
- Gene recessivo letal para hidrocefalia didatica, com remocao de bezerros `aa`.
- EPDs e acuracias aproximadas para fins didaticos.
- Selecao, descarte, venda e compra de touros externos.
- Acasalamento dirigido pelo aluno com alerta de parentesco, distocia e risco letal.
- Consanguinidade simplificada, depressao endogamica e bloqueio de acasalamentos de alto risco.
- Sumario de touros, graficos de tendencia, eventos e modo professor com valores geneticos verdadeiros.

## Limite importante

O Cowgame original calculava EPDs e acuracias com MTDFREML/BLUP multivariado independente da simulacao. Esta versao usa uma aproximacao em JavaScript para permitir uma experiencia interativa imediata. Para uma replica estatistica mais fiel, o proximo passo e substituir o modulo de avaliacao por um backend com BLUP multivariado real.

## Fontes usadas

- Kleibrink, K. M. (1997). Cowgame: animal breeding simulation software. Texas A&M University.
- USDA/NIFA. Cowgame: A Beef Cattle Breeding Simulation for Today's Classroom.
- ASAS 2018. Cowgames: Developing and Implementing an Online Cattle Breeding Simulation.
- NACTA Journal. Using a Computer Simulation Program for Animal Breeding Instruction.
