# Этап сборки
FROM dart:stable AS build

WORKDIR /app

# Разрешаем зависимости приложения.
COPY pubspec.* ./
RUN dart pub get

# Копируем исходный код и AOT компилируем его.
COPY . .

# Строим продакшн-версию.
RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

# Убедимся, что пакеты актуальны.
RUN dart pub get --offline
RUN dart compile exe build/bin/server.dart -o build/bin/server

# Этап минимального образа для запуска
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/build/bin/server /app/bin/
COPY --from=build /app/build/public /public/

# Стартуем сервер.
CMD ["/app/bin/server"]
