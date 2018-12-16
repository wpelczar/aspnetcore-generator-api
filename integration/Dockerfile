# Build stage
FROM microsoft/dotnet:sdk AS build-env

WORKDIR /integration

# restore
COPY integration.csproj .
RUN dotnet restore

# copy src
COPY . .

# test
ENTRYPOINT [ "dotnet", "test", "--logger:\"console;verbosity=normal\""]