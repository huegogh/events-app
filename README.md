# Events App

The **Events App** is an API to track user events on other applications.

<br>

# API Reference

<br>

## Base URL

```http
    https://floating-reef-41684.herokuapp.com
```

<br>

## Adding An Event

```http
    POST /api/v1/events
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `name` | `string` | **REQUIRED** name for the event |
| `event_type` | `string` | **REQUIRED** type of event (e.g. *click*, *view*) |
| `[any]` | `[any]` | **optional** any other *key/value* pair |

<br>

## Retrieving Summary of Today's Events

```http
    GET /api/v1/events/today
```
