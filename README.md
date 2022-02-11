# Simple Weight Tracker

- Server was built using **Express.js** written in **Typescript**.  
- Model View Controller system followed.
- Routes were Authenticated using **JWT tokens**. 
- Client was built using **React** 

# How to run

Ensure that you have docker engine and docker-compose installed.

Then, simply run the following command:
```
docker-compose up
```

This will install all the necessary dependencies and start a container for both the server and client.

The server is located at http://localhost:3000.

The client application link will be displayed in the shell once the container is running:

```
You can now view react-weight-tracker in the browser.
   Local:            http://localhost:5000
   On Your Network:  http://172.18.0.4:5000
```
In this case, the client application is running at http://172.18.0.4:5000.

# Backend routes
The backend has two different types of routes under the `/user` (public) route and the `/weight` (protected) route
## User routes
These are public and don't need any authorization tokens.

### POST `/user/sign_up`
```json
body: {
  username: "test",
  password: "password"
}

```
returns a message confirming user registration into the database.


### POST `/user/login`
```json
body :{
  username: "test",
  password: "password"
}

```
returns a **JWT** authorization token if successfully logged in.

## Weight routes
These are private and need a **JWT** token in the headers as follows:

```json
headers: {
  "x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMDRmMThmYWM0YzBlMDA0ODkyODdkOCIsInVzZXJuYW1lIjoidGVzdCIsImlhdCI6MTY0NDQ5MTg2MiwiZXhwIjoxNjQ0NDkzNjYyfQ.YVP1su_nKanMquPYfnfSAt60L4_t77dnqssv4Js6q7I"
}
```

### POST `/weight/save_weight`
```json
body :{
  userID: "6204f18fac4c0e00489287d8",
  weight: 50
}

```
userID links the weight record to a user in the database.
returns a success message with the created weight object in JSON.

### PUT `/weight/update_weight`
```json
body :{
  _id: "6204f4a8b898d200d20fe5c6",
  weight: 50
}

```
_id refers to the id of the weight record in the database.
returns a success message with the updated weight object in JSON.

### POST `/weight/delete_weight`
```json
body :{
  _id: "6204f4a8b898d200d20fe5c6",
}

```
_id refers to the id of the weight record in the database.
returns a success message confirming the deletion of the weight record in the database.

### POST `/weight/get_weight_history`
```json
params :{
  userID: "6204f4a8b898d200d20fe5c6",
}

```
userID refers to a user in the database.
returns an array of weight records linked to the userID

# Frontend/client
The frontend consists of three pages - a sign up page, login page and the weight tracker page.

Register in the sign up page and log in to get acess to the weight tracker.

Type a weight and hit save to add a record to the database.

You can also edit and update the weight values displayed.