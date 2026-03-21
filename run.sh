IMAGE_NAME=calculadora-go

echo "Buildando imagem"
docker build -f arthur.Dockerfile -t $IMAGE_NAME .

echo "Limpando container"
docker rm -f calculadora 2>nul

echo "Rodando container"
docker run -d -p 8080:8080 --name calculadora $IMAGE_NAME

echo "Aguardando"
sleep 3

echo "Test API"
curl -X POST http://localhost:8080/calcular ^
  -H "Content-Type: application/json" ^
  -d "{\"operador\":\"multiplicacao\",\"op1\":7,\"op2\":6}"