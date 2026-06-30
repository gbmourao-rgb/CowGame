# Cowgame Didatico

Aplicativo HTML/CSS/JS autocontido inspirado no Cowgame original para ensino de melhoramento genetico de bovinos de corte.

Desenvolvido pelo Prof. Gerson Barreto Mourão, ESALQ/USP.

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

1. Entre em `Rebanho` e marque touros e vacas clicando na linha ou nas caixas da primeira coluna. Use `Marcar todos` se quiser começar com todos os animais ativos selecionados e depois desmarcar os que não serão usados.
2. Entre em `Acasalamentos`.
3. A tela mostra duas tabelas com os touros e vacas selecionados, incluindo ID, DEP para peso ao ano, acuracia, fenotipo PA e genotipo letal.
4. Use o assistente sequencial para escolher um touro e marcar as vacas que serao designadas a ele. Vacas ja designadas saem da lista dos proximos touros.
5. Acompanhe o contador `Vacas designadas: x/y | Restantes: z`.
6. Use uma destas opcoes auxiliares:
   - `Distribuir igualmente`: divide as vacas de forma equilibrada entre os touros.
   - `Designar todas a este touro`: aplica o touro atual a todas as vacas restantes.
   - `Designar N restantes`: informa um numero e designa essa quantidade ao touro atual.
   - `Gerar por estrategia`: cria pares automaticamente por criterio aleatorio, assortativo ou disassortativo.
7. Confira a lista de pares e clique em `Gerar proxima safra`.

Use `Limpar selecao` para refazer a escolha de reprodutores e `Limpar pares` para refazer apenas a lista de acasalamentos.

## Limite de 65 animais para reproducao

O simulador nao descarta animais automaticamente.

Depois da safra, o rebanho ativo pode ficar acima de 65 animais. Isso e permitido para que o aluno tenha oportunidade de avaliar e descartar manualmente. A trava acontece somente antes da proxima reproducao:

- se houver mais de 65 animais ativos, `Gerar proxima safra` fica bloqueado;
- o aluno deve vender/descartar manualmente ate deixar no maximo 65 animais ativos;
- o limite de 65 considera touros + vacas ativos;
- bezerros vivos nao sao removidos automaticamente por capacidade.

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
