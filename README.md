[![GitHub contributors](https://img.shields.io/github/contributors/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/graphs/contributors)
[![GitHub forks](https://img.shields.io/github/forks/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/forks)
[![GitHub Repo stars](https://img.shields.io/github/stars/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/issues)

# OnTrack (Back end Repo)



## About This Project
### Important to Note
This is an SOA app and needs both this repo (back end) AND [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/ontrack-2305/ontrack_fe) (front end) in order to be fully functioning.

### Mod 3 Group Consultancy Project
OnTrack is a .... Designed for ...... OnTrack has the ability for registered users to ..... 
                                                  <br><br>
                    <img src="LOGO GOES HERE" width="600" height="400">
                    
## Purpose

The purpose of the backend for the OnTrack app is to support the overall functionality and effectiveness of the front end application. Here are some key purposes of the backend in relation to the project:

<b><u>Data management:</u></b> The backend serves as the central hub for storing, organizing, and managing the data associated with tasks, AI generated task breakdowns, and upcoming holiday information. It provides the necessary infrastructure, database, and endpoints for the front end app.

<b><u>User-generated content management:</u></b> The backend handles the CRUD functionality of tasks. . . . . 
It ensures efficient data handling and metadata management. The backend enables users to . . . . .enriching the platform's content and helping its users.

<b><u>Community interaction and engagement:</u></b>
UHHHH. . . . . . 

Overall, the purpose of the back end in the OnTrack app is to support seamless data management and AI task prompts. It plays a vital role in ensuring the app's functionality, security, and user satisfaction, ultimately enhancing the daily lives of its users.

## Built With
* ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
* ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
* ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
* ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
* ![Heroku](https://img.shields.io/badge/heroku-%23430098.svg?style=for-the-badge&logo=heroku&logoColor=white)
* ![Postman Badge](https://img.shields.io/badge/Postman-FF6C37?logo=postman&logoColor=fff&style=for-the-badge)

WHAT ELSE????


## Running On
  - Rails 7.0.6
  - Ruby 3.2.2

## <b>Getting Started</b>

To get a local copy, follow these simple instructions

### <b>Installation</b>

1. Fork the Project
2. Clone the repo 
``` 
git clone git@github.com:your_username/ontrack_be.git 
```
3. Install the gems
```
bundle install
```
4. Create the database
```
rails db:{create,migrate}
```
5. Get API keys from Google and OpenAI<br>
[![Google](https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white) ](https://developers.google.com/maps)
[![OpenAI Badge](https://img.shields.io/badge/OpenAI-412991?logo=openai&logoColor=fff&style=for-the-badge)](https://platform.openai.com/)<br>

6. Add your keys to your credentials file like this:
```
- Run this command to open your credentials file:
  EDITOR="code --wait" bin/rails credentials:edit
  
- Add your API key to the credentials file, formatted something like this:
  openai:
    api_key: YOUR_API_KEY_HERE
  
- You can then call on this API key anytime like this!:
  Rails.application.credentials.openai[:api_key]
```
8. Create your Feature Branch 
```
git checkout -b feature/AmazingFeature
```
9. Commit your Changes 
```
git commit -m 'Add some AmazingFeature' 
```
10. Push to the Branch 
```
git push origin feature/AmazingFeature
```
11. Open a Pull Request

## Endpoints Used

<div style="overflow: auto; height: 200px;">
  <pre>
    <code>
    get 'api/v1/users/:id/tasks' - A user's task index 
    post 'api/v1/users/:id/tasks - Create a task for a specific user
    patch 'api/v1/users/:id/tasks/:id - Edit a user's task
    delete 'api/v1/users/:id/tasks/:id - Delete a user's task
    get 'api/v1/users/:id' - User's show page/dashboard
    get 'api/v1/holidays' - Gets upcoming holidays
    get 'api/v1/chat_service' - AI breakdown of a task
    </code>
  </pre>
</div>

## Response
```
Task Response
{
 'data': [
   {
    'id': '23'
    'type': 'task'
    'attributes': {
     'name': string,
     'type': integer,
     'mandatory': boolean,
     'event_date': datetime, optional,
     'frequency': integer,
     'time_needed': integer,
     'notes': string,
     'prerequisite': task_id, foreign key,
     'user_id': integer
    }
   }
  ]
 }
 
 AI Response
 "response": [
  {
          "text": ""1. Research catio designs and gather inspiration.\n2. Create a detailed plan and layout for the catio.\n3. Purchase necessary materials and tools.\n4. Build the frame and structure of the catio.\n5. Install fencing, shelves, and perches inside the catio."
      }
   ]
```

## Schema
```
  create_table 'tools', force: :cascade do |t|
    t.string 'name'
    t.integer 'type'
    t.boolean 'mandatory, default: false'
    t.datetime 'event_date, optional: true'
    t.integer 'frequency'
    t.integer 'time_needed'
    t.string 'notes'
    t.integer prerequisite', task_id, foreign_key: true
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
```

## Contributing  [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/ontrack-2305/ontrack_be/issues)
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

## Thoughts for future contributions:
ADD MIRO BOARD STICKY NOTES HERE

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

## API's Used
[![Google](https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white) ](https://developers.google.com/maps)<br>
[![OpenAI Badge](https://img.shields.io/badge/OpenAI-412991?logo=openai&logoColor=fff&style=for-the-badge)](https://platform.openai.com/)<br>
BADGE FOR HOLIDAYS HERE:
BADGE FOR OTHER APIS THAT I AM FORGETTING HERE:

## Authors
- Artemy Gibson [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/algibson1) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/artemy-gibson/)
- Anna Wiley [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/awiley33) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/annawiley/)
- Dani Rae Wilson [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/dani-wilson) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/daniraewilson/)
- Parker Boeing [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/ParkerBoeing) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/parker-boeing/)
- Nick Sacco [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/sicknacco) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/nick-sacco/)

## Planning Tools
- [![Miro Board](https://img.shields.io/badge/Miro-050038?style=for-the-badge&logo=Miro&logoColor=white)](https://miro.com/app/board/uXjVMmKnWLE=/?share_link_id=729961862050)
- [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/orgs/ontrack-2305/projects/1/views/1)
- ![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white)