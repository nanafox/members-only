# Members-Only (AuthPost) Project

This project is part of [The Odin Project](https://theodinproject.com)
Ruby on Rails curriculum. It demonstrates how to build a basic authentication
system and a private content-sharing platform. Users can log in and post
messages, but only authenticated users can view the authors of those messages.
The project emphasizes working with associations, validations,
and authentication in Rails.

## Features

- **User Authentication**:

  - Users can sign up, log in, and log out.
  - Passwords are securely hashed using Devise.

- **Post Management**:

  - Logged-in users can create, edit, and delete posts.
  - Public users can view posts but cannot see the post authors.

- **Authorization**:
  - Post authorship is hidden from users who are not logged in.
  - Secure routes ensure only authenticated users can access protected resources.

## Technologies Used

- **Ruby on Rails**: Backend framework for creating the application.
- **PostgreSQL**: Database for storing user and post data.
- **Devise**: For handling user authentication.
- **Action Text**: To enable rich-text editing for posts.
- **Bootstrap**: For responsive styling and design.

## Getting Started

Follow these steps to set up the project locally:

### Prerequisites

- Ruby 3.3.x
- Rails 8.0.x
- PostgreSQL
- Node.js and Yarn (for Rails asset pipeline)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/nanafox/members-only.git
   cd members-only
   ```

2. Install dependencies:

   ```bash
   bundle install
   yarn install
   ```

3. Set up the database:

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the Rails server:

   ```bash
   rails server
   ```

5. Visit the application at `http://localhost:3000`.

## Testing

The application uses Minitest for testing. To run the tests, use:

```bash
rails test test:system
```

## Future Improvements

- Implementing role-based access control (e.g., admin privileges).
- Adding pagination to handle large datasets of posts.
- Enhancing the UI/UX with more advanced CSS or frontend frameworks.

## Acknowledgments

This project was inspired by **The Odin Project**. The curriculum provides an
excellent foundation for web development and Rails expertise.
Learn more at [theodinproject.com](https://theodinproject.com).

## License

This project is open source and available under the MIT License.
See the `LICENSE` file for more details.
