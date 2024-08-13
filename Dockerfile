# Etapa de construção
FROM golang:1.20-alpine AS builder

WORKDIR /app

# Copia apenas o go.mod
COPY go.mod ./

# Baixa as dependências necessárias (caso haja)
RUN go mod download

# Copia o restante do código da aplicação
COPY . .

# Compila o binário
RUN go build -o main .

# Etapa final
FROM scratch

# Copia o binário da etapa de construção
COPY --from=builder /app/main /app/main

# Define o ponto de entrada
ENTRYPOINT ["/app/main"]
