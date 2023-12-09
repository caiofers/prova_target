# Prova Target

<div align="center">
  <img src="https://github.com/caiofers/prova_target/assets/22029338/2927a79a-43a3-437d-b690-8bb978281049">
</div>
<br>
<br>
<p align="center">
  <a href="#project">Descrição</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#requirements">Requisitos</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#prototype">Protótipos de tela</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#design_pattern">Padrão Arquitetural</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#tecnology">Tecnologias</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#screens">Telas Implementadas</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#usage">Utilização</a>
</p>

<a name='project'></a>
## ✦ Projeto
<p align="justify">
Fazer um aplicativo em Flutter que atenda os <a href="#requirements">requisitos</a> aqui listados se aproximando o máximo possível dos <a href="#prototype">protótipos</a> de tela.
</p>

<a name='requirements'></a>
## ✦ Requisitos

<p align="justify">
    <strong> Tela de login: </strong>
    Uma tela de autenticação onde o usuário é obrigado a digitar seu login e senha.
    <ul>
        <li>
            A tela deve conter:
            <ul>
                <li>Um campo de senha</li>
                <li>Um campo de texto para representar o login (username, email, etc)</li>
                <li>Um label escrito "Políticas de privacidade"</li>
            </ul>
        </li>
        <li>
            Verificar e alertar se ambos os campos de login e senha estão preenchidos:
            <ul>
                <li>O campo senha não pode ter menos que dois caracteres.</li>
                <li>O campo senha não pode ter caracteres especiais, sendo apenas possível informar 'a' até 'Z' e '0' até '9'.</li>
                <li>Ambos os campos não podem ultrapassar 20 caracteres.</li>
                <li>Ambos os campos não podem terminar com o caractere de espaço no final.</li>
                <li>Se ambas as informações estiverem preenchidas, deve ir para a próxima tela.</li>
            </ul>
        </li>
        <li>
            Ao tocar no label "Política de privacidade" uma página web direcionada para o google.com.br deve ser aberta.
        </li>
        <li>
            Opcional: Não é necessário validar as informações em uma API Externa, mas caso seja feito um mockAPI contara como um diferencial.
        </li>
    </ul>
</p>

<p align="justify">
    <strong> Tela de captura de informações: </strong>
    A tela deve salvar as informações digitadas pelo usuário em um card, listando essas informações salvas e dando a opção de editar ou excluir. Essas informações não podem ser perdidas ao fechar o app, ou seja, ao abrir a tela as informações salvas anteriormente devem ser mostradas na ordem.
    <ul>
        <li>
            A tela deve conter:
            <ul>
                <li>Um card principal e central</li>
                <li>Um campo de texto</li>
            </ul>
        </li>
        <li>O foco da digitação deve estar o tempo todo no campo de "Digite seu texto" e não pode ser perdido ao interagir com a tela.</li>
        <li>Ao acionar o "enter", o campo tem que verificar se a informação foi preenchida.</li>
        <li>O Card principal deve receber a informação digitada do campo.</li>
        <li>As informações precisam ser salvas e lidas utilizando a biblioteca <a href="https://pub.dev/packages/shared_preferences" target="_blank">shared_preferences</a>.</li>
        <li>O Ícone de excluir deve abrir um pop-up confirmando a ação.</li>
        <li>Obrigatório a utilização do plugin MOBX para a construção da tela.</li>
    </ul>
</p>

<a name='prototype'></a>
## ✦ Protótipos

<div display="flex">
    <img width=250 src="https://github.com/caiofers/prova_target/assets/22029338/f04ddc25-af23-440a-a09a-f35f384d98de">
    <img width=250 src="https://github.com/caiofers/prova_target/assets/22029338/03398a05-e347-4a53-97b8-0051dc36b8df">
</div>

<a name='design_pattern'></a>
## ✦ Padrão Arquitetural

<p align="justify">
Apesar de ser um projeto simples, utilizei Clean Arquitecture como demonstração de conhecimento, mas era possível utilizar um padrão arquitetural mais simples como um MVC (Model-View-Controller). 

A vantagem de ter escolhido a arquitetura limpa é que facilitou a construção de testes unitários. Já que tudo é bem divido, foi possível criar repositório de dados para testar os casos de uso um a um.

A árvore do projeto ficou dividida da seguinte forma:

