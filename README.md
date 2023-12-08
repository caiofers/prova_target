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
TEXTO PENDENTE (Será preenchido após finalização da prova)
</p>

<a name='tecnology'></a>
## ✦ Tecnologias

<p align="justify">
TEXTO PENDENTE (Será preenchido após finalização da prova)
</p>

<a name='screens'></a>
## ✦ Telas Implementadas
<p align="justify">
          As imagens abaixo mostram as telas implementadas no app.
</p>

IMAGENS PENDENTES (Será preenchido após finalização da prova)

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
