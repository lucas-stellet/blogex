# Blogex

## Acessando a API online

A API está disponível no endereço abaixo:

[stonex.jaspion.xyz/api](http://stonex.jaspion.xyz/api)

## Rodando localmente

Com a inenção de facilitar a iniclização e o uso da aplicação localmente, criei um setup com Docker.
Para iniciar basta ter o docker e o docker-compose instalados na sua máquina, dessa forma você tera um container Elixir/Phoenix com a aplicação e um database PostgreSQL rodando localmente.
Execute o comando abaixo e aguarde os logs mais abaixo aparecerem em seu terminal.

```bash
docker-compose up
```

```
blogex    | [info] Access BlogexWeb.Endpoint at http://localhost:4000
blogex    | [info] POST /api/account/login
```

Com esas informações em tela a sua aplicação estará funcionando e pronto para o acesso.

## Postman collection

Caso você utilize o Postman como interface para enviar requisições para API's, basta importar os arquivos presentes na pasta `postman`no diretório raiz da aplicação, dessa forma você terá acesso a uma coleção de requisições. Antes user em ambiente de desenvolvimento faça um `fork` para para o seu `workspace` e altere as variavel de ambiente para '{{dev_base_url}}`.

## Utilização da API

A API é dividida em três partes:

- Users
- Posts
- Auth/Login

### Auth/Login

**[POST]** _/api/login_

Login de usuários. Só será possível realizar as chamadas a API com o token retornado nessa chamada.

```json
Exemplo de requisição

{
  "email": "lucas@gmail.com",
  "password": "123senha"
}
```

```json
Exemplo da resposta

{
    "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9 ..."
}
```

## Posts

**[POST]** \_/api/post

Cria um novo blogpost vinculado ao ID do usuário logado via token.

```json
Exemplo de requisição

{
  "title": "Hello World",
  "content": "Hasta la vista!"
}

```

```json
Exemplo da resposta

{
    "content": "Hasta la vista!",
    "id": "b65c8181-ad8e-44ac-84e0-aa8bd84b72aa",
    "title": "Hello World",
    "userId": "1c066480-48b1-4fad-b09f-61d7085ad00c"
}
```

**[GET]** \_/api/post

Retorna todos os posts publicados dentro de um array.

```json
Exemplo da resposta

[
    {
        "content": "Almost finishing!",
        "id": "0416bdf6-3685-4038-957b-1982290f87d2",
        "title": "Latest updates, September 1st",
        "user": {
            "displayName": "Tatiane Costa",
            "email": "tatiane@gmail.com",
            "id": "09e1c619-a5d8-40b1-9aa1-231e71ba98ae",
            "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200"
        }
    },
    {
        "content": "Hasta la vista!",
        "id": "b65c8181-ad8e-44ac-84e0-aa8bd84b72aa",
        "title": "Hello World",
        "user": {
            "displayName": "Lucas Stellet",
            "email": "lucas@gmail.com",
            "id": "1c066480-48b1-4fad-b09f-61d7085ad00c",
            "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200"
        }
    }
]
```

**[GET]** \_/api/post:id

Retorna o post solicitado pelo ID.

```json
Exemplo da resposta

{
    "content": "Almost finishing!",
    "id": "0416bdf6-3685-4038-957b-1982290f87d2",
    "title": "Latest updates, September 1st",
    "user": {
        "displayName": "Tatiane Costa",
        "email": "tatiane@gmail.com",
        "id": "09e1c619-a5d8-40b1-9aa1-231e71ba98ae",
        "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200"
    }
}
```

**[GET]** \_/api/post/search?q=finishing

Busca um post via termo passado na chave `q` no `query params` presente no `title` ou no `content` do post. Caso nenhum blogpost seja encontrado com o termo enviado na requisição, um array vazio será retornado. E no caso de nenhum termo enviado para busca, todos os blogposts serão enviados.

```json
Exemplo da resposta

{
    "content": "Almost finishing!",
    "id": "0416bdf6-3685-4038-957b-1982290f87d2",
    "title": "Latest updates, September 1st",
    "user": {
        "displayName": "Tatiane Costa",
        "email": "tatiane@gmail.com",
        "id": "09e1c619-a5d8-40b1-9aa1-231e71ba98ae",
        "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200"
    }
}
```

**[PUT]** \_/api/post/:id

Atualiza um post publicado pelo usuário. Somente um post publicado pelo usuário poderá ser atualizado.

```json
Exemplo da requisição

{
  "title": "Latest updates, September 1st",
  "content": "Almost finishing!"
}
```

```json
Exemplo da resposta

{
    "content": "Almost finishing!",
    "id": "0416bdf6-3685-4038-957b-1982290f87d2",
    "title": "Latest updates, September 1st",
    "userId": "09e1c619-a5d8-40b1-9aa1-231e71ba98ae"
}
```

**[DELETE]** \_/api/post/:id

Deleta um post publicado pelo usuário. Somente um post publicado pelo usuário poderá ser deletado.
Resposta retorna com um status 204 (No Content) significando que houve a deleção.

## Users

**[POST]** \_/api/user

Cria um novo usuario e recebe como resposta um token para realizar as demais chamadas.

```json
Exemplo de requisição

{
    "email": "lucas@gmail.com",
    "display_name": "Lucas Stellet",
    "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200",
    "password": "123senha"
}

```

```json
Exemplo da resposta

{
    "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9..."
}
```

**[GET]** \_/api/user

Retorna todos os uusários cadastrados dentro de um array.

```json
Exemplo da resposta

[
    {
        "displayName": "Tatiane Costa",
        "email": "tatiane@gmail.com",
        "id": "09e1c619-a5d8-40b1-9aa1-231e71ba98ae",
        "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200"
    },
    {
        "displayName": "Lucas Stellet",
        "email": "lucas@gmail.com",
        "id": "665d21e4-a024-4e3a-84e4-0e068776c296",
        "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200"
    }
]
```

**[GET]** \_/api/user:id

Retorna o post solicitado pelo ID.

```json
Exemplo da resposta

{
    "displayName": "Tatiane Costa",
    "email": "tatiane@gmail.com",
    "id": "09e1c619-a5d8-40b1-9aa1-231e71ba98ae",
    "image": "https://pt.gravatar.com/userimage/175440562/5741c585e445bfdde23c4c848bfde321.jpg?size=200"
}
```

**[DELETE]** \_/api/user/me

Deleta o usuário logado via token. A chamda retorna com um status 204 (No Content) significando que houve a removção do uusário corretamente.
