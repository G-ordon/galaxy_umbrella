# Galaxy Umbrella

Welcome to **Galaxy Umbrella**, a powerful modular application built with **Phoenix** and **Elixir**. This project extends the original **Galaxy App** by adding enhanced capabilities, including state management with OTP, real-time communication, and background processing tasks. The umbrella structure allows the app to scale efficiently and manage different concerns separately within sub-applications.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Key Components](#key-components)
  - [Managing State with Processes](#managing-state-with-processes)
  - [Building the Counter API](#building-the-counter-api)
  - [GenServers and OTP](#genservers-and-otp)
  - [Supervision Strategies](#supervision-strategies)
  - [Integrating with Channels](#integrating-with-channels)
- [Future Enhancements](#future-enhancements)
- [Contributing](#contributing)
- [License](#license)

## Overview

**Galaxy Umbrella** is an umbrella application that builds upon the Galaxy App, introducing advanced features using Elixir’s OTP (Open Telecom Platform). It incorporates a variety of real-time, fault-tolerant services managed through different sub-apps. These include GenServers for state management, supervision trees for fault tolerance, and Phoenix channels for real-time updates, making the app scalable and highly interactive.

### How It Works

- **Process Management:** The app manages state using OTP processes (GenServers) for real-time data handling.
- **API and Channels:** Exposes an API for external communication and uses channels for real-time, multi-user interactions.
- **Task Supervision:** Background tasks are handled via `Task.Supervisor` to manage long-running operations without blocking the main application flow.

## Features

- **OTP Integration:** Robust state management using OTP processes for fault tolerance and efficiency.
- **Real-Time WebSockets:** Enable real-time updates and communication through Phoenix Channels.
- **Background Tasks:** Use Elixir Tasks to perform asynchronous operations like fetching data from external services.
- **Scalable Architecture:** Modular structure through Phoenix’s umbrella application design, making it easy to scale different components.
- **API Access:** Provide REST and WebSocket API endpoints for interaction with external systems.

## Technology Stack

**Galaxy Umbrella** is built on a foundation of modern and robust technologies:
- **Elixir:** Functional, concurrent programming language known for fault tolerance and scalability.
- **Phoenix Framework:** High-performance web development framework built on Elixir, with real-time features.
- **OTP:** Provides the underlying system for concurrency, fault tolerance, and distribution.
- **Ecto:** Database layer that supports complex queries and migrations with PostgreSQL.
- **Phoenix Channels:** Real-time WebSocket-based communication for live updates between users.

## Getting Started

To get started with **Galaxy Umbrella**, follow the instructions below.

### Prerequisites

Ensure you have the following installed:
- **Elixir** (version 1.17.0 or higher)
- **Erlang** (version 26 or higher)
- **PostgreSQL** (database for application storage)
- **Node.js** (for handling front-end assets)

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/G-ordon/galaxy_umbrella.git
    ```

2. **Navigate to the project directory:**
    ```bash
    cd galaxy_umbrella
    ```

3. **Install dependencies:**
    ```bash
    mix deps.get
    ```

4. **Install Node.js dependencies:**
    ```bash
    cd assets && npm install
    ```

5. **Set up the database:**
    ```bash
    mix ecto.create && mix ecto.migrate
    ```

6. **Run the Phoenix server:**
    ```bash
    mix phx.server
    ```

7. **Visit the app:**
    Open your browser at `http://localhost:4000`.

## Usage

- Use the application to manage real-time interactions, handle background processes, and display data fetched asynchronously.
- The **API** enables external services to connect and interact with the application through both REST and WebSocket endpoints.
- The application makes heavy use of **Phoenix Channels** to handle multi-user environments and live updates.

## Key Components

### Managing State with Processes

Using **GenServers**, the application manages stateful processes efficiently. Each process is independent and can be restarted automatically if it fails, thanks to OTP's fault-tolerant capabilities.

### Building the Counter API

A simple counter service is implemented as an example, where clients can increment and retrieve the current count via REST or WebSockets.

### GenServers and OTP

**GenServers** handle the bulk of background operations and state management. The OTP framework ensures that processes are monitored and can be restarted if necessary.

### Supervision Strategies

OTP **Supervisors** are used to monitor processes, applying a one-for-one strategy to restart failed processes without affecting the entire application.

### Integrating with Channels

Phoenix **Channels** are used for real-time communication, allowing multiple users to interact with the application simultaneously and receive live updates without refreshing the page.

## Future Enhancements

- **Advanced Task Scheduling:** Implement custom task schedulers for time-based background operations.
- **API Rate Limiting:** Add rate-limiting features for public API endpoints.
- **User Roles and Permissions:** Implement role-based access control (RBAC) for user management.

## Contributing

Contributions to **Galaxy Umbrella** are welcome. If you’d like to contribute:
1. **Fork the repository.**
2. **Create a new branch for your feature or bug fix:**
    ```bash
    git checkout -b feature/my-feature
    ```
3. **Commit your changes:**
    ```bash
    git commit -m "Add new feature"
    ```
4. **Push to your branch:**
    ```bash
    git push origin feature/my-feature
    ```
5. **Create a pull request.**

## License

This project is licensed under the [MIT License](LICENSE). Please see the LICENSE file for details.
