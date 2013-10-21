all routes (/api/v1)

      get '/get_token'
      post '/register'

      #taxi related APIs
      get '/get_taxi'
      post '/rate_taxi'
      get '/ratings_summary'
      get '/get_ratings'

      #item related APIs
      get '/myreports'
      get '/my_lost_and_found'
      get '/allreports'
      post '/report_lost'
      post '/report_found'
      post '/resolve_item'
      post '/update_item'
      post '/delete_item'

======

GET "/api/v1/get_token?username=<username>&password=<password>"

    {
      auth_token: "YhzNCqUE4g4K4A9x4Rve",
      success: true
    }

POST '/api/v1/register'

    form-data
    {
      username: <username>
      plate_no: <plate_no>
      first_name: <first_name> optional
      last_name: <last_name> optional
      email: <email> optional
      phone: <phone> optional
    }
    response
    auth_token


GET "/api/v1/get_taxi?plate_no=<plate_no>"

-ratings limited to 10

    {
      data: {
            ratings: [
                {
                  comment: null,
                  timestamp: 1381224719,
                  rating: 1
                }
              ],
              likes: 1,
              dislikes: 0,
              neutral: 0,
              taxi: {
                id: 1,
                plate_no: "สย1234",
                owner: null,
                color: null,
                created_at: "2013-10-08T09:29:29.000Z",
                updated_at: "2013-10-08T09:29:29.000Z"
              },
              reported_lost_items: 3
            },
      success: true
    }

POST "/api/v1/rate_taxi"

    form-data
    {
      auth_token: <auth_token>
      plate_no: <plate_no>
      comment: <comment>
      vote: <-1,0,1>
    }

GET "/api/v1/myreports?auth_token=<auth_token>"

    {
    success: true,
    data: {
          found_items: [
            {
              id: 3,
              returned: false,
              location: "here",
              when: "2001-02-02T21:05:06.000Z",
              description: null,
              user_id: null,
              created_at: "2013-10-08T09:34:14.000Z",
              updated_at: "2013-10-08T09:34:14.000Z",
              item_name: "aaaaaaaaaaá",
              plate_no: "สย1234",
              taxi_description: "adsfasdf",
              contact: "adsfasdf",
              taxi_id: 1
            }
          ],
          lost_items: [
            {
              id: 1,
              returned: false,
              location: "here",
              when: "2001-02-02T21:05:06.000Z",
              description: null,
              user_id: null,
              created_at: "2013-10-08T09:29:29.000Z",
              updated_at: "2013-10-08T09:29:29.000Z",
              item_name: "aaaaaaaaaaá",
              plate_no: "สย1234",
              taxi_description: "adsfasdf",
              contact: "adsfasdf",
              taxi_id: 1
            }
          ]
          }
    }

GET "/api/v1/ratings_summary?limit=<limit, default =5, max = 20>

    {
    success: true,
    data: {
      highest_rated: [
        {
          id: 14,
          plate_no: "ถม78",
          owner: null,
          color: null,
          average_rating: 1
        },
        {
          id: 13,
          plate_no: "คร842",
          owner: null,
          color: null,
          average_rating: 0.48
        }
      ],
      lowest_rated: [
        {
          id: 18,
          plate_no: "วฃ525",
          owner: null,
          color: null,
          average_rating: -0.5
        },
        {
          id: 25,
          plate_no: "8บฏ58",
          owner: null,
          color: null,
          average_rating: -0.5
        }

      ],
      most_popular: [
        {
          id: 6,
          plate_no: "8ตอ736",
          owner: null,
          color: null,
          average_rating: 0
        },
        {
          id: 14,
          plate_no: "ถม78",
          owner: null,
          color: null,
          average_rating: 1
        }
      ]
      }
    }

GET '/api/v1/get_ratings?plate_no=<plate_no>&last_timestamp=<last_timestamp (optional)>'

- return ratings before time 'last_timestamp' or 10 latest ratings

    {
      success: true,
      data: [
        {
          comment: "heyhey",
          timestamp: 1382355186,
          rating: 0
        },
        ...
      ]
    }


GET '/api/v1/myreports'

- all report made by user

GET '/api/v1/my_lost_and_found'

- all lost and found by user, mixed together

GET '/api/v1/allreports'

- all recent reports

GET '/api/v1/allreports?last_timestamp=<last_timestamp>'

- report before last_timestamp

get '/api/v1/my_lost_and_found'

- report the user has made

    {
      success: true,
      data: {
        lost_and_found: [
          {
          id: 3,
          returned: false,
          location: "here",
          when: "2001-02-02T21:05:06.000Z",
          description: null,
          user_id: null,
          created_at: "2013-10-08T09:34:14.000Z",
          updated_at: "2013-10-08T09:34:14.000Z",
          item_name: "aaaaaaaaaaá",
          plate_no: "สย1234",
          taxi_description: "adsfasdf",
          contact: "adsfasdf",
          taxi_id: 1,
          item_type: null
          }, ...
        ]
      }
    }


POST "/api/v1/report_lost"

    form-data
    {
      auth_token: <auth_token>
      item_name: <item_name>
      location: <location>
      plate_no: <plate_no>
      taxi_description: <description>
      contact: <contact>
      time_lost: <iso8601 format e.g. "2001-02-03T04:05:06+07:00">
    }

POST "/api/v1/report_found"

    form-data
    {
      auth_token: <auth_token>
      item_name: <item_name>
      location: <location>
      plate_no: <plate_no>
      taxi_description: <description>
      contact: <contact>
      time_found: <iso8601 format e.g. "2001-02-03T04:05:06+07:00">
    }

POST "/api/v1/resolve_item"

    form-data
    {
      item_id: <item_id e.g. 1>
    }

POST "/api/v1/update_item"

    form-data
    available keys - 

    - item_name
    - item_desc
    - location
    - plate_nom
    - taxi_description
    - contact

POST "/api/v1/delete_item"
-anyone can delete anyone's item right now

    form-data
    {
      item_id: <item_id e.g. 1>
    }
