# Biblioteca Infinito - LPs

Projeto estatico das paginas de LPs publicadas no servidor local `192.168.0.236`.

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

## Novas paginas

Para adicionar um novo LP, crie uma pasta no formato:

```text
artista/nome-do-lp/index.html
```

Quando a pagina nao tiver artista unico, use uma pasta direta:

```text
nome-do-lp/index.html
```
