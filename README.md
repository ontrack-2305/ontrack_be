[![GitHub contributors](https://img.shields.io/github/contributors/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/graphs/contributors)
[![GitHub forks](https://img.shields.io/github/forks/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/forks)
[![GitHub Repo stars](https://img.shields.io/github/stars/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/ontrack-2305/ontrack_be)](https://github.com/ontrack-2305/ontrack_be/issues)

# OnTrack (Back end Repo)



## About This Project
### Important to Note
This is an SOA app and needs both this repo (back end) AND [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/ontrack-2305/ontrack_fe) (front end) in order to be fully functioning.


### Overview
This project is built to satisfy the requirements of the Turing School of Software and Design's [Consultancy Project](https://backend.turing.edu/module3/projects/consultancy/). Students come up with their own idea for an application and build it as a group project.

OnTrack is a web application to help users improve productivity as well as mental health.

The application is designed for users who have executive dysfunction or related disorders which often have symptoms such as:
- Easily overwhelmed
- Forgetfulness 
- Difficulty making decisions

Such symptoms also often lead to low self esteem and depression, due to difficulty maintaining relationships and a healthy lifestyle.

Registered users have the ability to input items on their to-do list. In addition to standard chores, users can put in restful "tasks" and tasks related to personal hobbies.

Users are prompted to complete one task at a time. This helps avoid decision paralysis by letting the app tell the user what to do next, and reduces overwhelming feelings caused by seeing a long list.

Possible edge case users: 
 - People applying to jobs who want a streamlined way to keep track
 - Used as a project planner for work / way for people to timeblock their workday

[See feature documentation for more info](./app/doc/development.md)(Work in Progress)
                                                  <br><br>
                    <img src="assets/images/791227AB-0F84-42C9-9EE3-0BA462397545.png" width="300" height="300">
                    
## Purpose

The purpose of the backend for the OnTrack app is to support the overall functionality and effectiveness of the front end application. Here are some key purposes of the backend in relation to the project:

<b><u>Data management:</u></b> The backend serves as the central hub for storing, organizing, and managing the data associated with tasks, AI generated task breakdowns, and upcoming holiday information. It provides the necessary infrastructure, database, and endpoints for the front end app.

<b><u>User-generated content management:</u></b> The backend handles the CRUD functionality of tasks and ensures efficient data handling and metadata management. The backend enables users to manage their tasks and upload photos, enriching the platform's content and helping its users.

Overall, the purpose of the back end in the OnTrack app is to support seamless data management, photo management, and AI task prompts. It plays a vital role in ensuring the app's functionality, security, and user satisfaction, ultimately enhancing the daily lives of its users.

## Built With
* ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
* ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
* ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
* ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
* ![Heroku](https://img.shields.io/badge/heroku-%23430098.svg?style=for-the-badge&logo=heroku&logoColor=white)
* ![Postman Badge](https://img.shields.io/badge/Postman-FF6C37?logo=postman&logoColor=fff&style=for-the-badge)




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
    get 'api/v1/users/:user_id/tasks' - A user's task index 
    post 'api/v1/users/:user_id/tasks - Create a task for a specific user
    patch 'api/v1/users/:user_id/tasks/:id - Edit a user's task
    get 'api/v1/users/:user_id/tasks/:id' - User task show page
    delete 'api/v1/users/:user_id/tasks/:id - Delete a user's task
    get 'api/v1/users/:user_id/daily_tasks - A user's daily tasks by mood
    get 'api/v1/holidays' - Gets upcoming holidays
    get 'api/v1/chat_service' - AI breakdown of a task
    get 'api/v1/users/:user_id/calendar_events' - Gets upcoming Google Calendar events
    </code>
  </pre>
</div>

## Response
```
Task Response:
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


AI Response:
 "response": [
  {
          "text": ""1. Research catio designs and gather inspiration.\n2. Create a detailed plan and layout for the catio.\n3. Purchase necessary materials and tools.\n4. Build the frame and structure of the catio.\n5. Install fencing, shelves, and perches inside the catio."
      }
   ]


Holiday Response:
  {
 "data": [
        {
            "type": "holiday",
            "attributes": {
                "name": "Columbus Day",
                "date": "2023-10-09"
            }
        },
        {
            "type": "holiday",
            "attributes": {
                "name": "Veterans Day",
                "date": "2023-11-10"
            }
        },
        {
            "type": "holiday",
            "attributes": {
                "name": "Thanksgiving Day",
                "date": "2023-11-23"
            }
        }
    ]
}


Calendar Events Response:
{"data"=>
  [{"type"=>"Calendar Event",
    "attributes"=>{"name"=>"TEST EVENT 1", "start_date"=>"09/26/2023 14:30:00", "description"=>"Better do the thing!"}},
   {"type"=>"Calendar Event",
    "attributes"=>{"name"=>"TEST EVENT 2", "start_date"=>"09/28/2023 14:30:00", "description"=>"So cool if this works"}}]}


Error Response:
{
errors: [
              {
                detail: "Validation failed: Name can't be blank, category can't be blank"
              }
            ]
}
```

## Schema
```
create_table "tasks", force: :cascade do |t|
  t.string "name"
  t.integer "category"
  t.boolean "mandatory"
  t.string "event_date"
  t.integer "frequency", default: 0
  t.integer "time_needed"
  t.integer "user_id"
  t.string "notes"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.datetime "completed"
  t.boolean "skipped", default: false
  t.string "image_url"
```

## Contributing  [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/ontrack-2305/ontrack_be/issues)
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

## Thoughts for future contributions:
- Users can register/log in without using a google account
- Use of time_needed attribute;
  - Can calculate user's time spent on certain activities and report them after a certain point of time. Ex: "You've spent 80 hours learning guitar this year!"
  - AND/OR, the back end algorithm that chooses daily tasks will max out at a certain limit. Ex: User is given tasks that will take two hours total on bad days.
  - This attribute currently exists in the front end Task poro and the back end schema, but functionality to make use of it has not been integrated at this time
- Upcoming birthday notifications
- Screen reader friendly
- Refactor to have all tables on the back end
- Choose which holidays a user can be reminded about
- Choose different country holidays
- Link holidays and events to people: "Mother's Day, send Mom something"
- Language translation
- Standalone app
- Task templates
- Allow users to customize text colors and backgrounds - Promotes inclusivity for color blindness
- "I'm bored" feature that can suggest new hobbies or activities based on previous user input

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

## API's Used
[![Google](https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white) ](https://developers.google.com/maps)<br>
[![OpenAI Badge](https://img.shields.io/badge/OpenAI-412991?logo=openai&logoColor=fff&style=for-the-badge)](https://platform.openai.com/)<br>
Holidays API: "https://date.nager.atApi/v3/NextPublicHolidays/US"

## EQUITY ANALYSIS
- The intended users of OnTrack are individuals with executive dysfunction or related disorders. Our design choices prioritize their unique needs and challenges.
- While our primary user base includes individuals with executive dysfunction or related disorders, we recognize that these users may belong to diverse identity groups. We are dedicated to ensuring inclusivity for all.
- We understand that factors such as internet connectivity and device compatibility can impact access. We are actively working to minimize these barriers to ensure a wider reach. By maintaining a web application users can use public access such as libraries to use our product.
- Given more time, we plan to collaborate closely with our intended users through interviews, surveys, and usability testing to continually improve and tailor the application to their evolving requirements.
- To prevent misuse of our product, we would like to implement reporting mechanisms and community guidelines. We are committed to maintaining a safe and welcoming environment for all users.

## Security Considerations

While we have taken measures to ensure the security and privacy of user data, it's important to acknowledge potential security issues that may arise. One such issue to be aware of is related to URL manipulation in the backend of our Service-Oriented Architecture (SOA) application.

**URL-Based Task Access:**
In the current implementation, the task show method in the backend retrieves tasks based on the task ID, regardless of the user ID passed through the URL. While this approach works as expected and efficiently retrieves tasks, it raises a potential security concern.

**Security Implication:**
Since task IDs are unique, it's unlikely that two users will have tasks with the same ID. However, this design allows anyone with knowledge of the system to manipulate the URL by manually inputting random user IDs and incrementing numbers in the URL until they discover a valid task. This task will then be displayed with the actual user's ID.

**Mitigation Steps:**
For the Minimum Viable Product (MVP) phase, we have prioritized other development aspects over this issue. However, as we continue to enhance and refine our application, we plan to address this potential security concern by implementing additional access control mechanisms. These mechanisms will ensure that only authorized users can access specific tasks and data.

While we acknowledge this security concern, we are actively working on improving the security of our application to provide a safe and secure user experience. We appreciate your understanding as we continue to enhance the system's security features.


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