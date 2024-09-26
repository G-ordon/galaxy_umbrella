# Galaxy_Umbrella

**Galaxy Umbrella** is a modular umbrella project built with **Phoenix** and **Elixir**. It focuses on providing a robust platform for managing videos and annotations, allowing users to choose videos, add comments in real-time, and playback videos with comments displayed over time, inspired by the concept of Mystery Science Theater 3000.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features
- Modular structure for easy scalability and maintenance.
- Real-time video annotation, allowing users to comment while watching.
- User authentication and authorization for secure access.
- Easy navigation and management of video records.
- Responsive design for optimal performance on various devices.

## Getting Started

These instructions will help you set up the project on your local machine for development and testing purposes.

### Prerequisites

Ensure you have the following installed:
- **Elixir** (version 1.17.0 or later)
- **Erlang** (version 26 or later)
- **PostgreSQL** (for database management)
- **Node.js** (for managing assets and JavaScript dependencies)

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/galaxy_umbrella.git
    ```

2. Navigate to the project directory:
    ```bash
    cd galaxy_umbrella
    ```

3. Install Elixir dependencies:
    ```bash
    mix deps.get
    ```

4. Install Node.js dependencies for the front-end:
    ```bash
    cd assets && npm install
    ```

5. Set up the database:
    ```bash
    mix ecto.create && mix ecto.migrate
    ```

6. Run the Phoenix server:
    ```bash
    mix phx.server
    ```

7. Open the app in your browser:
    ```
    http://localhost:4000
    ```

## Usage

- Upon opening the application, users can navigate through the video library.
- Select a video to view and interact with.
- Users can add comments in real-time while the video is playing.
- Comments can be displayed in sync with the video playback.

## Contributing

We welcome contributions to **Galaxy Umbrella**! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
    ```bash
    git checkout -b feature/my-feature
    ```
3. Commit your changes:
    ```bash
    git commit -m "Add feature"
    ```
4. Push to the branch:
    ```bash
    git push origin feature/my-feature
    ```
5. Open a pull request and describe your changes.

## License

This project is licensed under the [MIT License](LICENSE).
