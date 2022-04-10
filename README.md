## Сервис знакомств Drip
Проект команды MonKeys Senior по курсу "Разработка приложений на iOS" VK Group (весна 2022) Drip

<p align="center">
  <img src="appstore.png" />
</p>

## Веб-версия

![PingPong uptime (last 30 days)](https://img.shields.io/pingpong/uptime/sp_09c2d5875746479fa2811f672e67bf72?style=flat-square)
[![Figma](https://img.shields.io/badge/https%3A%2F%2Fdrip.monkeys.team-up-green)](https://drip.monkeys.team)
[![Drip backend](https://img.shields.io/badge/drip_frontend-github_link-magenta)](https://github.com/frontend-park-mail-ru/2021_2_MonKeys)

## Экраны

* Лента
* Лайки
* Мэтчи и чаты
* Чат
* Профиль
* Редактирование профиля
* Создание профиля
* Логин и регистрация

## Команда

* Ментор: [Антон Четвертов](https://github.com/chtvrv)
* Тимлид: [Леонид Перлин](https://github.com/perlinleo) 

| Имя                                                   |    Экраны      |
|-------------------------------------------------------|--------------|
| [Леонид Перлин](https://github.com/perlinleo)     🥵 | Лента, Лайки |
| [Алексей Воякин](https://github.com/VoyakinH)  🕵️     | Мэтчи и чаты, Чат |
| [Максим Дудник](https://github.com/maksongold)        | Редактирование профиля, Создание профиля |
| [Михаил Попов](https://github.com/4Marvin2)    😭    | Профиль, Логин и регистрация |

## Дизайн
[![Figma](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)](https://www.figma.com/community/file/1018614506626829179/Drip-v.0.3)

## Бекенд

[![Drip backend](https://img.shields.io/badge/drip_backend-github_link-magenta)](https://github.com/Mon-Keys/Drip)

### ```POST``` /api/v1/auth/session

Получение куки по логину и паролю. Авторизация.

### ```DELETE``` /api/v1/session

Логаут и удаление сессии на беке.

### ```POST``` /api/v1/auth/profile

Регистрация пользователя.

### ```GET``` /api/v1/profile

Получение своего профиля по куке

### ```PUT``` /api/v1/profile

Обновление информации своего профиля по куке

### ```GET```/api/v1/feed

Получение 5 карточек своей ленты по куке

### ```POST```/api/v1/likes

Реакция на профиль в ленте или лайках

### ```GET``` /api/v1/match

Список совпадений пользователя по куке

### ```POST``` /api/v1/match

Поиск по мэтчам

### ```GET``` /api/v1/tags

Получение актуального списка тэгов

### ```POST``` /api/v1/profile/photo

Пользователь загружает фото в свой профиль. Оно конвертируется в WEBP.
Возвращает ссылку на фото.

### ```DELETE``` /api/v1/profile/photo

Пользователь удаляет фото из своего профиля

### ```GET``` /api/v1/chats/

Чаты пользователя

### ```GET``` /api/v1/chat/

Получение чата

### ```POST``` /api/v1/chat/

Отправка сообщения
