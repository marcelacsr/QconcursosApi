# README

#### How to run (Docker Compose)
Prerequisites: 
- Docker
- Docker Compose

With docker we can build the app.
The following command will build 
the application image and MySQL 
instance, and start a container 
for the API, which will run on 
port 3000.
```
docker-compose up
```
The app will load the json files from:
- [question_access.json](https://raw.githubusercontent.com/qcx/desafio-backend/master/question_access.json)
- [questions.json](https://github.com/qcx/desafio-backend/blob/master/questions.json)

#### Tests

Run tests with the following command, coverage can be found inside '../coverage'  
after the test suite has been run and is currently at **100%**.  
Inside container's BASH(`docker-compose run --rm app bash`) run:
```
RAILS_ENV=test rails db:create
rails db:test:prepare
rspec
```

### API endpoints
- Most accessed question's disciplines in the last 24 hours 


1. http://localhost:3000/questions
```
[
    {
        "discipline": "geografia",
        "daily_access": 6242
    },
    {
        "discipline": "literatura",
        "daily_access": 5149
    },
    {
        "discipline": "raciocínio lógico",
        "daily_access": 5134
    },
    {
        "discipline": "direito constitucional",
        "daily_access": 4967
    },
    {
        "discipline": "legislação federal",
        "daily_access": 4850
    },
    {
        "discipline": "inglês",
        "daily_access": 4795
    },
    {
        "discipline": "direito civil",
        "daily_access": 4763
    },
    {
        "discipline": "estatística",
        "daily_access": 4540
    },
    {
        "discipline": "matemática",
        "daily_access": 3944
    },
    {
        "discipline": "português",
        "daily_access": 3527
    }
]
```

- Most accessed questions: 

by week/month/year


2. Year params: http://localhost:3000/question_accesses?year=2019
```
[
    {
        "question_id": 5,
        "times_accessed": 2049999
    },
    {
        "question_id": 10,
        "times_accessed": 2463433
    },
    {
        "question_id": 25,
        "times_accessed": 2376567
    },
    {
        "question_id": 28,
        "times_accessed": 2174191
    },
    {
        "question_id": 30,
        "times_accessed": 4465672
    },    
     ...
]
```
3. Month params: http://localhost:3000/question_accesses?month=2019-07
````
[
    {
        "question_id": 5,
        "times_accessed": 175529
    },
    {
        "question_id": 10,
        "times_accessed": 201470
    },
    {
        "question_id": 25,
        "times_accessed": 49544
    },
    {
        "question_id": 28,
        "times_accessed": 127022
    },
    {
        "question_id": 30,
        "times_accessed": 205877
    }, ...
]
````
4. Week params: http://localhost:3000/question_accesses?week=2019-07-20
```
[
    {
        "question_id": 229,
        "times_accessed": 99651
    },
    {
        "question_id": 327,
        "times_accessed": 33581
    },
    {
        "question_id": 568,
        "times_accessed": 3466
    },
    {
        "question_id": 764,
        "times_accessed": 25876
    },
    {
        "question_id": 795,
        "times_accessed": 33308
    }, ...
]
```
5. All params: http://localhost:3000/question_accesses?year=2019&month=2019-07&week=2019-07-20
```
[
    {
        "question_id": 5,
        "times_accessed": 2049999
    },
    {
        "question_id": 10,
        "times_accessed": 2463433
    },
    {
        "question_id": 25,
        "times_accessed": 2376567
    }, ...
]

```
