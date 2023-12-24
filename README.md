# Проект

Позволяет быстро и в автоматическом режиме запустить Jenkins в Docker'e и добавить тестовые задания UI_test и API_test с параметрами.

Так же в Docker'e поднимаются:
 - Opencart c MariaDB для полноценного запуска тестов на добавление и удаление карточки товара.
 - Selenoid с браузерами

## Как запустить:
1) Склонировать репозирорий
2) Запустить bash скрипт *start_project.sh*
    - Создастся сеть "jenkins"
    - Загрузятся необходимые для Docker образы (Jenkins, selenoid/browsers)
    - Стартует сборка jenkins контейнера
    - Загрузятся остальные образы (Selenoid, Opencart, MariaDB)
    - В jenkins добавляется задание(job) с помошью jenkins-cli.jar
3) Открыть http://localhost:8085/manage/configureTools/ и в разделе "Установки Allure Commandline" в поле "Имя" добавить: **Allure**
4) Запустить тестовые задания(job) UI_test и API_test