# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Copia csproj e restaura dependências
COPY *.csproj ./
RUN dotnet restore

# Copia todo o código e builda
COPY . ./
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Comando de entrada
ENTRYPOINT ["dotnet", "teste_gcp.dll"]
