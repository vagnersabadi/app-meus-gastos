# DesafioTecnicoFlutter-MeusGastos

## Desafio tecnico de Flutter - App Meus gastos

O objetivo deste teste é avaliar as habilidades do candidato em desenvolver um aplicativo para
controle de gastos.

Os protótipos de telas estão no repositório para desenvolvimento do layout.

## **Requisitos de negócio:**

- No primeiro acesso ao aplicativo, o usuário deverá fazer o registro;
- Tratamento de erros no processo de login;
- Cadastro de categorias de gastos, como:
    - Moradia (aluguel)
    - Alimentação
    - Transporte
    - Educação
- O usuário poderá cadastrar entradas e saídas de gastos;
    - Cadastrar no mínimo 2 valores, 1 entrada e 1 saída, para cada categoria.
- Possibilidade de exclusão e edição dos gastos e categorias cadastrados;
- Tratamento de erros nas requisições com o Firebase;
- Na tela de Gastos, exibir totalizadores com a soma dos valores de entrada e saída.

## **Requisitos técnicos:**

- Utilizar última versão do Flutter do Stable channel disponível
  em https://docs.flutter.dev/release/archive;
- Respeitar os princípios do SOLID;
- Boas práticas, CleanCode;
- Aplicar Design Patterns, orientação a objetos e boas práticas de programação;
- Utilizar componentização de Widgets;
- Seguir a arquitetura Clean Architecture;
- Implementar o login utilizando o Firebase;
- Utilizar o Firestore Database para registros;
- Os testes unitários são opcionais, porém recomendados.

| Não envie a solução como anexo, suba os fontes para seu Github (ou outro repositório) e envie o
link para o avaliador.

## Login

<kbd>
  <img src="docs/Login/1-Logar.png" width="200"/>
  <img src="docs/Login/2-Registrar.png" width="200"/>
</kbd>

## Categorias

<kbd>
  <img src="docs/Categorias/1-Categorias-Vazio.png" width="200"/>
  <img src="docs/Categorias/2-Categorias-Loading.png" width="200"/>
  <img src="docs/Categorias/3-Categorias.png" width="200"/>
  <br>
  <img src="docs/Categorias/4-Adicionar.png" width="200"/>
  <img src="docs/Categorias/5-Editar.png" width="200"/>
</kbd>

## Gastos

<kbd>
  <img src="docs/Gastos/1-MeusGastos-Vazio.png" width="200"/>
  <img src="docs/Gastos/2-MeusGastos-Loading.png" width="200"/>
  <img src="docs/Gastos/3-Gastos.png" width="200"/>
  <br>
  <img src="docs/Gastos/4-Lancamentos-ElementosdeTela.png" width="350"/>
  <br>
  <img src="docs/Gastos/5-AdicionarLancamento.png" width="200"/>
  <img src="docs/Gastos/6-EditarLancamento.png" width="200"/>
  <img src="docs/Gastos/7-ExemplodePicker.png" width="200"/>
</kbd>
