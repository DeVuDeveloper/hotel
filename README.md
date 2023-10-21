# Hotel Appli

The Hotel App is a modern Ruby on Rails web application designed for seamless hotel management, efficient user experience, and comprehensive reservation management. It features cutting-edge technologies including Rails Hotwire, Stimulus ad Vite ensuring dynamic interactions and responsiveness. The application includes an intuitive user registration and login system, empowering users to book hotel rooms hassle-free. Notably, the app boasts a robust admin panel for efficient hotel, room, and booking management.

## Screenshots

<div style="">
  <img src="app/assets/images/screen1.png" alt="hotel 1" width="30%">

</div>

## Features

- **User Registration:** Users can effortlessly sign up for an account using their email and password, gaining access to a range of features.
- **User Login:** Registered users can quickly log in using their credentials, providing a seamless user experience.
- **User Bookings:** Logged-in users can conveniently browse and book hotel rooms with ease.
- **Modern Admin Panel:** The application includes a state-of-the-art admin panel, offering efficient management of hotels, rooms, and bookings.
- **Role-Based Access Control:** Authorization is implemented using role-based access control, granting admin users exclusive management privileges.
- **Multilingual Support:** The application is equipped with Internationalization (i18n) capabilities, ensuring language translations for diverse user bases.
- **Sleek Styling:** Tailwind CSS is employed to craft a visually appealing and responsive user interface, elevating the overall user experience.

## Additional Features

- **Notification and Push Notification Management:** Admin users can send notifications and push notifications to users.
- **User-Generated Reviews:** Users can create and submit reviews for hotels.
- **Chatbot for Support Tickets** The app includes a chatbot for handling support tickets and user queries.
- **Newsletter Management:** Admins can send newsletters to users.
- **Elastic-Search:** Admins can send newsletters to users.(disabled for production)


## Installation


1. Clone the repository:

```bash
 git clone https://github.com/DeVuDeveloper/hotel.git
```

2. Install the required gems:

```bash
 bundle install
 bin/setup
```

3. Set up the database:

```bash
  rails db:create
  rails db:migrate
  rails db:seed
```

4. Start redis and run sidekiq:

```bash
  redis-server
  bundle exec sidekiq
```

5. Run the server(Open your Browser and navigate to url: http://localhost:5100/): 

```bash
  bin/dev
```


## Dependencies

The Hotel App relies on the following main dependencies:

- Ruby on Rails: The web application framework used to build the app.
- Devise: A flexible authentication solution for Rails.
- Tailwind CSS: A utility-first CSS framework for styling the app.

## Linter

The Hotel App includes a linter. You can run the linter with the following command:

```bash
  rake standard && rake standard:fix
  npm run lint && npm run lint:fix
```

## Tests

The Hotel App includes a test suite using RSpec. You can run the tests with the following command:

```bash
  rspec spec
```

## Usage

1. Open your web browser and navigate to [http://localhost:5100/](http://localhost:3000/).
2. You will see the homepage with options to register and log in.
3. Click on "Register" to create a new user account.
4. After registering, you will be redirected to the login page.
5. Log in using your registered email and password.
6. Once logged in, you can view the available hotels, their rooms, and make bookings.
7. To access the admin panel, you need to have an admin account. You can create an admin account using the Rails console or seeds (if implemented).
8. Log in with the admin account to access the admin panel.
9. In the admin panel, you can manage hotels, rooms, and bookings, newsletters, send notifications and push-notifications and manage guests and payment.


## Built With 🔨

<div align="center">

|     | Languages                                                                                                                                                                                                                                                                                                                  |     |
| --- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
|     | ![Ruby](https://img.shields.io/badge/-Ruby-000000?style=flat&logo=ruby&logoColor=red)![Ruby on Rails](https://img.shields.io/badge/-Ruby_on_Rails-000000?style=flat&logo=ruby-on-rails&logoColor=blue)![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)!![JavaScript](https://img.shields.io/badge/javascript-%23316192.svg?style=for-the-badge&logo=javascript&logoColor=white)![Stimulus](https://img.shields.io/badge/Stimulus-%23316192.svg?style=for-the-badge&logo=javascript&logoColor=white) |

<div align="center">


|     | Tools 🛠️                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |     |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
|     | ![RSpec](https://img.shields.io/badge/RSpec-%23FF5545.svg?style=for-the-badge&logo=ruby&logoColor=white)![Jest](https://img.shields.io/badge/Jest-%23C21325.svg?style=for-the-badge&logo=jest&logoColor=white)![Redis](https://img.shields.io/badge/Redis-%23DC382D.svg?style=for-the-badge&logo=redis&logoColor=white)![Sidekiq](https://img.shields.io/badge/Sidekiq-%23CC0000.svg?style=for-the-badge&logo=sidekiq&logoColor=white)![Elasticsearch](https://img.shields.io/badge/Elasticsearch-%2343B02A.svg?style=for-the-badge&logo=elasticsearch&logoColor=white)![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white) ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white) ![Markdown](https://img.shields.io/badge/markdown-%23000000.svg?style=for-the-badge&logo=markdown&logoColor=white) ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white) |     |

<p align="right">(<a href="#top">back to top</a>)</p>
</div>

## Authors ✍️

<div align="center">

| 👤 DeVuDeveloper|
| -------- |

| <a target="_blank" href="https://github.com/DeVuDeveloper"><img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="Github profile"></a> <a target="_blank" href="https://www.linkedin.com/in/devuj/"><img src="https://img.shields.io/badge/-LinkedIn-0077b5?style=for-the-badge&logo=LinkedIn&logoColor=white" alt="Linkedin profile"></a> <a target="_blank" href="https://twitter.com/DejanVuj"><img src="https://img.shields.io/badge/-Twitter-1DA1F2?style=for-the-badge&logo=Twitter&logoColor=white" alt="Twitter profile"></a>
|

</div>

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or create a pull request.

## License

The Hotel App is open-source software licensed under the MIT License.

## Acknowledgments

- The Hotel App was created as a project for learning Ruby on Rails, Devise, and Tailwind CSS.
- Thanks to the creators and maintainers of the Ruby on Rails, Devise, and Tailwind CSS projects for their amazing work.

## Contact

For any inquiries or questions, you can reach me at dejanvu.developer@gmail.com.

Happy booking!

