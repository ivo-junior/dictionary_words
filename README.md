# dictionary_words

## Introdução

Este é um aplicativo para mostrar minhas habilidades como Mobile Developer.

Esse aplicativo tem como objetivo mostrar e gerenciar palavras em inglês, utilizando como base a API [Words API](https://www.wordsapi.com/), de acordo com o [wireframe](https://lab.coodesh.com/juniorsouzax7/dictionary/-/raw/main/img/wireframe.png).

## Tecnologias

A aplicação foi desenvolvida utilizando a linguagem de programação [dart](https://dart.dev/) e framework de desenvolvimento  cros-plataform [Flutter](https://flutter.dev/).

Além disso foi aplicado uma arquitetura baseada no [getx_patern](https://kauemurakami.github.io/getx_pattern/#estrutura) e consequentemente para biblioteca de gerência de estado o [get](https://pub.dev/packages/get). 

Aplicado padrão de CI/CD git Flow, bem como as ferramentas Git em conjunto github para repositório.

A aplicação possui uma funcionalidade de cache offline e para isso foi utilizado a biblioteca e banco de dados [Hive](https://pub.dev/packages/hive). Além disso a aplicação também faz uso do Firebase com Real Time Database para armazenamento do dicionário de palavras [existente no repositório do github](https://github.com/dwyl/english-words/blob/master/words_dictionary.json), autenticação de usuário e armazenamento de palavras favoritas.

## Instalação

**1** - Clone este repositório em sua máquina e o abra em seu IDE de preferência. Atente-se para que as seguintes tecnologias e ferramentas estejam instaladas:
[Flutter](https://flutter.dev/)
[Firebase tools](https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=android)

**2** - Rode o comando Flutter pub get

**3** - Navegue até o arquivo base_url.dar (lib/global_components/base_url.dart) e insira seu token da API do [Word API](https://www.wordsapi.com/).

**4** - Crie uma conta [Firebase](https://firebase.google.com/?hl=pt-br), adicione um novo projeto e ative as ferramentas:
	***Real Time DataBase*** - Configure-o em modo teste. Após a configuração finalizada você irá importar os dados das palavras. Baixe o [arquivo existente no repositório do github](https://github.com/dwyl/english-words/blob/master/words_dictionary.json) e edite-o pois ele retorna as palavras como nós diretor. Você irá abrir o arquivo baixado em seu IDE de preferencia e encapsule tudo em um nó chamado “words” e salve-o, o arquivo ficará no seguinte formato:
        “words”: {
            . . .
            //Palavras do arquivo padrão            
        }

Em seguida, importe o arquivo em seu Real Time database criado. Clique nos 3 pontinhos como na imagem abaixo, selecione a opção Importar o JSON e selecione o arquivo editado.

<img src="https://github.com/ivo-junior/dictionary_words/blob/main/img/import_RTDB.png" width="100%" />


**5** - Conecte seu aplicativo flutter ao Firebase rodando o comando flutterfire configure. Se possuir alguma dúvida você pode seguir o tutorial de instalação da [documentação oficial](https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=android).


**6** - Execute o projeto

**Apresentação do projeto** [Acesse aqui](https://www.loom.com/embed/1a629911f475495283ab147bee9a427d).

>  This is a challenge by [Coodesh](https://coodesh.com/)
