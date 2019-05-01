exit 1;


# Criar um container com MONGODB
# Nome do container c_mongo (--name)
# Mapeia a pasta mongodb do host como a pasta /data/db do container para salvar os dados mesmo que o contaier morra
# Executa de forma independente (-d)
docker run --name c_mongo -v $PWD/mongodb:/data/db --rm -d mongo

# Executar NPM Install
# Executa de forma iterativa (-it)
# Mapeia o código node (node-rest-example) para dentro do container (-v)
# Define a pasta do código node como o diretório de trabalho (-w)
# Executa o comando `npm install` dentro do container do `node`
docker container run --rm  -it -v $PWD/node-rest-example:/usr/src/app -w /usr/src/app node npm install

# Subir o servidor Node.js
# Nome do container node_server (--name)
# Mapeia o código node (node-rest-example) para dentro do container (-v)
# Define a pasta do código node como o diretório de trabalho (-w)
# Executa de forma independente (-d)
# Mapeia a porta 8080 do host para a porta 3000 (padrão no nodejs) do container
# Executa o comando `npm run start` dentro do container do `node`
docker container run --rm --name node_server -v $PWD/node-rest-example:/usr/src/app -w /usr/src/app -d -p 8080:3000 node npm run start

# Inspeciona os drivers de rede do container c_mongo procurando pelo ip na rede bridge
docker container inspect c_mongo -f "{{".NetworkSettings.Networks.bridge.IPAddress"}}"


# Insere um minicurso pela API Rest usando um POST via cURL
curl -X POST -d '{"name":"docker-worshop" , "description":"the best WS public of all opensanca events"}' http://localhost:8080/minicursos

# Lista todos os minicursos
curl -X GET http://localhost:8080/minicursos

# Lista minicurso com ID_MINICURSO
ID_MINICURSO="5cca1daed766790010b11f8a"
curl -X GET http://localhost:8080/minicursos/$ID_MINICURSO


# Remove minicurso com ID_MINICURSO
ID_MINICURSO="5cca1daed766790010b11f8a"
curl -X DELETE http://localhost:8080/minicursos/$ID_MINICURSO


# Para o container antigo do Server Node (e apaga por causa da flag --rm)
docker container stop node_server

# Garante que o container foi apagado
docker rm -f node_server

# Subir o servidor Node.js
# Nome do container node_server (--name)
# Linka o container c_mongo (--link)
# Mapeia o código node (node-rest-example) para dentro do container (-v)
# Define a pasta do código node como o diretório de trabalho (-w)
# Executa de forma independente (-d)
# Mapeia a porta 8080 do host para a porta 3000 (padrão no nodejs) do container
# Executa o comando `npm run start` dentro do container do `node`
docker container run --rm --name node_server --link c_mongo -v $PWD/node-rest-example:/usr/src/app -w /usr/src/app -d -p 8080:3000 node npm run start


docker build -t opensanca/minicurso-server:devconf19 node-rest-example/.


# Subir o servidor Node.js
# Nome do container node_server (--name)
# Linka o container c_mongo (--link)
# Executa de forma independente (-d)
# Mapeia a porta 8080 do host para a porta 3000 (padrão no nodejs) do container
# Inicia o container baseado na imagem com nosso código do server (opensanca/minicurso-server:devconf19)
docker container run --rm --name node_server --link c_mongo -d -p 8080:3000 opensanca/minicurso-server:devconf19