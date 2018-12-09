# Build stage
FROM microsoft/dotnet:sdk AS build-env

WORKDIR /generator

# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# copy src
COPY . .

# test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test ./tests/tests.csproj --logger:"console;verbosity=normal"

# publish
RUN dotnet publish api/api.csproj -o /publish

# runtime stage
FROM microsoft/dotnet:aspnetcore-runtime
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT [ "dotnet", "api.dll" ]

