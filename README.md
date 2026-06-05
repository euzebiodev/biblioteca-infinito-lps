# Biblioteca Infinito - LPs

Projeto estatico das paginas de LPs publicadas no servidor local `192.168.0.236`.

Tambem pode ser publicado no GitHub Pages em:

```text
https://euzebiodev.github.io/biblioteca-infinito-lps/
```

## Estrutura

- `index.html` - indice principal da biblioteca.
- `cosmos/` - pagina do LP `The Music of Cosmos`.
- `madonna/` - pagina da artista Madonna.
- `madonna/like-a-prayer/` - pagina do LP `Like a Prayer`.
- `qrcodes/` - QR codes para acesso pelo celular.

## Publicacao no servidor

O conteudo deste repositorio representa o webroot do Nginx em `/var/www/html`.
Para publicar alteracoes no servidor local, rode:

```powershell
.\scripts\publish-to-server.ps1
```

O script envia os arquivos para `192.168.0.236` usando `pscp` e reinicia o Nginx.

## Publicacao no GitHub Pages

O site usa caminhos relativos para funcionar tanto no servidor local quanto no GitHub Pages.
A publicacao no GitHub Pages deve usar a branch `main` e a pasta raiz `/`.

## CI/CD Jenkins

O servidor `192.168.0.236` tem o job Jenkins `biblioteca-infinito-lps-cd`.
Ele observa somente a branch `main` por polling SCM a cada 5 minutos.

Fluxo:

1. commit e push em `main`;
2. Jenkins baixa o `Jenkinsfile`;
3. valida os arquivos principais;
4. publica o conteudo em `/var/www/html`;
5. testa e recarrega o Nginx.

Commits em outras branches nao sao publicados.

## Novas paginas

Para adicionar um novo LP, crie uma pasta no formato:

```text
artista/nome-do-lp/index.html
```

Quando a pagina nao tiver artista unico, use uma pasta direta:

```text
nome-do-lp/index.html
```