![image](https://github.com/caiofers/prova_target/assets/22029338/cee2468a-ef80-49ab-b9b8-a3bc0b1b1c48)

Basicamente tem a pasta lib/features, onde estão concentradas as features do projeto (`auth` e `text_records`):
- auth: toda parte de autenticação do usuário (feito em mock) e criação de usuário (em progresso - baixa prioridade já que não é um requisito do sistema);
- text_records: toda a parte de criação, edição e exclusão de anotações;

Dentro de cada feature, tem a seguinte estrutura de pastas:

![image](https://github.com/caiofers/prova_target/assets/22029338/cffb97f8-8841-4fb7-96e4-b09471225491)

Nessa estrutura temos, de forma resumida:

- data: Camada de dados da aplicação, é a camada que gerencia de onde dados vem e onde serão salvos;
  - models: Modelos que representam os dados em seus tipos puros, de modo a facilitar a conversão para entidade da camada de domínio e vice-versa;
  - repositories: São os repositorios que implementam um contrato (abrastact interface) da camada de domínio, eles utilizam os serviços disponíveis;
  - services: Abstrações dos dados para comunicação com um serviço externo ao app: encapsulam a lógica de comunicação com APIs externas, bancos de dados, ou outros serviços.
- domain: Camada que representa todo o negócio da aplicação, independente de frontend ou backend;
  - entities: Entidades que representam o negócio;
  - exceptions: Exceções personalizadas para atender aos problemas que podem acontecer relacionados as regras de negócios;
  - repository_protocols: Contratos que podem ser implementados pela camada de dados, de forma a padronizar o acesso;
  - usecases: Casos de uso do sistema. Funcionalidades que independe da camada de apresentação. Ex: Fazer login, Criar registro, etc.
- presentation: Camada de apresentação, tudo relacionado ao que é mostrado para o usuário.
  - screens: Telas da feature;
  - states: Gerenciamento de estados das telas (nesse projeto foi utilizado o mobx);
  - widget: Pedaços de telas que podem reutilizados.
  
</p>

<a name='tecnology'></a>
## ✦ Tecnologias

<p align="justify">
Pacotes utilizados e suas utilidades no projeto:

- cupertino_icons: Pacote de ícones no estilo do iOS;
- mobx: Gerenciamento de estado reativo;
- mobx_codegen: Geração automática de código para trabalhar com MobX. Gera código para suportar as anotações @observable, @action, @computed, etc;
- build_runner: Responsável por executar tarefas de geração de código (como mobx_codegen).
- flutter_mobx: Integração entre o Flutter e o MobX, permitindo o uso de MobX para gerenciamento de estado no Flutter.
- provider: Utilizado para injeção de dependência (DI) nesse projeto.
- url_launcher: Utilizado para abrir páginas da web (abrir a página google.com.br).
- shared_preferences: Armazenar dados de chave-valor no dispositivo usando as preferências compartilhadas.
- uuid: Gera UUIDs (Identificadores Únicos Universais). Útil quando você precisa criar identificadores exclusivos para objetos no seu aplicativo. No projeto foi usado em conjunto com o shared_preferences para salvar os dados.

</p>

<a name='screens'></a>
## ✦ Telas Implementadas
<p align="justify">
          As imagens abaixo mostram as telas implementadas no app.
</p>
<div display="flex">
  <img width=250 src="https://github.com/caiofers/prova_target/assets/22029338/ddb3c011-e526-4dcd-9141-f09ccee8ffa3">
  <img width=250 src="https://github.com/caiofers/prova_target/assets/22029338/fa4cd379-20b6-45da-a3ef-1a151332d942">
  <img width=250 src="https://github.com/caiofers/prova_target/assets/22029338/fd0c109d-69ab-4df1-8b1a-84e11d67c24e">
  <img width=250 src="https://github.com/caiofers/prova_target/assets/22029338/8f830b14-68e5-4a5b-b466-6ffe601ab8d5">
</div>

<p align="justify">
          Vídeo de demonstração:
</p>

https://github.com/caiofers/prova_target/assets/22029338/f4693204-f7ee-49d4-ab59-7984f6f8d019


<a name='usage'></a>
## ✦ Utilização

<p align="justify">
          Para começar a usar o projeto, obtenha as dependências do projeto com o comando:
</p>

```
flutter pub get
```

<p align="justify">
Agora que obtemos as dependências do projeto, basta executar o projeto com o comando:
</p>

```
flutter run
```

<p align="justify">
Atenção, no momento a autenticação não está utilizando uma API de verdade, somente uma API mock, então para fazer login utilize um dos usuários abaixo:
</p>

```
Usuário: teste
Senha: 1234
```

```
Usuário: teste2
Senha: 1234
```
